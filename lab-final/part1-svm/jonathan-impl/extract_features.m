function features = extract_features(X, color_space, sampling_mode)

    IMAGE_W = 96;
    IMAGE_H = 96;
    SIFT_DIM = 128;

    % Features is a cell array of extracted features.
    features = zeros(SIFT_DIM, 1);

    % For each image,
    for img_idx = 1:size(X, 1)
        img = reshape(X(img_idx, :), IMAGE_W, IMAGE_H, 3);

        if strcmp(color_space, 'greyscale_SIFT')
            % Convert images to greyscale, leaving only nr_im x im-size
            try
                img = rgb2gray(img);
            catch
                disp('Image already greyscale!');
            end
        end

        % TODO: Ensure this has no need for further transformation.
        if strcmp(color_space, 'color_SIFT')
            % Do nothing
            img = img;
        end

        if strcmp(color_space, 'opponent_SIFT')
            % Use RGB2Opponent to send images to Opponent color space
            img = rgb2opponent(img);
        end

        % Convert img to single
        try
            img = single(img);
        catch
            disp('Image already singles!')
        end

        % Use SIFT on the images
        img_features = zeros('like', img);

        for channel = 1:size(img_features,2)
            if strcmp(sampling_mode, 'keypoints_SIFT')
                [~, descriptors] = vl_sift(img(:, :, channel));
            end

            if strcmp(sampling_mode, 'dense_SIFT')
                [~, descriptors] = vl_dsift(img(:, :, channel));
            end

            descriptors = double(descriptors);

            % Add descriptors to features
            features = cat(2, features, descriptors);
        end
    end

    features = features(:, 2:end)';
end
