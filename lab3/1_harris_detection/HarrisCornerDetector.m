function [H, r, c] = HarrisCornerDetector(Img, sigma, neighbors, threshold, plot)
%HARRISCORNERDETECTOR Detects corners in an image.
%
%   H,r,c = HarrisCornerDetector(Img, threshold) detects corners  
%   - ARGUMENTS
%     Img       
%     threshold
%   
%   - OUTPUT
%     H     Image with highlighted corners
%     r     rows of detected corner points
%     c     columns of detected corner points
%
    % Img = imread('../person_toy/00000001.jpg');
    I = double(rgb2gray(Img))/255;
    sobelX = [1 0 -1; 2 0 -2; 1 0 -1];
    sobelY = sobelX';

    % Apply first-order Gaussian, aka Sobel filter to find edge in x-dir
    I_x = imfilter(I, sobelX, 'conv');
    I_x_sq = I_x .^ 2;
    A = imgaussfilt(I_x_sq, sigma);

    % Apply first-order Gaussian, aka Sobel filter to find edge in y-dir
    I_y = imfilter(I, sobelY, 'conv');
    I_y_sq = I_y .^ 2;
    C = imgaussfilt(I_y_sq, sigma);

    I_xy = I_x .* I_y;
    B = imgaussfilt(I_xy, sigma);
    
    %Harris
    H = (A .* C - B.^2) - 0.04*((A+C).^2);
    %Shi and Tomasi
    %H = min(A, C);
    
    % replaces each element in H by the orderth element
    % in the sorted set of neighbors
    % specified by the nonzero elements in domain.
    H_filtered = ordfilt2(H, neighbors^2, ones(neighbors));
    % Check if greater than neighbours and user defined threshold
    corners = (H_filtered == H) & H > threshold; 
    [r,c] = find(corners);

    if plot
        figure(1);
        subplot(1,2,1);
        imshow(I_x);
        title('I_x Image Derivative');

        subplot(1,2,2);
        imshow(I_y);
        title('I_y Image Derivative');
end

