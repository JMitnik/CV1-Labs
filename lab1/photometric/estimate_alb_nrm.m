function [ albedo, normal ] = estimate_alb_nrm( image_stack, scriptV, shadow_trick)
%COMPUTE_SURFACE_GRADIENT compute the gradient of the surface
%   image_stack : the images of the desired surface stacked up on the 3rd
%   dimension
%   scriptV : matrix V (in the algorithm) of source and camera information
%   shadow_trick: (true/false) whether or not to use shadow trick in solving
%   	linear equations
%   albedo : the surface albedo
%   normal : the surface normal

% warning('off', 'MATLAB:rankDeficientMatrix');

[h, w, n] = size(image_stack);
if nargin == 2
    shadow_trick = true;
end

% create arrays for
%   albedo (1 channel)
%   normal (3 channels)
albedo = zeros(h, w, 1);
normal = zeros(h, w, 3);

% =========================================================================
% YOUR CODE GOES HERE
% for each point in the image array
%   stack image values into a vector i
%   construct the diagonal matrix scriptI
%   solve scriptI * scriptV * g = scriptI * i to obtain g for this point
%   albedo at this point is |g|
%   normal at this point is g / |g|
flattened_img_stack = reshape(image_stack, h * w, n);
albedo_reshaped = zeros(h * w, 1);
normal_reshaped = zeros(h * w, 3);

for idx = 1: length(flattened_img_stack(:,1))
    i = flattened_img_stack(idx, :)';
    scriptI = diag(i);
    mag_i = norm(i);
    
    if mag_i > 0
        if shadow_trick == true
            
            g = linsolve(scriptI * scriptV, scriptI * i);
        else
            
            g = linsolve(scriptV, i);
        end
        
        norm_g = norm(g);
        albedo_reshaped(idx, 1) = norm_g;
        normal_reshaped(idx, :) = g / norm_g;
    end
end

albedo = reshape(albedo_reshaped, h, w, 1);
normal = reshape(normal_reshaped, h, w, 3);

% =========================================================================

end

