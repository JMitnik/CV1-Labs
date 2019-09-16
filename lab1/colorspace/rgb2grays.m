function [output_image] = rgb2grays(input_image)
% converts an RGB into grayscale by using 4 different methods
[r,g,b] = imsplit(input_image);
% ligtness method
lgt = (max(max(r, g), b) + min(min(r, g), b)) / 2;
% average method
avg = (r + g + b) / 3;
% luminosity method
lum = 0.21 * r + 0.72 * g + 0.07 * b;
% built-in MATLAB function 
gray = rgb2gray(input_image);

output_image = cat(3,lgt,avg,lum);
end

