function im_opponent = rgb2opponent(im)
    % Thank you https://nl.mathworks.com/matlabcentral/answers/118889-rgb-to-opponent-color-space-code

    R = im(:, :, 1);
    G = im(:, :, 2);
    B = im(:, :, 3);

    color_1 = (R-G) ./ sqrt(2);
    color_2 = (R+G-2*B) ./ sqrt(6);
    color_3 = (R+G+B) ./ sqrt(3);

    im_opponent = cat(3, color_1, color_2, color_3);
end
