function [mean_avg_prec] = calc_mean_avg_prec(pred_y,test_y,SAMPLE_SIZE_TEST)
nr_img_in_class=zeros([size(test_y,1), 1]);
counter=0;

for i=1:size(test_y,1)
       if test_y(i)==1
          counter=counter+1;
       end
       if pred_y(i)==1
           nr_img_in_class(i)=counter;
       end
end
mean_avg_prec=0;
for i=1:size(nr_img_in_class,1)
    mean_avg_prec=mean_avg_prec+nr_img_in_class(i)/i;
end

mean_avg_prec=mean_avg_prec/SAMPLE_SIZE_TEST;
end

