function [visual_vocabulary] = create_visual_vocabulary(descriptors,K)
%This function creates a visual vocabulary by clustering the descriptors
%into K clusters by kmeans-algorithm. The centers of clusters will
%represent the words.
[~,visual_vocabulary]=kmeans(descriptors,K);

end

