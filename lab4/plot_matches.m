function plot_matches(im1, im2, matches)
    % Matches contains rows x1, y1, x2, y2
    x1 = matches(1, :);
    y1 = matches(2, :);
    x2 = matches(3, :);
    y2 = matches(4, :);

    joined_img = cat(2,im1,im2);

    x2 = x2 +size(im1,2);
    
    figure;
    imshow(joined_img); hold on;
    title('Keypoint matches');
    scatter(x1, y1, 50, 'filled','b');
    scatter(x2, y2, 50, 'filled','b');

    % Method 1: Just as vectors
    plot([x1; x2], [y1; y2], 'LineWidth', 2);

    % Method 2: Using a for loop (temporarily commented)
    % hold on
    % for i = 1:length(x1)
    %     plot([x1(i) x2(i)], [y1(i) y2(i)]);
    % end
    % hold off
end
