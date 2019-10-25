% ! NOTE: Run VL_Setup.m to get started
% Default params
SAMPLE_SIZE = 20;
VOCAB_SIZE = 400;
COLOR_SPACE = 'greyscale_SIFT';
SAMPLING_MODE = 'keypoints_SIFT';

%%%
% 0. Training loading
%%%
path_to_train = 'data/train.mat';
train_full = load(path_to_train);

train_X = train_full.X;
train_y = train_full.y;
labels = train_full.class_names;

% Debug-mode: sample number of points per class
[sampled_train_X, sampled_train_Y] = sample_points_per_class(train_X, train_y, SAMPLE_SIZE);
train_X = sampled_train_X;
train_y = sampled_train_Y;

% Points used for the vocab: half of the original
vocab_X = sample_points_per_class(train_X, train_y, floor(SAMPLE_SIZE / 2));

%%%
% 1. Feature extraction
%%%
feature_descriptors = extract_features(vocab_X, COLOR_SPACE, SAMPLING_MODE);

%%%
% 2. Building a vocabulary
%%%
vocab = create_vocab(feature_descriptors, VOCAB_SIZE);

%%%
% 3. Quantize features using a visual vocabulary
% 4. Represent features by frequencies
%%%
encodings = encode_images(train_X, vocab, COLOR_SPACE, SAMPLING_MODE);

%%%
% 5. Classification
%%%


%%%
% 6. Evaluation
%%%
