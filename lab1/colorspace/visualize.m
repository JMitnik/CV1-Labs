function visualize(input_image)
[~,~,~,channels] = size(input_image);
if channels == 3
    [a,b,c] = imsplit(input_image);
    montage({input_image,a,b,c}, 'Size', [1 4])
elseif channels == 4
    gray = input_image(:,:,1);
    lgt = input_image(:,:,2);
    avg = input_image(:,:,3);
    lum = input_image(:,:,4);
    montage({gray,lgt,avg,lum}, 'Size', [1 4])
end