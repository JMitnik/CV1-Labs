function [stitched_image] = stitch(im1, im2)
%stitch - Description
%
% Syntax: [stitched_image] = stitch(im1, im2)
%
% Long description

    im1 = imread(im1);
    im2 = imread(im2);
    if size(im1,3) == 3 && size(im2,3) == 3 
        im1 = rgb2gray(imread(im1));
        im2 = rgb2gray(imread(im2));
    end

    [fa, da] = vl_sift(single(im1), 'PeakThresh', 0);
    [fb, db] = vl_sift(single(im2), 'PeakThresh', 0);
    [matches, scores] = vl_ubcmatch(da, db);

    x1 = fa(1,matches(1,:));
    y1 = fa(2,matches(1,:));
    x2 = fb(1,matches(2,:));
    y2 = fb(2,matches(2,:));
    keypoint_matchings = [x1; y1; x2; y2];
    default_N = 10;
    default_P = 10;
    radius_size = 10;
    best = RANSAC(keypoint_matchings, im1, im2, default_N, default_P, radius_size, false);
    
    % Transform
    Ia = im2double(im1);
    Ib = im2double(im2);
    m = [best(1), best(2); best(3), best(4)];
    t = [best(5); best(6)];
    for x = 1:1:size(Ia, 2)
        for y = 1:1:size(Ia, 1)
            points = round(m*[x; y] + t);
            if points(1) > 0 && points(2) > 0
                Ia_trans(points(2), points(1), :) = Ia(y, x, :);
            end
        end
    end

    % enlarging the canvas to accomodate out of frame transformations
    delta_width = size(Ia_trans,1) - size(Ib,1);
    delta_height = size(Ia_trans,2) - size(Ib,2); 
    pad_a = [max(-delta_width,0) max(-delta_height,0)];
    pad_b = [max(delta_width,0) max(delta_height,0)];
    Ia_trans = padarray(Ia_trans, pad_a, 'post');
    Ib = padarray(Ib, pad_b, 'post');

    % Stitch
    for x = 1:1:size(Ib, 1)
        for y = 1:1:size(Ib, 2)
            if Ia_trans(x, y) == 0
                I_ab(x, y, :) = Ib(x, y, :);
            else
                I_ab(x, y, :) = Ia_trans(x, y, :);
            end
        end
    end
    stitched_image = I_ab;

end
