function saveFeatureFile(gaborFilterBank, resizedStandardizedFeatures)
    for i = 1:length(gaborFilterBank)
        img = resizedStandardizedFeatures(:, :, i);
        lambda = gaborFilterBank(i).lambda;
        gamma = gaborFilterBank(i).gamma;
        stdev = gaborFilterBank(i).sigma;
        theta = gaborFilterBank(i).theta;
        path_to_file = sprintf('results/gammas=%f_lambda=%f_theta=%f_sigma=%f.png', gamma, lambda, theta,stdev);
        imwrite(img, path_to_file, 'png');
    end
end
