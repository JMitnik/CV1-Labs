function [net, info, expdir] = finetune_cnn(num_epochs, batch_size, learning_rate, varargin)

%% Define options
% run(fullfile(fileparts(mfilename('fullpath')), ...
%   '..', '..', '..', 'matlab', 'vl_setupnn.m')) ;

run(fullfile(fileparts(mfilename('fullpath')), 'matconvnet-1.0-beta23', 'matlab', 'vl_setupnn.m')) ;

opts.modelType = 'lenet' ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.expDir = fullfile('data', ...
  sprintf('cnn_assignment-%s', opts.modelType)) ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.dataDir = './data/' ;
opts.imdbPath = fullfile(opts.expDir, 'imdb-stl.mat');
opts.whitenData = true ;
opts.contrastNormalization = true ;
opts.networkType = 'simplenn' ;
opts.train = struct() ;
opts = vl_argparse(opts, varargin) ;
if ~isfield(opts.train, 'gpus'), opts.train.gpus = []; end;


%% update model

net = update_model(num_epochs, batch_size, learning_rate);

%% TODO: Implement getIMDB function below

if exist(opts.imdbPath, 'file')
  imdb = load(opts.imdbPath) ;
else
  imdb = getIMDB() ;
  mkdir(opts.expDir) ;
  save(opts.imdbPath, '-struct', 'imdb') ;
end

%%
net.meta.classes.name = imdb.meta.classes(:)' ;

% -------------------------------------------------------------------------
%                                                                     Train
% -------------------------------------------------------------------------

trainfn = @cnn_train ;
[net, info] = trainfn(net, imdb, getBatch(opts), ...
  'expDir', opts.expDir, ...
  net.meta.trainOpts, ...
  opts.train, ...
  'val', find(imdb.images.set == 2)) ;

expdir = opts.expDir;
end
% -------------------------------------------------------------------------
function fn = getBatch(opts)
% -------------------------------------------------------------------------
switch lower(opts.networkType)
  case 'simplenn'
    fn = @(x,y) getSimpleNNBatch(x,y) ;
  case 'dagnn'
    bopts = struct('numGpus', numel(opts.train.gpus)) ;
    fn = @(x,y) getDagNNBatch(bopts,x,y) ;
end

end

function [images, labels] = getSimpleNNBatch(imdb, batch)
% -------------------------------------------------------------------------
images = imdb.images.data(:,:,:,batch) ;
labels = imdb.images.labels(1,batch) ;
% labels = imdb.images.labels(batch,1) ;
if rand > 0.5, images=fliplr(images) ; end

end

% -------------------------------------------------------------------------
function imdb = getIMDB()
% -------------------------------------------------------------------------
% Preapre the imdb structure, returns image data with mean image subtracted
classes = {'airplane', 'bird', 'ship', 'horse', 'car'};
splits = {'train', 'test'};

% TODO: Implement your loop here, to create the data structure described in the assignment
% Use train.mat and test.mat we provided from STL-10 to fill in necessary data members for training below
% You will need to, in a loop function,  
% 1) read the image, 
% 2) resize the image to (32,32,3),
% 3) read the label of that image

% read raw data
train = load("data/stl10_matlab/train.mat");
valid = load("data/stl10_matlab/test.mat");

% mapping from original labels to current labels
original_classes = {1,2,9,7,3};
new_classes = {1,2,3,4,5};
class_map = containers.Map(original_classes, new_classes);

% extract the 5 selected classes
selected_idxs = find(ismember(train.class_names, classes));
selected_mask = ismember(train.y, selected_idxs);
valid_selected_idxs = find(ismember(valid.class_names, classes));
valid_selected_mask = ismember(valid.y, selected_idxs);
data = [train.X(selected_mask,:); valid.X(valid_selected_mask,:)];
labels = [train.y(selected_mask,:); valid.y(valid_selected_mask,:)];
labels = arrayfun(@(x) class_map(x), labels);
num_train = sum(selected_mask);
num_valid = sum(valid_selected_mask);
sets = [ones(num_train,1); 2*ones(num_valid,1)];

% reshape data into image dimensions (H x W x C x N)
data = reshape(data,size(data,1),96,96,3);
data = permute(data, [2,3,4,1]);

% resize all images from 96 to 32
data = imresize(data,1/3);

%%
% subtract mean
% dataMean = mean(data(:, :, :, sets == 1), 4);
% data = bsxfun(@minus, data, dataMean);

imdb.images.data = data ;
imdb.images.labels = single(labels) ;
imdb.images.set = single(sets);
imdb.meta.sets = {'train', 'val'} ;
imdb.meta.classes = classes;

perm = randperm(numel(imdb.images.labels));
imdb.images.data = imdb.images.data(:,:,:, perm);
imdb.images.labels = transpose(imdb.images.labels(perm));
imdb.images.set = transpose(imdb.images.set(perm));

data = zeros(32,32,3,6500,'single');
for i=1:6500
  data(:,:,:,i) = im2single(imdb.images.data(:,:,:,i));
end
imdb.images.data=data;

end