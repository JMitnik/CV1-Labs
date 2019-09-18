function [ albedo, normal ] = estimate_alb_nrm( image_stack, scriptV, shadow_trick)
%COMPUTE_SURFACE_GRADIENT compute the gradient of the surface
%   image_stack : the images of the desired surface stacked up on the 3rd
%   dimension
%   scriptV : matrix V (in the algorithm) of source and camera information
%   shadow_trick: (true/false) whether or not to use shadow trick in solving
%   	linear equations
%   albedo : the surface albedo
%   normal : the surface normal

warning('off', 'MATLAB:rankDeficientMatrix');

[h, w, n] = size(image_stack);
if nargin == 2
    shadow_trick = true;
else
    shadow_trick = false;
end

% create arrays for
% albedo (1 channel)
albedo = zeros(h, w, 1);
% normal (3 channels)
normal = zeros(h, w, 3);

% =========================================================================
% Flatten the stack to make looping easier
flattened_img_stack = reshape(image_stack, h * w, n);
albedo_reshaped = zeros(h * w, 1);
normal_reshaped = zeros(h * w, 3);

% for each point in the image array
for idx = 1: length(flattened_img_stack(:,1))
    %   stack image values into a vector i
    i = flattened_img_stack(idx, :)';
    %   construct the diagonal matrix scriptI
    scriptI = diag(i);
    mag_i = norm(i);
    
    if mag_i > 0
        if shadow_trick == true
            % solve scriptI * scriptV * g = scriptI * i to obtain g for this point
            g = linsolve(scriptI * scriptV, scriptI * i);
        else
            % solve scriptV * g = i to obtain g for this point
            g = linsolve(scriptV, i);
        end

        norm_g = norm(g);
        % albedo at this point is |g|
        albedo_reshaped(idx, 1) = norm_g;
        % normal at this point is g / |g|
        normal_reshaped(idx, :) = g / norm_g;
    end
end

% Reshape back to original shape
albedo = reshape(albedo_reshaped, h, w, 1);
normal = reshape(normal_reshaped, h, w, 3);
% =========================================================================

end

