function [keypoint_matchings] = keypoint_matching(im1, im2)
%keypoint_matching - Description
%
% Syntax: keypoint_matching = keypoint_matching(input)
%
% Long description
    im1 = imread('boat1.pgm');
    im2 = imread('boat2.pgm');

    [fa, da] = vl_sift(single(im1));
    [fb, db] = vl_sift(single(im2));
    [matches, scores] = vl_ubcmatch(da, db);

    % figure(1);
    % imshow(im1); hold on;
    % scatter(fa(1,matches(1,:)), fa(2,matches(1,:)), 50, 'filled','b'); hold off;
    % figure(2);
    % imshow(im2); hold on;
    % scatter(fb(1,matches(2,:)), fb(2,matches(2,:)), 50, 'filled','b'); hold off;

    big_img = cat(2,im1,im2);
    imshow(big_img); hold on;
    x1 = fa(1,matches(1,1:2));
    y1 = fa(2,matches(1,1:2));
    x2 = fb(1,matches(2,1:2))+size(im1,2);
    y2 = fb(2,matches(2,1:2));
    scatter(x1, y1, 50, 'filled','b');
    scatter(x2, y2, 50, 'filled','b');
    for i = 1:size(x1)
        hold on;
        plot([x1(i) x2(i)], [y1(i) y2(i)]);
        hold off;
    end
end
