% Read in the images
% ? Do we turn these into singles here already?
im1 = imread('boat1.pgm');
im2 = imread('boat2.pgm');

% Extract the keypoint matchings between the two images
keypoint_matchings = keypoint_matching(im1, im2);

% Select set_size random samples from keypoint_matchings,
% and plot these on the image.
sampled_keypoint_matchings = sample_keypoint_matchings(keypoint_matchings, 10);
plot_matches(im1, im2, sampled_keypoint_matchings);

% Perform RANSAC and get the best transformation (?)
best_transformation = RANSAC(keypoint_matchings, im1, im2, 10, 10, 10, false);

% Perform transformation from im1 to im2, and back (im2 to im1)

% Scatter all points and plot the lines between the points