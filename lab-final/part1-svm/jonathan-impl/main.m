% ! NOTE: Run VL_Setup.m to get started
% Default params
SAMPLE_SIZE_TRAIN = 100;
SAMPLE_SIZE_TEST = 100;
VOCAB_SIZE = 400;
COLOR_SPACE = 'greyscale_SIFT';
SAMPLING_MODE = 'keypoints_SIFT';

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
vocab_X = sample_points_per_class(train_X, train_y, floor(SAMPLE_SIZE / 2));

feature_descriptors = extract_features(vocab_X, COLOR_SPACE, SAMPLING_MODE);

%%%
% 2. Building a vocabulary
%%%
vocab = create_vocab(feature_descriptors, VOCAB_SIZE);

%%%
% 3. Quantize features using a visual vocabulary
% 4. Represent features by frequencies
%%%
train_encodings = encode_images(train_X, vocab, COLOR_SPACE, SAMPLING_MODE);
test_encodings = encode_images(test_X, vocab, COLOR_SPACE, SAMPLING_MODE);

%%%
% 5. Classification
%%%
%# train one-against-all models
model = cell(length(label_idxs),1);

for i=1:length(label_idxs)
    class_label = label_idxs(i);
    binary_classes = train_y == class_label;
    model{i} = svmtrain(double(binary_classes), train_encodings, '-c 1 -g 0.2 -b 1');
end

%# get probability estimates of test instances using each model
prob = zeros(size(test_X, 1), length(label_idxs));

for i=1:length(label_idxs)
    class_label = label_idxs(i);
    binary_classes = test_y == class_label;
    [~,~,p] = svmpredict(double(binary_classes), test_encodings, model{i}, '-b 1');
    prob(:,i) = p(:,model{i}.Label==1);    %# probability of class==k
end

% MANUEL DEBUG
[~,pred] = max(prob,[],2);
pred(pred==4) = 7;
pred(pred==5) = 9;

%# predict the class with the highest probability
acc = sum(pred == test_y) ./ numel(test_y);    %# accuracy
C = confusionmat(test_y, pred);                   %# confusion matrix

%%%
% 6. Evaluation
%%%
