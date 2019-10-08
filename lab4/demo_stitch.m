%Reading in and transforming the pictures to the same sizes

%Comment this if to see the boat pictures
left=rgb2gray(imread("left.jpg"));
right=rgb2gray(imread("right.jpg"));
right=(imresize(right,size(left)));

im1=left;
im2=right;

%Uncomment this to see the relatively well working pictures of the boats
%im1=imread("boat1.pgm");
%im2=imread("boat2.pgm");

%Plotting the matches
keypoint_matchings=keypoint_matching(im1,im2);
mathces=sample_keypoint_matchings(keypoint_matchings,10);
plot_matches(im1,im2,mathces);

%This is Jonathan's code
default_N = 10;
default_P = 10;
radius_size = 10;
best_transformation = RANSAC(keypoint_matchings, im1, im2, default_N, default_P, radius_size, false);

% Perform transformation from im1 to im2, and back (im2 to im1)
T = [best_transformation(1), best_transformation(3),0
    best_transformation(2), best_transformation(4), 0
    best_transformation(5), best_transformation(6), 1];
transformation = affine2d(T);

figure(2);
im1_to_im2 = imwarp(im1, transformation);
imshow(im1_to_im2);
title('Image 1 transformed to image 2');

figure(3);
im2_to_im1 = imwarp(im2, invert(transformation));
imshow(im2_to_im1);
title('Image 2 transformed to image 1');

%As you can see, the transformations are sometimes not invertable and MATLAB gives
%an error, sometimes they are just really bad. Im not sure why it is. Maybe
%because the mathcing feature point pairs are on different sides. In image
%"right.jpg" htey are on the left side, in image "left.jpg" they are on the
%right side.
