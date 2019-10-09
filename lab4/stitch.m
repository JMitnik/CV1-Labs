function [stitched_image] = stitch(im1, im2)
%stitch - Description
%
% Syntax: [stitched_image] = stitch(im1, im2)
%
% Long description

    im1 = imread(im1);
    im2 = imread(im2);
    im_x = im2double(im1);
    im_y = im2double(im2);
    if size(im1,3) == 3 && size(im2,3) == 3 
        im_x = im2double(im1);
        im_y = im2double(im2);     
        im1 = rgb2gray(im1);
        im2 = rgb2gray(im2);
    end
    % im2 = imresize(im2,size(im1));

    [fa, da] = vl_sift(single(im1), 'PeakThresh', 0);
    [fb, db] = vl_sift(single(im2), 'PeakThresh', 0);
    [matches, scores] = vl_ubcmatch(da, db);

    x1 = fa(1,matches(1,:));
    y1 = fa(2,matches(1,:));
    x2 = fb(1,matches(2,:));
    y2 = fb(2,matches(2,:));
    keypoint_matchings = [x1; y1; x2; y2];
    default_N = 10;
    default_P = min(20, length(keypoint_matchings));
    radius_size = 10;
    best = RANSAC(keypoint_matchings, im1, im2, default_N, default_P, radius_size, false);

    % Transform    
    % T = [best(1), best(3),0
    %  best(2), best(4), 0
    %  best(5), best(6), 1];
    % transformation = affine2d(T);
    % im_x_trans = create_transformed_image(im1, T^-1);
    m = [best(1), best(2); best(3), best(4)];
    t = [best(5); best(6)];
    for x = 1:1:size(im_x, 2)
        for y = 1:1:size(im_x, 1)
            points = round(m*[x; y] + t);
            if points(1) > 0 && points(2) > 0
                im_x_trans(points(2), points(1), :) = im_x(y, x, :);
            end
        end
    end

    % enlarging the canvas to accomodate out of frame transformations
    delta_width = size(im_x_trans,1) - size(im_y,1);
    delta_height = size(im_x_trans,2) - size(im_y,2); 
    pad_x = [max(-delta_width,0) max(-delta_height,0)];
    pad_y = [max(delta_width,0) max(delta_height,0)];
    im_x_trans = padarray(im_x_trans, pad_x, 'post');
    im_y = padarray(im_y, pad_y, 'post');

    % Stitch
    for x = 1:1:size(im_y, 1)
        for y = 1:1:size(im_y, 2)
            if im_y(x, y) == 0
                I_xy(x, y, :) = im_x_trans(x, y, :);
            else
                I_xy(x, y, :) = im_y(x, y, :);
            end
        end
    end
    stitched_image = I_xy;

end
