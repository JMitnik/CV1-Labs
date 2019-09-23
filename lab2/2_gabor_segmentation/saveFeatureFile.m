function saveFeatureFile(gaborFilterBank, resizedStandardizedFeatures)
    for i = 1:length(gaborFilterBank)
        img = resizedStandardizedFeatures(:, :, i);
        lambda = gaborFilterBank(i).lambda;
        stdev = gaborFilterBank(i).sigma;
        theta = gaborFilterBank(i).theta;
        path_to_file = sprintf('results/lambda=%f_theta=%f_sigma=%f.png',lambda, theta,stdev);
        imwrite(img, path_to_file, 'png');
    end
end
