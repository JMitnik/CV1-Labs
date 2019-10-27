function visualise_features()
    addpath('./tSNE_matlab');

    [net, info, expdir] = finetune_cnn(50,100,0.05);
    data = load(fullfile(expdir, 'imdb-stl.mat'));
    
    % finetuned features
    nets.fine_tuned = load(fullfile(expdir, 'net-epoch-50.mat')); nets.fine_tuned = nets.fine_tuned.net;
    nets.fine_tuned.layers{end}.type = 'softmax';

    ft_features = [];
    ft_labels = [];
    for i=1:size(data.images.data, 4)
        out = vl_simplenn(nets.fine_tuned, data.images.data(:,:,:,i));
        feature = squeeze(out(end-3).x);
        ft_features = [ft_features feature];
        ft_labels = [ft_labels; data.images.labels(i)]; 
    end

    f1 = figure;    
    tsne(double(transpose(ft_features)), double(ft_labels), 2);
    title("Finetuned CNN Features");
    saveas(f1, fullfile(expdir, "finetune_tsne.png"));

    % pre-trained features
    nets.pre_trained = load(fullfile('data', 'pre_trained_model.mat')); nets.pre_trained = nets.pre_trained.net; 
    nets.pre_trained.layers{end}.type = 'softmax';

    pre_features = [];
    pre_labels = [];
    for i=1:size(data.images.data, 4)
        out = vl_simplenn(nets.pre_trained, data.images.data(:,:,:,i));
        feature = squeeze(out(end-3).x);
        pre_features = [pre_features feature];
        pre_labels = [pre_labels; data.images.labels(i)]; 
    end

    f2 = figure;    
    tsne(double(transpose(pre_features)), double(pre_labels), 2);
    title("Pre-trained CNN Features");
    saveas(f2, fullfile(expdir, "pre-train_tsne.png"));
    
end