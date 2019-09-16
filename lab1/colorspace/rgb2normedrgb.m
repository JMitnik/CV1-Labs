function [output_image] = rgb2normedrgb(input_image)
% converts an RGB image into normalized rgb
[r,g,b] = imsplit(input_image);
rn = (r)./(r+g+b);
bn = (b)./(r+g+b);
gn = (g)./(r+g+b);
output_image = cat(3, rn, bn, gn);
end

