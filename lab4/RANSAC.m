function [best_transformation] = RANSAC(total_matches, im1, im2, N, P, radius_size, use_plot)
%RANSAC - Description
%
% Syntax: [best_transformation] = RANSAC(input)

    best_count_inliers = 0;

    x1 = total_matches(1, :);
    y1 = total_matches(2, :);
    x2 = total_matches(3, :);
    y2 = total_matches(4, :);

    % For m1, m2, m3, m4, t1, t2
    best_transformation = rand(6,1);

    % For N loop iterations, do the following:
    % Note: The p_ prefix on the variables is due to being a sample of P elements.
    for idx=1:N
        % 1. Sample P elements using sample_matches(plot=False)
        subset_matches = sample_keypoint_matchings(total_matches, P);

        if use_plot
            figure(3);
            plot_matches(im1, im2, subset_matches, 'Matches before transformation');
        end

        p_x1 = subset_matches(1, :);
        p_y1 = subset_matches(2, :);
        p_x2 = subset_matches(3, :);
        p_y2 = subset_matches(4, :);

        % 2. Create a matrix p_A and vector b using the P pair of points
            % Where p_A has len(x) * 2 rows, and 6 columns
            % Where b is the concatenation of p_x and p_y vertically.

        % Ensure that we stack these vectors vertically.
        p_A = createAffineMatrix(p_x1', p_y1');
        p_b = reshape([p_x2;p_y2], 1, []);
        p_b = p_b';

        % 3. Solve equation Ax=b, by using x = pinv(A)*b
        x = pinv(p_A)*p_b;

        % 4. Apply x to image1, transforming image1 to b
        A = createAffineMatrix(x1', y1');
        b = A * x;
        b = reshape(b, 2, []);

        if use_plot
            figure(4);
            plot_matches(im1, im2, [x1; y1; b(1, :); b(2, :)], 'Matches after transformation');
        end

        % 5. Count inliers: for each transformed pixel, check that it is within 10
        %    pixels of the corresponding match of pixel 2

        distances = ((b(1,:) - x2).^2 + (b(2,:) - y2).^2).^(1/2);
        inliers = sum(distances <= radius_size);

        if inliers > best_count_inliers
            best_count_inliers = inliers;
            best_transformation = x;
        end
    end

    fprintf('Number for best count inliers: %f', best_count_inliers);
end

function [A] = createAffineMatrix(x1, y1)
    zero_cols = zeros(length(y1), 1);
    one_cols = ones(length(y1), 1);
    A = zeros(1, 6);

    for i=1:length(x1)
        A_sub = [x1(i), y1(i), 0, 0, 1, 0;
            0, 0, x1(i), y1(i), 0, 1];
        A = cat(1, A, A_sub);
    end
    A = A(2:end, :);
end
