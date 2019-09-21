function [ imOut ] = denoise( image, kernel_type, varargin)

%The order of the inputs: image, kernel_type, kernel_size, (sigma if Gaussian)

switch kernel_type
    case 'box'
        imOut=imboxfilt(image,cell2mat(varargin(1)));
    case 'median'
        imOut=medfilt2(image,[cell2mat(varargin(1)),cell2mat(varargin(1))]);
    case 'gaussian'
        imOut=imfilter(image,gauss2D(cell2mat(varargin(2)),cell2mat(varargin(1))));
end
end
