function [px, py] = interpret_optical_flow(optical_flow)
% intepretOpticalFLow - Interprets the output of the lucas kanade algorithm
%
% Syntax: [px, py] = intepretOpticalFLow(optical_flow)
%

[rows_size, columns_size] = size(optical_flow);

px=zeros(rows_size, columns_size);
py=zeros(rows_size, columns_size);

for i=1:rows_size
    for j=1:columns_size
        temp=optical_flow{i,j};
        px(i,j)=temp(1);
        py(i,j)=temp(2);
    end
end


end
