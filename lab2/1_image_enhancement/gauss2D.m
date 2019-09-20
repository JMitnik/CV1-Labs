function G = gauss2D( sigma , kernel_size )
    %% solution
    G = transpose(gauss1D(sigma, kernel_size)) * gauss1D(sigma, kernel_size);
    % REMOVE THIS LATER, THIS IS JUST TO CHECK!
    I = imread('images/image1_saltpepper.jpg');
    %apply own filter
    Iblur = imfilter(I,G);
    %predefined matlab filter
    Iblur2 = imgaussfilt(I,2);
    Iblur3 = imfilter(I,fspecial('gaussian',5,2));
    montage({I,Iblur, Iblur2, Iblur3});
    %% Double check: this is the filter matlab creates, it's the same as ours.
%     disp('Matlab filter');
%     fspecial('gaussian',5,2)
    
end
