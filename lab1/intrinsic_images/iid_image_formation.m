alb=imread('ball_albedo.png');
shad=imread('ball_shading.png');

alb_double=im2double(alb);
shad_double=im2double(shad);

original_double=alb_double.*cat(3,shad_double, shad_double, shad_double);
original=im2uint8(original_double);

subplot(2,2,1)

imshow('ball.png');
title('original picture');

subplot(2,2,2)
imshow('ball_albedo.png');
title('albedo')

subplot(2,2,3)
imshow('ball_shading.png');
title('shade')

subplot(2,2,4)
imshow(original);
title('reconstructed')