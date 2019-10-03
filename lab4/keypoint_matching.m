function [keypoint_matchings] = keypoint_matching(im1, im2)
%keypoint_matching - Description
%
% Syntax: keypoint_matching = keypoint_matching(input)
    im1 = imread('boat1.pgm');
    im2 = imread('boat2.pgm');

    % Extract features and descriptors from both images, and their matching
    % indices and distance in scores.
    [fa, da] = vl_sift(single(im1));
    [fb, db] = vl_sift(single(im2));
    [matches, scores] = vl_ubcmatch(da, db);

    % Join the two images side-by-side
    joined_img = cat(2,im1,im2);
    imshow(joined_img); hold on;

    % Extract the (x,y) coordinates from the matches (shift the x for the
    % right image to fall on the right side of the joined-image)

    x1 = fa(1,matches(1,:));
    y1 = fa(2,matches(1,:));
    x2 = fb(1,matches(2,:))+size(im1,2);
    y2 = fb(2,matches(2,:));

    % Scatter all points and plot the lines between the points
    scatter(x1, y1, 50, 'filled','b');
    scatter(x2, y2, 50, 'filled','b');
    plot([x1; x2], [y1; y2])

    % Using the for-loop (temporarily commented)
    % hold on
    % for i = 1:length(x1)
    %     plot([x1(i) x2(i)], [y1(i) y2(i)]);
    % end
    % hold off
end
