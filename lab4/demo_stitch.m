im1 = 'boat1.pgm';
im2 = 'boat2.pgm';
stitched_image = stitch(im1, im2);
figure(1);
imshow(stitched_image);

im1 = 'right.jpg';
im2 = 'left.jpg';
stitched_image = stitch(im1, im2);
figure(2);
imshow(stitched_image);