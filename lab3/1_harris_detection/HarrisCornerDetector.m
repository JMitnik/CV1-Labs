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
I_x = imfilter(I, sobelX, 'conv');
I_x = I_x .^ 2;
I_x = imgaussfilt(I_x, sigma);

I_y = imfilter(I, sobelY, 'conv');
I_y = I_y .^ 2;
I_y = imgaussfilt(I_y, sigma);

I_xy = I_x .* I_y;
I_xy = imgaussfilt(I_xy, sigma);

figure(1);
imshow(I_x);
title('I_x');
figure(2);
imshow(I_y);
title('I_y');

figure(3);
imshow(I_xy);
title('I_{xy}');

end
