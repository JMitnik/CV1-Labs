function [preds, probs] = predict_libsvm(model, X, y)
    label_idxs = unique(y);
    probs = zeros(size(X, 1), length(label_idxs));

    for i=1:length(label_idxs)
        class_label = label_idxs(i);
        binary_classes = y == class_label;
        [~,~,p] = svmpredict(double(binary_classes), X, model{i}, '-b 1');
        probs(:,i) = p(:,model{i}.Label==1);
    end

    [~,preds] = max(probs,[],2);
end
