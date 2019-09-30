function [] = demo_opt_flow()

im1=imread('sphere1.ppm');
im2=imread('sphere2.ppm');
image1=rgb2gray(im1);
image2=rgb2gray(im2);

%Getting the optical flow with 15*15 windows
opt_flow=lucas_kanade(image1,image2,15);

%Transforming the opt_flow cells to vectors px, py (these will be the arrows on the plot)
px=zeros(13);
py=zeros(13);

for i=1:13
    for j=1:13
        temp=opt_flow{i,j};
        px(i,j)=temp(1);
        py(i,j)=temp(2);
    end
end



%Getting the coordinates for the centers of subpictures. We will display
%the arrows at these points.
[x,y]=meshgrid(8:15:188);

%Plotting
subplot(1,2,1);

quiver(x,y,px,py);
axis image
hax=gca; %To get the sizes of the figure

image(hax.XLim,hax.YLim,im1);
hold on;
quiver(x,y,px,py);
axis equal;
hold off;   %This code I found on the internet. This was the only way I was able to plot the arrows on the original image.


%For the pther pictures
im1=imread("synth1.pgm");
im2=imread("synth2.pgm");
image1=cat(3,im1,im1,im1);
image2=cat(3,im2,im2,im2);


opt_flow=lucas_kanade(im1,im2,15);
px=zeros(floor(128/15));  %The size of these images are 128*128
py=zeros(floor(128/15));

for i=1:floor(128/15)
    for j=1:floor(128/15)
        temp=opt_flow{i,j};
        px(i,j)=temp(1);
        py(i,j)=temp(2);
    end
end

[x,y]=meshgrid(8:15:113);

subplot(1,2,2);
quiver(x,y,px,py);
axis image
hax=gca; %To get the sizes of the figure

image(hax.XLim,hax.YLim,image1);
hold on;
quiver(x,y,px,py);
axis equal;
hold off; 


end