% INSERT CODE HERE

PATH_TO_IMG_FOLDER = '../pingpong';
SIGMA= 1;
NEIGHBOURS = 10;
THRESHOLD = 0.05;

I1 = imread(fullfile(PATH_TO_IMG_FOLDER, '0001.jpeg'));
I2 = imread(fullfile(PATH_TO_IMG_FOLDER, '0002.jpeg'));
[H, r, c] = HarrisCornerDetector(I1, SIGMA, NEIGHBOURS, THRESHOLD, 0);

optical_flow = lucas_kanade(I1, I2, 15);

% Using the optical flow, use coordinates r,c = (y,x) to find the points
% where the optical_flow starts from Lucas_Kanade.

% Then, the points on image-2 will be the next starting points.

% On image 3, we will again calcualte the optical-flow, and map the points
% from image-2 to image 3.

% For each of these, we write an image with scatter points to a frame. Each
% of these frames will eventually be put into a VideoWriter