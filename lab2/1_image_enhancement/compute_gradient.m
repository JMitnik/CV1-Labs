function [Gx, Gy, im_magnitude,im_direction] = compute_gradient(image)

sobelX = [1 0 -1; 2 0 -2; 1 0 -1];
sobelY = sobelX';

Gx = imfilter(image, sobelX, 'conv');
Gy = imfilter(image, sobelY, 'conv');
im_magnitude = hypot(double(Gx), double(Gy));
im_direction = atan(double(Gy./Gx));

figure(1);
imshowpair(Gx, Gy, 'montage');
title('Directional Gradients Gx and Gy, Using Sobel Method');

figure(2);
imshowpair(im_magnitude, im_direction, 'montage');
title('Gradient Magnitude and Direction per Pixel');


end

