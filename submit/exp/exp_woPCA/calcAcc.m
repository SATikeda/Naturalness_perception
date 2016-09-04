function [ rst, c, g ] = calcAcc( Xp_org, Yp, Xc_org, Yc, f)
%CALCACC calculate accuracy of classification
%    Xp_org:    cell array containing photo images
%        Yp:    photo image's label
%    Xc_org:    cell array containing CG images
%        Yc:    CG image's label
%         f:    feature index used for classification

% get dimensions of feature matrix
[n_data, n_ptn, plane, area, nbin] = size(Xp_org);

% number of factors used for classifier
n_ptn = length(f);

% number of fold 
n_fold = 5;

%make feature matrix
Xp = reshape(Xp_org(:,f,:,:,:), n_data,  area*n_ptn *plane*nbin);
Xc = reshape(Xc_org(:,f,:,:,:), n_data,  area*n_ptn *plane*nbin);

% do cross validation
[acc, c, g] = findPrm(Xp, Yp, Xc, Yc, n_fold);

% return accuracy
rst(1,:) = acc;

end

