function [needed_pictures,labels] = get_needed_pictures(X,y)
%Syntax: [needed_pictures,labels]=get_needed_pictures(X,y)
%   The dataset has 10 classes, for our assignment we only need 5. This
%   function filters the given dataset for only those classes we need for
%   the assignment. These are: [1] airplane, [2] bird, [9] ship, [7] horse,
%   [3] cars.

%run('C:\Program Files\MATLAB\R2019a\vlfeat-0.9.21/toolbox/vl_setup')

needed_pictures=[];
labels=[];

for i=1:100 %size(y), 100 is just for debugging
    if (y(i)==1 || y(i)==2 || y(i)==9 || y(i)==7 || y(i)==3)
        needed_pictures=cat(1,needed_pictures,X(i,:));
        labels=cat(1,labels,y(i,:));
    end
end



end

