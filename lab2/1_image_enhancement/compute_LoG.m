function imOut = compute_LoG(image, LOG_type)

switch LOG_type
    case 1
        %method 1
        g = fspecial('gaussian',5, 0.5);
        image_smooth = conv2(image, g);
        l = fspecial('laplacian',0);
        image_laplace = conv2(image_smooth, l);
        imshow(image_laplace, []);

    case 2
        %method 2
        l = fspecial('log',5, 0.5);
        image_laplace = conv2(image, l);
        imshow(image_laplace, []);

    case 3
        %method 3
        g1 = fspecial('gaussian',5, 3);
        image_smooth_1 = conv2(image, g1);
        g2 = fspecial('gaussian',5, 0.5);
        image_smooth_2 = conv2(image, g2);
        figure(1);
        imshowpair(image_smooth_1, image_smooth_2, 'montage');
        image_final = image_smooth_1 - image_smooth_2;
        figure(2);
        imshow(image_final, []);

        

end
end

