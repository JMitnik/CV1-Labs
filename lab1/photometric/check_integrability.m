function [ p, q, SE ] = check_integrability( normals )
%CHECK_INTEGRABILITY check the surface gradient is acceptable
%   normals: normal image
%   p : df / dx
%   q : df / dy
%   SE : Squared Errors of the 2 second derivatives

% initalization
% ========================================================================
% YOUR CODE GOES HERE
% Compute p and q, where
% p measures value of df / dx
% q measures value of df / dy
[h, w, n] = size(normals);

p = zeros(h,w);
q = zeros(h,w);
SE = zeros(h,w);

p = normals(:, :, 1) ./ normals(:, :, 3);
q = normals(:, :, 2) ./ normals(:, :, 3);
% ========================================================================



p(isnan(p)) = 0;
q(isnan(q)) = 0;



% ========================================================================
% YOUR CODE GOES HERE
% approximate second derivate by neighbor difference
% and compute the Squared Errors SE of the 2 second derivatives SE

% TODO: Add padding row and padding col to include
q_def = [zeros(h, 1), diff(q')'];
p_def = [zeros(1, w); diff(p)];
SE = (p_def - q_def).^2;
% ========================================================================




end

