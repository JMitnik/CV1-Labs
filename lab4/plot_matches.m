function plot_matches(im1, im2, matches, plot_title)
    % Matches contains rows x1, y1, x2, y2
    x1 = matches(1, :);
    y1 = matches(2, :);
    x2 = matches(3, :);
    y2 = matches(4, :);

    joined_img = cat(2,im1,im2);

    x2 = x2 +size(im1,2);
    
    imshow(joined_img); hold on;
    title(plot_title);
    scatter(x1, y1, 50, 'filled','b');
    scatter(x2, y2, 50, 'filled','b');

    % Method 1: Just as vectors
    plot([x1; x2], [y1; y2], 'LineWidth', 2);
end
