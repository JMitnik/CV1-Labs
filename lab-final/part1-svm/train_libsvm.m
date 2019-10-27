function [model] = train_libsvm(X, y)
    label_idxs = unique(y);
    model = cell(length(label_idxs),1);

    for i=1:length(label_idxs)
        class_label = label_idxs(i);
        binary_classes = y == class_label;
        model{i} = svmtrain(double(binary_classes), X, '-c 1 -g 0.2 -b 1');
    end
end