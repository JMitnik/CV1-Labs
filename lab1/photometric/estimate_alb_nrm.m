function [ albedo, normal ] = estimate_alb_nrm( image_stack, scriptV, shadow_trick)
%COMPUTE_SURFACE_GRADIENT compute the gradient of the surface
%   image_stack : the images of the desired surface stacked up on the 3rd
%   dimension
%   scriptV : matrix V (in the algorithm) of source and camera information
%   shadow_trick: (true/false) whether or not to use shadow trick in solving
%   	linear equations
%   albedo : the surface albedo
%   normal : the surface normal


[h, w, d] = size(image_stack);
if nargin == 2
    disp('shadow trick on');
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
for r = 1:h
    for c = 1:w
        %   stack image values into a vector i
        i = reshape(image_stack(r,c,:),[d,1]);
        if shadow_trick == true
            %   construct the diagonal matrix scriptI
            scriptI = diag(i);
            %   solve scriptI * scriptV * g = scriptI * i to obtain g for this point
            [g, ~] = linsolve(scriptI * scriptV, scriptI * i);
        else
            [g, ~] = linsolve(scriptV, i);
        end
        %   albedo at this point is |g|
        albedo(r,c) = norm(g);
        
        %   normal at this point is g / |g|
        g_unit = g / norm(g);
        normal(r,c,1) = g_unit(1,:);
        normal(r,c,2) = g_unit(2,:);
        normal(r,c,3) = g_unit(3,:);
    end
end



% =========================================================================

end

