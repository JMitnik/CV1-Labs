function [preds, probs] = predict_libsvm(model, X, label_idxs)
    probs = zeros(size(X, 1), length(label_idxs));

    for i=1:length(label_idxs)
        class_label = label_idxs(i);
        binary_classes = test_y == class_label;
        [~,~,p] = svmpredict(double(binary_classes), test_encodings, model{i}, '-b 1');
        probs(:,i) = p(:,model{i}.Label==1);
    end

    [~,preds] = max(probs,[],2);
end
