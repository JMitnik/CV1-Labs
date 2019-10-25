function vocab = create_vocab(X, vocab_size)
    % Perform unsupervised task of clustering the descriptors in X
    % Clusters the descriptors into a 128 x vocab_size lookup table
    %     - Each row corresponds to a centroid in the 128 space
    %     corresponding to one cluster.

    [~, C] = kmeans(X, vocab_size);

    % Return the vocab as C
    vocab = C;
end
