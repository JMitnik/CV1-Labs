function [train_X, train_y, test_X, test_y] = read_input(path_to_train, path_to_test, DEBUG_MODE, SAMPLE_SIZE_TRAIN, SAMPLE_SIZE_TEST)
    path_to_train = 'data/train.mat';
    path_to_test = 'data/test.mat';

    train_full = load(path_to_train);
    test_full = load(path_to_test);

    selected_label_idxs = [1,2,3,7,9];
    train_X = train_full.X;
    train_y = train_full.y;
    labels = train_full.class_names(selected_label_idxs);

    test_X = test_full.X;
    test_y = test_full.y;

    % TODO:  Last step - Filter only on the 5 labels
    train_class_idxs = ismember(train_y, selected_label_idxs);
    test_class_idxs = ismember(test_y, selected_label_idxs);
    
    train_X = train_X(train_class_idxs, :);
    train_y = train_y(train_class_idxs);

    test_X = test_X(test_class_idxs, :);
    test_y = test_y(test_class_idxs);
    
    % Convert test_y and test_x to their indices
    test_y(test_y == 7) = 4;
    train_y(train_y == 7) = 4;
    test_y(test_y == 7) = 4;
    test_y(test_y == 9) = 5;
    train_y(train_y == 9) = 5;
    
    if DEBUG_MODE == true
    % Debug-mode: sample number of points per class
        [sampled_train_X, sampled_train_y] = sample_points_per_class(train_X, train_y, SAMPLE_SIZE_TRAIN);
        [sampled_test_X, sampled_test_y] = sample_points_per_class(test_X, test_y, SAMPLE_SIZE_TEST);

        train_X = sampled_train_X;
        train_y = sampled_train_y;

        test_X = sampled_test_X;
        test_y = sampled_test_y;
    end
end
