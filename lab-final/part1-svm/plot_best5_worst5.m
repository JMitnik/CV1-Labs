function [] = plot_best5_worst5(idx_list,test_X,str_title,model_libsvm)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here



    for i=1:5
        subplot(1,11,i)
        I=reshape(test_X(idx_list(i),:),96,96,3);
        imshow(I)
    end 

    for i=1:5
        subplot(1,11,6+i)
        I=reshape(test_X(idx_list(size(idx_list,1)+1-i),:),96,96,3);
        imshow(I)
    end
    


sgtitle(str_title)

