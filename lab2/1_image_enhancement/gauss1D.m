function G = gauss1D( sigma , kernel_size )
    G = zeros(1, kernel_size);
    if mod(kernel_size, 2) == 0
        error('kernel_size must be odd, otherwise the filter will not have a center to convolve on')
    end
    %% solution
    
    x = linspace(-floor(kernel_size/2),floor(kernel_size/2), kernel_size);
    % Function for the gaussian distribution
    gauss = @(i) 1/(sigma*sqrt(2*pi))* exp(-(i.^2)/(2*(sigma^2)));
    G = gauss(x) ./ sum(gauss(x));
end
