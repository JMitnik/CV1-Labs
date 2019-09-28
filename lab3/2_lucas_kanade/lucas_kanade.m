function [opt_flow] = lucas_kanade(image1,image2)
%This function computes the optical flow between grayscale images image1 and image2 using
%the Lucas Kanade algorithm. image1 is the image at time t, image2 is at
%time t+dt. This function divides the 200x200 input image into 15x15 pixel
%subimages and computes the optical flow for each of thise subimages,
%returning them as a 13x13 cell array, each element is a vector. (number of subimages)

%This function assumes the input is a 200x200 image.

%Dividing the image into 15x15 subimages
subimages1=cell(13);     %Creating a cell array for the subimages of image1
subimages2=cell(13);     %Creating a cell array for the subimages of image2
opt_flow=cell(13);

for i=1:13
    for j=1:13
        subimages1{i,j}=image1((i-1)*15+1:i*15,(j-1)*15+1:j*15);
        subimages2{i,j}=image2((i-1)*15+1:i*15,(j-1)*15+1:j*15);
        
        %Computing A: for this we need the partial derivatives
        [derivx,derivy]=imgradientxy(subimages1{i,j}); %Getting the partial derivatives
        Gx=transpose(derivx(1:225));  %Placing them in column vectors
        Gy=transpose(derivy(1:225));  %Placing them in column vectors
        A=[Gx,Gy];
        A_tr=transpose(A);
        
        %Computing b: for this we need the time derivatives, nomw we use
        %the other image
        derivt=zeros(15);
        
        for k=1:15
            for l=1:15
                derivt(k,l)=subimages1{i,j}(k,l)-subimages2{i,j}(k,l);
            end
        end
        Gt=transpose(derivt(1:225));
        
        %Computing the optical flow
        opt_flow{i,j}=linsolve(A_tr*A,A_tr*Gt);
        
       
        
    end
end


end
