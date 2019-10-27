function encodings = encode_images(X, vocab, color_space, sampling_mode, dsift_step_size)
    % Encodes images to their histogram representation according to vocab.
    % Should be nr_images x vocab_size

    encodings = zeros(size(X,1), size(vocab, 1));

    % For each image:
    for i=1:size(X, 1)
        % Extract the features
        img = X(i, :);
        img_features = extract_features(img, color_space, sampling_mode, dsift_step_size);

        % Determine the distance of each feature to the vocab centroids
        [~, code_words] = pdist2(vocab, img_features, 'euclidean', 'Smallest', 1);

        % Perform hist over `code_words` => We should get a vocab-sized hist which is
        % our histogram representation.
        hist_words = histcounts(code_words, 1:length(vocab)+1, 'Normalization', 'probability');
        % Use `hist_words` as representation for our image
        encodings(i, :) = hist_words;
    end
end
