function [ PSNR] = myPSNR( orig_image, approx_image )

%Getting the sizes of the image
[r,c]=size(orig_image);
orig_image_dbl=im2double(orig_image);
approx_image_dbl=im2double(approx_image);

%Computing mean squared error
MSE=0;
    for i=1:r
        for j=1:c
            MSE=MSE+(orig_image_dbl(i,j)-approx_image_dbl(i,j))^2;
        end
    end
    MSE=MSE/(r*c);
    
%Finding I_max
I_max=0;
    for i=1:r
        for j=1:c
            if (orig_image_dbl(i,j)>I_max)
                I_max=orig_image_dbl(i,j);
            end
        end
    end
        

%Computing the PSNR
PSNR=10*log10(I_max*I_max/MSE);
end
