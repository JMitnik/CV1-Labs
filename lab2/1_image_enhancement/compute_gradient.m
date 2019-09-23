function [Gx, Gy, im_magnitude,im_direction] = compute_gradient(image)

% Define the Sobel kernels
sobelX = [1 0 -1; 2 0 -2; 1 0 -1];
sobelY = sobelX';

% Apply the kernels to the image and get Gx, Gy, magnitude and direction
Gx = imfilter(image, sobelX, 'conv');
Gx = rescale(Gx, 0, 255);
Gy = imfilter(image, sobelY, 'conv');
Gy = rescale(Gy, 0, 255);

im_magnitude = round(hypot(double(Gx), double(Gy)));
im_magnitude (isnan(im_magnitude)) = 0;
im_direction = round(rescale(atan(double(Gy./Gx)), 0, 255));
im_direction (isnan(im_direction)) = 0;
%D Display the results
figure(1);
imshowpair(Gx, Gy, 'montage');
title('Directional Gradients Gx and Gy, Using Sobel Method');

figure(2);
imshowpair(im_magnitude, im_direction, 'montage');
title('Gradient Magnitude and Direction per Pixel');


end

