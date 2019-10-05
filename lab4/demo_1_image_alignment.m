% Read in the images
% ? Do we turn these into singles here already?
im1 = imread('boat1.pgm');
im2 = imread('boat2.pgm');

% Extract the keypoint matchings between the two images
keypoint_matchings = keypoint_matching(im1, im2);

% Select set_size random samples from keypoint_matchings,
% and plot these on the image.
sampled_keypoint_matchings = sample_keypoint_matchings(keypoint_matchings, 10);

figure(1);
plot_matches(im1, im2, sampled_keypoint_matchings);

% Perform RANSAC and get the best transformation (?)
default_N = 10;
default_P = 10;
radius_size = 10;
best_transformation = RANSAC(keypoint_matchings, im1, im2, default_N, default_P, radius_size, false);

% Perform transformation from im1 to im2, and back (im2 to im1)
T = [best_transformation(1), best_transformation(3),0
    best_transformation(2), best_transformation(4), 0
    best_transformation(5), best_transformation(6), 1];
transformation = affine2d(T);

figure(2);
im1_to_im2 = imwarp(im1, transformation);
imshow(im1_to_im2);
title('Image 1 transformed to image 2');

figure(3);
im2_to_im1 = imwarp(im2, invert(transformation));
imshow(im2_to_im1);
title('Image 2 transformed to image 1');