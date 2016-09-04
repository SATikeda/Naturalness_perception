function [ bestcv, bestc, bestg ] = findPrmPCA( Xp, YclsP, Xc, YclsC, n_fold, k )
%FINDPRMPCA find best parameter for classification
%        Xp:    cell array containing photo images
%     YclsP:    photo image's label
%        Xc:    cell array containing CG images
%     YclsC:    CG image's label
%    n_fold:    number of fold
%         k:    number of dimensions after PCA

% get the number of data
n_data = size(Xp,1);
bestcv = 0;

% allocate memory to store the converted data by PCA
XtrainPCA = cell(n_fold,1);
XtestPCAC = cell(n_fold,1);
XtestPCAP = cell(n_fold,1);
n_testData = floor(n_data / n_fold);

% apply PCA to training data for each fold
for cv =1:n_fold
    % get test data ID
    testID = (cv-1)*n_testData+1:cv*n_testData;
    % get training data ID
    trainID = setdiff(1:n_data, testID);
    % get feature matrix of training data
    X = [Xp(trainID,:); Xc(trainID,:)];
    % apply PCA
    [ Xtrain, phiK] = pca( bsxfun(@minus, X, mean(X,1)), k );
    % store the transformed data
    XtrainPCA{cv} = Xtrain;
    % apply projection matrix to test data
    XtestPCAC{cv} = bsxfun(@minus, Xc(testID,:), mean(X,1))*phiK';
    % apply projection matrix to test data
    XtestPCAP{cv} = bsxfun(@minus, Xp(testID,:), mean(X,1))*phiK';    
end


% try parameter C and g
for log2c = -1:2:3,
  for log2g = -4:2:1,
    % specify the parameters C and g
    cmd = ['-q -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)];
    % do SVM
    [est_Pcls, est_Ccls ] = doSVM_PCA( XtrainPCA, XtestPCAC, XtestPCAP, YclsP, YclsC, n_fold, cmd);
    % get accuracy
    cv = sum([est_Pcls;est_Ccls] == [YclsP; YclsC])/(n_data*2);
    % update the best parameter
    if (cv >= bestcv),
      bestcv = cv; bestc = 2^log2c; bestg = 2^log2g;
    end
    fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', log2c, log2g, cv, bestc, bestg, bestcv);
  end
end


end

