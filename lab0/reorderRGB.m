function reorderRGB(image_path)

OG_image = imread(image_path);
[red, green, blue] = imsplit(OG_image);
reordered_image = cat(3, blue, green, red);

subplot(2,1,2);
imshow(reordered_image);

subplot(2,1,1);
imshow(OG_image);
end
