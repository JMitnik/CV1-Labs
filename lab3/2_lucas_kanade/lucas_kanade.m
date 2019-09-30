function [opt_flow] = lucas_kanade(image1,image2,window_size)
%This function computes the optical flow between grayscale images image1 and image2 using
%the Lucas Kanade algorithm. image1 is the image at time t, image2 is at
%time t+dt. This function divides the input image into window_size*window_ pixel
%subimages and computes the optical flow for each of these subimages,
%returning them as a 2D-cell array. Each element of this cell array is a vector (the optical flow) 


[r,c,t]=size(image1); %Getting the size of the image
result_r=floor(r/window_size); %The sizes of the result matrix.
result_c=floor(c/window_size);

%Dividing the image into 15x15 subimages
subimages1=cell([result_r,result_c]);     %Creating a cell array for the subimages of image1. Each element will contain the optic_flow vector for that part of the image
subimages2=cell([result_r,result_c]);     %Creating a cell array for the subimages of image2
opt_flow=cell([result_r,result_c]);




for i=1:result_r
    for j=1:result_c
        subimages1{i,j}=image1((i-1)*window_size+1:i*window_size,(j-1)*window_size+1:j*window_size);
        subimages2{i,j}=image2((i-1)*window_size+1:i*window_size,(j-1)*window_size+1:j*window_size);
        
        %Computing A: for this we need the partial derivatives
        [derivx,derivy]=imgradientxy(subimages1{i,j}); %Getting the partial derivatives
        Gx=transpose(derivx(1:window_size^2));  %Placing them in column vectors
        Gy=transpose(derivy(1:window_size^2));  %Placing them in column vectors
        A=[Gx,Gy];
        A_tr=transpose(A);
        
        %Computing b: for this we need the time derivatives, now we use
        %the other image
        derivt=zeros(window_size);
        
        for k=1:window_size
            for l=1:window_size
                derivt(k,l)=subimages1{i,j}(k,l)-subimages2{i,j}(k,l);
            end
        end
        Gt=transpose(derivt(1:window_size^2));
        
        %Computing the optical flow
        opt_flow{i,j}=linsolve(A_tr*A,A_tr*Gt);
        
       
        
    end
end


end



end

