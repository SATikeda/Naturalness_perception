function [ Xhat, phiK] = pca( x, k )
%PCA perform Principal Component Analysis
%    -    x: a series of data points
%    -    k: the number of new principal component
%    - Xhat: principal components
%    - phiK: feature map


%get size
[M,N] = size(x);

% compute covariance matrix
C = 1/M * x'*x;

% k should be less than the dimension
if k > size(C,1)
    k = size(C,1);
end

% perform eigen decomposition
[U,D] = eigs(C,k);

% compute the feature map
phiK =U';

% compute mapped X
Xhat = x*phiK';

end

