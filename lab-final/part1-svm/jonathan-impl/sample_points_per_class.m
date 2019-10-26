function [sampled_X, sampled_y] = sample_points_per_class(X, y, nr_per_class)
    % Description: Samples a balanced amount of points per class with the
    % corresponding y
    % Precondition: X and y are equal size
    % Get all unique values
    unique_classes = unique(y);
    sampled_X = zeros(1, size(X, 2));
    sampled_y = zeros(1, size(y, 2));

    % For each unique value:
        % - Grab `nr_per_class` indexes of y where y == `unique_val`
        % - Grab these same indexes of X.
        % Add these to sampled_X, sampled_y
    for cls_idx = 1:length(unique_classes)
        cls = unique_classes(cls_idx);
        idx_cls = find(y==cls, nr_per_class);
        cls_X = X(idx_cls, :);
        cls_y = y(idx_cls, :);

        sampled_X = cat(1, sampled_X, cls_X);
        sampled_y = cat(1, sampled_y, cls_y);
    end

    % Skip first zeros
    sampled_X = sampled_X(2:end, :);
    sampled_y = sampled_y(2:end, :);
end
