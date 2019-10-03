function [keypoint_matchings] = keypoint_matching(im1, im2)
%keypoint_matching - Description
%
% Syntax: keypoint_matching = keypoint_matching(input)
    % Extract features and descriptors from both images, and their matching
    % indices and distance in scores.
    [fa, da] = vl_sift(single(im1));
    [fb, db] = vl_sift(single(im2));
    [matches, scores] = vl_ubcmatch(da, db);

    % Extract the (x,y) coordinates from the matches (shift the x for the
    % right image to fall on the right side of the joined-image)
    x1 = fa(1,matches(1,:));
    y1 = fa(2,matches(1,:));
    x2 = fb(1,matches(2,:))+size(im1,2);
    y2 = fb(2,matches(2,:));

    % Keypoint matchings have 4 rows, row1 being the x-coordinates of image1, row2 being
    % the y-coordinates of image1, row3 being the x-coordinates of image2, and
    % row4 being the y-coordinates of image2
    keypoint_matchings = [x1; y1; x2; y2];
end
