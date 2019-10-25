function [frequencies] =repr_im_as_freq_of_visual_words(I,visual_vocabulary)
%This function takes image I and represents it frequencies of visual worsd
%frot the visual_vocabualry. I should be represented as a row vector (a row
%of our data matrix X).The output is a vector of length K (number of
%words).

frequencies=zeros([1,size(visual_vocabulary,1)]);

im=single(rgb2gray(reshape(I,96,96,3)));
[~,descriptors]=vl_sift(im);
descriptors=double(transpose(descriptors));

for i=1:size(descriptors,1)
    class=assign_feature_to_word(descriptors(i,:),visual_vocabulary);
    frequencies(class)=frequencies(class)+1;

end

