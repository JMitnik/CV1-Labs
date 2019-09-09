function [st_mean, st_median, st_std] = getStats(vector)
   
st_mean = mean(vector);
st_median = median(vector);
st_std = std(vector);

end