function [ p, q, SE ] = check_integrability( normals )
%CHECK_INTEGRABILITY check the surface gradient is acceptable
%   normals: normal image
%   p : df / dx
%   q : df / dy
%   SE : Squared Errors of the 2 second derivatives

% initalization
p = zeros(size(normals));
q = zeros(size(normals));
SE = zeros(size(normals));

% ========================================================================
% YOUR CODE GOES HERE
% Compute p and q, where
% p measures value of df / dx
% q measures value of df / dy
[h, w, n] = size(normals);
p_resized = reshape(p, h * w, n);
q_resized = reshape(q, h * w, n);

normals_flattened = reshape(normals, h * w, n);
p_resized = normals_flattened(:, 1) ./ normals_flattened(:, 3);
q_resized = normals_flattened(:, 2) ./ normals_flattened(:, 3);
p = reshape(p_resized, h, w, 1);
q = reshape(q_resized, h, w, 1);
% ========================================================================



p(isnan(p)) = 0;
q(isnan(q)) = 0;



% ========================================================================
% YOUR CODE GOES HERE
% approximate second derivate by neighbor difference
% and compute the Squared Errors SE of the 2 second derivatives SE

% TODO: Add padding row and padding col to include
p_def = diff(p);
q_def = diff(q, 1, 2);
SE = (p_def - q_def).^2;
% ========================================================================




end

