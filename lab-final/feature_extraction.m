function [features,descriptors] = feature_extraction(X)
%   This function extracts the features and descripors from all the images
%   in X. X has the same structure as the structure of the data provided.
%   Its rows are 96*96 RGB pics, the channels written after each other.
features=[];
descriptors=[];
for i=1:size(X,1)
    I=single(rgb2gray(reshape(X(i,:),96,96,3)));
    [f,d]=vl_sift(I);
    features=cat(2,features,f);
    descriptors=double(cat(2,descriptors,d));
end

features=transpose(features);
descriptors=transpose(descriptors);

