function [opt_flow] = lucas_kanade_local(image1,image2,x,y,window_size)
%UNTITLED8 Computes the optical flow with a window_size window centered around pixel x,y 

% Cutting out the subimage
im_part1=image1(x-floor(window_size/2):x+floor(window_size/2),y-floor(window_size/2):y+floor(window_size/2));
im_part2=image2(x-floor(window_size/2):x+floor(window_size/2),y-floor(window_size/2):y+floor(window_size/2));

%Computing A: for this we need the partial derivatives
[derivx,derivy]=imgradientxy(im_part1); %Getting the partial derivatives
Gx=transpose(derivx(1:window_size^2));  %Placing them in column vectors
Gy=transpose(derivy(1:window_size^2));  %Placing them in column vectors
A=[Gx,Gy];
A_tr=transpose(A);

%Computing b: for this we need the time derivatives, now we use the other image
derivt=zeros(window_size);
        
for k=1:window_size
    for l=1:window_size
        derivt(k,l)=im_part1(k,l)-im_part2(k,l);     
    end
end
Gt=transpose(derivt(1:window_size^2));

%Computing the optical flow
opt_flow=linsolve(A_tr*A,A_tr*Gt);
    
end

