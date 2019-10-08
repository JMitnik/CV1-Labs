function [new_im] = create_transformed_image(im, transformation_matrix)
    [x, y] = size(im);
    T = transformation_matrix(1:2,1:2)^-1;
    new_im = zeros(2*x, 2*y, 'uint8');

    % Loop over shifted image coordinates
    for new_x = -x:2*x
        for new_y = -y:2*y
            coordinate = round(T * [new_x; new_y]);
            if coordinate(1)>0  && coordinate(1)<x && coordinate(2)>0 && coordinate(2)< y
                new_im(x+ new_x, y+new_y) = im(coordinate(1), coordinate(2));
            end
        end
    end
    row_non_idx_zeroes = find(~all(new_im==0,2));
    new_im = new_im(row_non_idx_zeroes, :);
    col_idx_non_zeroes = find(~all(new_im==0,1));
    new_im = new_im(:,col_idx_non_zeroes);
end
