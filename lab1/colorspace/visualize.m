function visualize(input_image)
[a,b,c] = imsplit(input_image);
montage({input_image,a,b,c}, 'Size', [1 4])
end