% Adding dependencies
mydir  = pwd;
idcs   = strfind(mydir,'/');
newdir = mydir(1:idcs(end)-1);

addpath(fullfile(newdir, '1_harris_detection/'));
addpath(fullfile(newdir, '2_lucas_kanade/'));

% Setting parameters
path_to_video = '../person_toy/';
optical_flow_window_path = [15, 20, 35];
harris_threshold = [0.2, 0.3, 0.4, 0.5];
T_Delta = [15, 20, 25, 30];

sigma = 2;
neighbors = 100;

for t_idx=1:length(T_Delta)
    for h_idx=1:length(harris_threshold)
        for w_idx=1:length(optical_flow_window_path)
            tdelt = T_Delta(t_idx);
            h_thres = harris_threshold(h_idx);
            window_size = optical_flow_window_path(w_idx);

            filepath = sprintf('results/ptoy_tdelt=%f_thres=%f_window=%f', tdelt, h_thres, window_size);
            tracking(path_to_video, filepath, window_size, h_thres, tdelt, sigma, neighbors);
        end
    end
end

% Track with window-size 20, Harris threshold 0.1, and estimated T-Delta 20
