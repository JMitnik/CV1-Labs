% Read in the images
im1 = imread('boat1.pgm');
im2 = imread('boat2.pgm');

% Extract the keypoint matchings between the two images
keypoint_matchings = keypoint_matching(im1, im2);

% Select set_size random samples from keypoint_matchings,
% and plot these on the image.

% Perform RANSAC and get the best transformation (?)


% Perform transformation from im1 to im2, and back (im2 to im1)

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
