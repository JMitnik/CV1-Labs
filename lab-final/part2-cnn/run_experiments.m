%% Runs all Experiments
close all
clear all
clc

addpath('liblinear-2.1/matlab/');
addpath('matconvnet-1.0-beta23/matlab/');
addpath('tSNE_matlab');

BATCH_SIZE = [50,100];
NUM_EPOCHS = [40,80,120];
LR = 0.1;

num_results = length(BATCH_SIZE)*length(NUM_EPOCHS);
cnn_accs = zeros(num_results,1);
svm_accs = zeros(num_results,1);
svm_cnn_accs = zeros(num_results,1);
idx=1;

for i=1:length(BATCH_SIZE);
    for j=1:length(NUM_EPOCHS);
        batch_size = BATCH_SIZE(i);
        num_epochs = NUM_EPOCHS(j);
        
        fprintf("\nBegin Experiment with Number of Epochs: %d and Batch Size: %d\n\n", num_epochs, batch_size);
        [net, info, expdir] = finetune_cnn(num_epochs,batch_size, LR);

        fprintf("\nBegin SVM Training...\n");
        model_path = sprintf('net-epoch-%d.mat', num_epochs);
        nets.fine_tuned = load(fullfile(expdir, model_path)); nets.fine_tuned = nets.fine_tuned.net;
        nets.pre_trained = load(fullfile('data', 'pre_trained_model.mat')); nets.pre_trained = nets.pre_trained.net; 
        data = load(fullfile(expdir, 'imdb-stl.mat'));
        
        [cnn_acc, svm_acc, svm_cnn_acc] = train_svm(nets, data);

        fprintf("\nSaving results...\n");

        cnn_accs(idx) = cnn_acc;
        svm_accs(idx) = svm_acc;
        svm_cnn_accs(idx) = svm_cnn_acc;
        idx = idx+1;

        clear net info data nets
    end
end

save("cnn_accs.mat", 'cnn_accs');
save("svm.mat", 'svm_accs');
save("svm_cnn.mat", 'svm_cnn_accs');

%% Plot results
fig = figure;
hold on
plot(NUM_EPOCHS(1:3), cnn_accs(1:3));
labels(1) = strcat("Batch Size: " ,string(BATCH_SIZE(1)));
plot(NUM_EPOCHS(1:3), cnn_accs(4:6));
labels(2) = strcat("Batch Size: " ,string(BATCH_SIZE(2)));
lgd = legend(labels);
lgd.Location = 'bestoutside';    
xlabel('Epochs');
ylabel('Accuracy');
title(sprintf("Finetuned CNN: Epochs vs Accuracy at different batch sizes", text));
hold off

fig = figure;
hold on
plot(NUM_EPOCHS(1:3), svm_accs(1:3));
labels(1) = strcat("Batch Size: " ,string(BATCH_SIZE(1)));
plot(NUM_EPOCHS(1:3), svm_accs(4:6));
labels(2) = strcat("Batch Size: " ,string(BATCH_SIZE(2)));
lgd = legend(labels);
lgd.Location = 'bestoutside';    
xlabel('Epochs');
ylabel('Accuracy');
title(sprintf("SVM with Pre-trained CNN Features: Epochs vs Accuracy at different batch sizes", text));
hold off

fig = figure;
hold on
plot(NUM_EPOCHS(1:3), svm_cnn_accs(1:3));
labels(1) = strcat("Batch Size: " ,string(BATCH_SIZE(1)));
plot(NUM_EPOCHS(1:3), svm_cnn_accs(4:6));
labels(2) = strcat("Batch Size: " ,string(BATCH_SIZE(2)));
lgd = legend(labels);
lgd.Location = 'bestoutside';    
xlabel('Epochs');
ylabel('Accuracy');
title(sprintf("SVM with Fine-tuned CNN Features: Epochs vs Accuracy at different batch sizes", text));
hold off