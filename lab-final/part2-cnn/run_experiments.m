%% Runs all Experiments
close all
clear all
clc

addpath('liblinear-2.1/matlab/');
addpath('matconvnet-1.0-beta23/matlab/');
addpath('tSNE_matlab');

BATCH_SIZE = [50,100];
NUM_EPOCHS = [2,3,4];
LR = 0.05;

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

        fileID = fopen(fullfile(expdir, 'accuracies.txt'), 'w');
            fprintf(fileID, 'CNN: fine_tuned_accuracy: %0.3f\n', cnn_acc);
            fprintf(fileID, 'SVM: pre_trained_accuracy: %0.3f\n', svm_acc);
            fprintf(fileID, 'SVM: fine_tuned_accuracy: %0.3f\n', svm_cnn_acc);
            fclose(fileID);
    end
end

%% Plot results
plot(cnn_acc, "Finetuned CNN");
plot(svm_acc, "SVM with Pre-trained CNN Features");
plot(svm_cnn_acc, "SVM with Fine-tuned CNN Features");

function plot(acc, title)
    fig = figure;
    hold on
    for j=1:length(BATCH_SIZE)
        for i=1:length(NUM_EPOCHS)
            plot(NUM_EPOCHS(i), acc(i));
            labels(j) = string(BATCH_SIZE(j))
        end
    end

    lgd = legend(labels);
    lgd.Location = 'bestoutside';
    xlabel('Epochs');
    ylabel('Accuracy');
    title(sprintf("%s : Epochs vs Accuracy at different batch sizes", title));
    hold off
end