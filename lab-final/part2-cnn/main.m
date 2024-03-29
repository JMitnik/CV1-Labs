%% main function 

addpath('liblinear-2.1/matlab/');
addpath('matconvnet-1.0-beta23/matlab/');
addpath('tSNE_matlab');

%% fine-tune cnn

[net, info, expdir] = finetune_cnn(50,100,0.1);

%% extract features and train svm

% TODO: Replace the name with the name of your fine-tuned model
nets.fine_tuned = load(fullfile(expdir, 'net-epoch-50.mat')); nets.fine_tuned = nets.fine_tuned.net;
nets.pre_trained = load(fullfile('data', 'pre_trained_model.mat')); nets.pre_trained = nets.pre_trained.net; 
data = load(fullfile(expdir, 'imdb-stl.mat'));


%%
train_svm(nets, data);
