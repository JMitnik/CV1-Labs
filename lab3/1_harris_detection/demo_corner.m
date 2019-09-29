sigma = 1;
neighbors = 10;

Img1 = imread('../person_toy/00000001.jpg');
threshold = 0.05;
[H, r, c] = HarrisCornerDetector(Img1, sigma, neighbors, threshold, 0);
figure;
imshow(Img1); hold on;
scatter(c, r, 30, 'y');
title("Sample: Person Toy"); hold off;

Img2 = imread('../pingpong/0000.jpeg');
threshold = 0.2;
[H, r, c] = HarrisCornerDetector(Img2, sigma, neighbors, threshold, 0);
figure;
imshow(Img2); hold on;
scatter(c, r, 30, 'y');
title("Sample: Pingpong"); hold off;   

Img3 = imrotate(Img1, 90);
threshold = 0.05;
[H, r, c] = HarrisCornerDetector(Img3, sigma, neighbors, threshold, 0);
figure;
imshow(Img3); hold on;
scatter(c, r, 30, 'y');
title("Sample: Person Toy [Rotated 90]"); hold off;

Img4 = imrotate(Img1, 45);
threshold = 0.05;
[H, r, c] = HarrisCornerDetector(Img4, sigma, neighbors, threshold, 0);
figure;
imshow(Img4); hold on;
scatter(c, r, 30, 'y');
title("Sample: Person Toy [Rotated 45]"); hold off;
