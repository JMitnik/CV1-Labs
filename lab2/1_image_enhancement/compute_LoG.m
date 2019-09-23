function imOut = compute_LoG(image, LOG_type)

switch LOG_type
    case 1
        %method 1
        h = fspecial('gaussian',5, 0.5);
        image_smooth = imfilter(image, h, 'conv');
        
        image_laplace = del2(image_smooth);%imfilter(image_smooth, h, 'conv');
        figure(1);
        imshowpair(image_smooth, image_laplace, 'montage');

    case 2
        %method 2
        fprintf('Not implemented\n')

    case 3
        %method 3
        fprintf('Not implemented\n')

end
end

