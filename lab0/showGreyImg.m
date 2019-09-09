function showGreyImg(img_path)
I = imread(img_path);
I_grey = rgb2gray(I);
figure(1);
imshow(I_grey);
end