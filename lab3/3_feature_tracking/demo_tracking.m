% Adding dependencies
mydir  = pwd;
idcs   = strfind(mydir,'/');
newdir = mydir(1:idcs(end)-1);

addpath(fullfile(newdir, '1_harris_detection/'));
addpath(fullfile(newdir, '2_lucas_kanade/'));
path_to_toy_video = '../person_toy/';
path_to_pp_video = '../pingpong/';

tdelt = 15;
hthres = 0.05;
window_size = 15;
sigma = 2;
neighbors = 5;

toy_filepath = sprintf('ptoy_tdelt=%f_thres=%f_window=%f', tdelt, h_thres, window_size);
pp_filepath = sprintf('pp_tdelt=%f_thres=%f_window=%f', tdelt, h_thres, window_size);

% Track and save video for toy data-set
tracking(path_to_toy_video, toy_filepath, window_size, h_thres, tdelt, sigma, neighbors);

% Track and save video for pingpong data-set
tracking(path_to_pp_video, pp_filepath, window_size, h_thres, tdelt, sigma, neighbors);