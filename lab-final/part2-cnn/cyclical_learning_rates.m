function lrs = cyclical_learning_rates(start_lr, num_epochs)
    % meta parameters
    peak_lr = max(.9, start_lr*10);
    end_lr = start_lr/100;
    split = 0.1;
    % generate learning rates for every epoch
    warm_start_epochs = floor(num_epochs*split);
    cool_down_epochs = num_epochs-warm_start_epochs;
    epoch_idxs = linspace(0,1,num_epochs);
    start_idxs = linspace(0,1,warm_start_epochs);
    end_idxs = linspace(0,1,cool_down_epochs);
    start_lrs = start_lr + (1+cos(pi*(1-start_idxs)))*(peak_lr-start_lr)/2;
    end_lrs = peak_lr + (1+cos(pi*(1-end_idxs)))*(end_lr-peak_lr)/2;
    lrs = start_lr + (1+cos(pi*(1-epoch_idxs)))*(end_lr-start_lr)/2;
end