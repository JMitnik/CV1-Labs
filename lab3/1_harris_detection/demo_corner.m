function demo_corner(Img, threshold)
    sigma = 1;
    neighbors = 10;

    [H, r, c] = HarrisCornerDetector(Img, sigma, neighbors, threshold, 0);
    figure;
    imshow(Img); hold on;
    scatter(c, r, 20, 'r');
    title("Corners detected in Image");    
end