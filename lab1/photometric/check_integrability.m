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
[h,w,d] = size(normals);
% ========================================================================
% YOUR CODE GOES HERE
% Loop over each normal to calculate p's and q's
for r = 1:h
    for c = 1:w
    % Compute p and q, where
    % p measures value of df / dx = a(x,y)/c(x,y)
    p_ = normals(r,c,1) / normals(r,c,3);
    % q measures value of df / dy = 
    q_ = normals(r,c,2) / normals(r,c,3);

    end
end

% ========================================================================



p(isnan(p)) = 0;
q(isnan(q)) = 0;



% ========================================================================
% YOUR CODE GOES HERE
% approximate second derivate by neighbor difference
% and compute the Squared Errors SE of the 2 second derivatives SE


% ========================================================================




end

