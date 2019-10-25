function [assigned_word] = assign_feature_to_word(descriptor,visual_vocabulary)
%This function assigns a feature to the closest word in the
%visual_vocabulary. visual_vocabulary is a matrix, the rows being the
%words. descriptor sould be a row vector as well.

d=Inf; %Initialize the distance
assigned_word=0;

for i=1:size(visual_vocabulary,1)
    if norm(visual_vocabulary(i,:)-descriptor)<d
       d=norm(visual_vocabulary(i,:)-descriptor);
       assigned_word=i;
    end

end

