function HarrisCornerDetector = myFun(input)
%myFun - Description
%
% Syntax: HarrisCornerDetector = myFun(input)
%
I= imread('../person_toy/00000001.jpg');
% Convert to grey scale first 
I = rgb2gray(I);

sobelX = [1 0 -1; 2 0 -2; 1 0 -1];
sobelY = sobelX';
sigma = 0.5
% Apply first-order Gaussian, aka Sobel filter to find edge in x-dir
I_x = imfilter(I, sobelY, 'conv');
I_x_sq = I_x .^ 2;
A = imgaussfilt(I_x_sq, sigma);
% Apply first-order Gaussian, aka Sobel filter to find edge in y-dir
I_y = imfilter(I, sobelX, 'conv');
I_y_sq = I_y .^ 2;
C = imgaussfilt(I_y_sq, sigma);

I_xy = I_x .* I_y;
B = imgaussfilt(I_xy, sigma);

H = (A .* C - B.^2) - 0.04*(A+C).^2;

figure(1);
imshow(A);
title('I_x');
figure(2);
imshow(C);
title('I_y');

figure(3);
imshow(B);
title('I_{xy}');

figure(4);
imshow(H);
title('H');

end
