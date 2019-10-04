function subset_matches = sample_keypoint_matchings(total_matches, nr_samples)
    subset_idx = randperm(length(total_matches), nr_samples);
    subset_matches = total_matches(:, subset_idx);
end
