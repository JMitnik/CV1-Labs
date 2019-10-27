function [prob_class,labels] = transform_prob_matrix(probs,test_y,class_nr)
%This function transforms the probability matrix probs in a way, that if any
%element is >0.5 it will be 1, otherwise 0. The i,jth element of probmat is
%1 if model{j} classifies picture i as class j, otherwise 0.
prob_class=zeros([size(test_y,1), size(test_y,2)]);
for i=1:size(test_y,1)
    if probs(i,class_nr)>0.5000
        prob_class(i)=1; 
    end
end

labels=zeros([size(test_y,1), size(test_y,2)]);
for i=1:size(test_y,1)
    if test_y(i)==class_nr
        labels(i)=1;
    end
end
end

