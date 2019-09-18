alb=imread('ball_albedo.png');
shad=imread('ball_shading.png');

%Recoloring: We set the red and blue channels of shad to zero and the green
%to 255

alb(:,:,1)=zeros(size(alb(:,:,1)));
alb(:,:,3)=zeros(size(alb(:,:,1)));

[row,column]=size(alb(:,:,2));

for i=1:row
    for j=1:column
        if alb(i,j,2)~=0
            alb(i,j,2)=255;
        end
    end
end

alb_double=im2double(alb);
shad_double=im2double(shad);

recolored_double=alb_double.*cat(3,shad_double, shad_double, shad_double);
recolored=im2uint8(recolored_double);

subplot(1,2,1);
imshow('ball.png');
title('original picture');

subplot(1,2,2);
imshow(recolored);
title('recolored picture');