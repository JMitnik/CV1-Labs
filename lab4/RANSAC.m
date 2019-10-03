function [best_transformation] = RANSAC()
%RANSAC - Description
%
% Syntax: [best_transformation] = RANSAC(input)

best_count_inliers = 0;
% For m1, m2, m3, m4, t1, t2
best_transformation = [0, 0, 0, 0, 0, 0];

% For N loop iterations, do the following:

    % 1. Sample P elements using sample_matches(plot=False)

    % 2. Create a matrix A and vector b using the P pair of points
        % Where A has len(x) * 2 rows, and 6 columns
        % b is the concatenation (?) of x and y vertically.

    % 3. Solve equation Ax=b, by using x = pinv(A)*b

    % 4. Apply x to image1, transforming image1 to image2

    % 5. Count inliers: for each transformed pixel, check that it is within 10
    %    pixels of the corresponding match of pixel 2

    % 6. If the number of inliers is higher than before, store the parameter-set of best_transformation

% Transform image1 by rounding the coordinates (==nearest neighbours?)
end
