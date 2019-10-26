% ! NOTE: Run VL_Setup.m to get started
% Default params
try
    addpath('svm-lib/')
catch
    disp('Cant find SVM lib in the path');
end

SAMPLE_SIZE_TRAIN = 100;
SAMPLE_SIZE_TEST = 100;

% Vocab sizes: 400, 1000, 4000
VOCAB_SIZE = 4000;
DENSE_SIFT_STEP_SIZE = 5;

% Color spaces: 'greyscale_SIFT', 'color_SIFT', 'opponent_SIFT'
COLOR_SPACE = 'greyscale_SIFT';
SAMPLING_MODE = 'dense_SIFT';

LABEL_IDXS = [1,2,3,4,5];
%%%
% 0. Training loading
%%%
path_to_train = 'data/train.mat';
path_to_test = 'data/test.mat';
[train_X, train_y, test_X, test_y] = read_input(path_to_train, path_to_test, true, SAMPLE_SIZE_TRAIN, SAMPLE_SIZE_TEST);

%%%
% 1. Feature extraction
%%%
% Points used for the vocab: half of the original
vocab_X = sample_points_per_class(train_X, train_y, floor(SAMPLE_SIZE_TRAIN * 0.3));
disp('Going to extract features now');
feature_descriptors = extract_features(vocab_X, COLOR_SPACE, SAMPLING_MODE, DENSE_SIFT_STEP_SIZE);

%%%
% 2. Building a vocabulary
%%%
disp('Going to create the vocabulary now');
vocab = create_vocab(feature_descriptors, VOCAB_SIZE);

%%%
% 3. Quantize features using a visual vocabulary
% 4. Represent features by frequencies
%%%
disp('Going to encode the training and test data now');
train_encodings = encode_images(train_X, vocab, COLOR_SPACE, SAMPLING_MODE, DENSE_SIFT_STEP_SIZE);
test_encodings = encode_images(test_X, vocab, COLOR_SPACE, SAMPLING_MODE, DENSE_SIFT_STEP_SIZE);

%%%
% 5. Classification
%%%
disp('Going to train now!');

% Using fitcecoc
try
    model_fitcecoc = fitcecoc(train_encodings, train_y, 'Coding', 'onevsall');
    disp('Trained fitcecoc svm model!');
    [pred_fitcecoc, probs_fitcecoc] = predict(model_fitcecoc, test_encodings);
    disp('Did prediction with fitcecoc model');
catch
    disp('Something went wrong in training the fitcecoc model.');
end

% Using libsvm
try
    model_libsvm = train_libsvm(train_encodings, train_y);
    disp('Trained libsvm model!');
    [pred_libsvm, probs_libsvm] = predict_libsvm(model_libsvm, test_encodings, label_idxs);
    disp('Did prediction with libsvm model');
catch
    disp('Cant run libsvm, you will have to rely on fitcecoc!');
end

%%%
% 6. Evaluation
%%%
%# predict the class with the highest probability
try
    acc_libsvm = sum(pred_libsvm == test_y) ./ numel(test_y);
    C_libsvm = confusionmat(test_y, pred_libsvm);
    % TODO: All other results and such?
catch
    disp('Cant find values for results from libsvm');
end

try
    acc_fitcecoc = sum(pred_fitcecoc == test_y) ./ numel(test_y);
    C_fitcecoc = confusionmat(test_y, pred_fitcecoc);
    % TODO: All other results and such?
catch
    disp('Cant find values for results from fitcecoc');
end
