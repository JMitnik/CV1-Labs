% --- Experiment I
sigma = 2;
threshold = 0.1;
neighbors = 10;

Img1 = imread('../person_toy/00000001.jpg');
[H, r, c] = HarrisCornerDetector(Img1, sigma, neighbors, threshold, 0);
figure;
imshow(Img1); hold on;
scatter(c, r, 30, 'y');
title("Threshold: 0.1"); hold off;

Img2 = imread('../pingpong/0000.jpeg');
[H, r, c] = HarrisCornerDetector(Img2, sigma, neighbors, threshold, 0);
figure;
imshow(Img2); hold on;
scatter(c, r, 30, 'y');
title("Threshold: 0.1"); hold off;   

% --- Experiment II
sigma = 2;
threshold = 0.05;
neighbors = 10;

Img1 = imread('../person_toy/00000001.jpg');
[H, r, c] = HarrisCornerDetector(Img1, sigma, neighbors, threshold, 0);
figure;
imshow(Img1); hold on;
scatter(c, r, 30, 'y');
title("Threshold: 0.05"); hold off;

Img2 = imread('../pingpong/0000.jpeg');
[H, r, c] = HarrisCornerDetector(Img2, sigma, neighbors, threshold, 0);
figure;
imshow(Img2); hold on;
scatter(c, r, 30, 'y');
title("Threshold: 0.05"); hold off;   

% --- Experiment III
sigma = 2;
threshold = 0.001;
neighbors = 10;

Img1 = imread('../person_toy/00000001.jpg');
[H, r, c] = HarrisCornerDetector(Img1, sigma, neighbors, threshold, 0);
figure;
imshow(Img1); hold on;
scatter(c, r, 30, 'y');
title("Threshold: 0.001"); hold off;

Img2 = imread('../pingpong/0000.jpeg');
[H, r, c] = HarrisCornerDetector(Img2, sigma, neighbors, threshold, 0);
figure;
imshow(Img2); hold on;
scatter(c, r, 30, 'y');
title("Threshold: 0.001"); hold off;   

%--- Experiment IV
sigma = 2;
threshold = 0.05;
neighbors = 10;

Img3 = imrotate(Img1, 90);
[H, r, c] = HarrisCornerDetector(Img3, sigma, neighbors, threshold, 0);
figure;
imshow(Img3); hold on;
scatter(c, r, 30, 'y');
title("Rotation 90"); hold off;

Img4 = imrotate(Img1, 45);
[H, r, c] = HarrisCornerDetector(Img4, sigma, neighbors, threshold, 0);
figure;
imshow(Img4); hold on;
scatter(c, r, 30, 'y');
title("Rotation 45"); hold off;
