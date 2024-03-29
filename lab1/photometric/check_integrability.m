function [ p, q, SE ] = check_integrability( normals )
%CHECK_INTEGRABILITY check the surface gradient is acceptable
%   normals: normal image
%   p : df / dx
%   q : df / dy
%   SE : Squared Errors of the 2 second derivatives

% initalization
% ========================================================================
[h, w, n] = size(normals);

p = zeros(h,w);
q = zeros(h,w);
SE = zeros(h,w);

% Compute p and q, where
% p measures value of df / dx = a(x,y) / c(x,y)
p = normals(:, :, 1) ./ normals(:, :, 3);
% q measures value of df / dy = b(x,y) / c(x,y)
q = normals(:, :, 2) ./ normals(:, :, 3);

% ========================================================================

% Make sure there or no NaN values inside the matrices
p(isnan(p)) = 0;
q(isnan(q)) = 0;

% ========================================================================
% approximate second derivate by neighbor difference
% and compute the Squared Errors SE of the 2 second derivatives SE
q_def = [zeros(h, 1), diff(q')'];
p_def = [zeros(1, w); diff(p)];
SE = (p_def - q_def).^2;
% ========================================================================

end

