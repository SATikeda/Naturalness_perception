function [est_Pcls, est_Ccls ] = doSVM_PCA( XtrainPCA, XtestPCAC, XtestPCAP, YclsP, YclsC, n_fold, opt )
%DOSVMCVPCA do SVM classification for PCA-applied data
%    XtrainPCA:    cell array containing training images after PCA
%    XtestPCAC:    cell array containing CG images of test data after PCA
%    XtestPCAP:    cell array containing photo images of test data after PCA
%     YclsP:    photo image's label
%     YclsC:    CG image's label
%    n_fold:    number of fold
%       opt:   option for libsvm


% get the number of data
n_data = size(XtrainPCA{1},1)/2 + size(XtestPCAP{1},1);
% get the number of test data in each fold
n_testData = floor(n_data / n_fold);

% allocate memory
est_Pcls = -Inf*ones(n_data,1);
est_Ccls = -Inf*ones(n_data,1);

% cross validation
for cv =1:n_fold
    % get test ID
    testID = (cv-1)*n_testData+1:cv*n_testData;
    % get training ID
    trainID = setdiff(1:n_data, testID);
    % get labels for training data
    Ycls = [YclsP(trainID); YclsC(trainID)];
    % get feature matrix of training data
    X = XtrainPCA{cv};

    % get feature matrix of test data
    XtestC = XtestPCAC{cv};
    XtestP = XtestPCAP{cv};

    % get minimums and ranges of X
    minimums = min(X, [], 1);
    ranges = max(X, [], 1) - minimums;
    ranges(ranges==0) = 1;

    % normalization: make features [0, 1]
    X = (X - repmat(minimums, size(X, 1), 1)) ./ repmat(ranges, size(X, 1), 1);
    XtestC = (XtestC - repmat(minimums, size(XtestC, 1), 1)) ./ repmat(ranges, size(XtestC, 1), 1);
    XtestP = (XtestP - repmat(minimums, size(XtestP, 1), 1)) ./ repmat(ranges, size(XtestP, 1), 1);

    % train the classifier
    wcls = svmtrain(Ycls,X, opt);
    % predict labels for CG images
    est_Ccls((cv-1)*n_testData+1:cv*n_testData) = ...
        svmpredict(YclsC(testID), XtestC, wcls); 
    % predict labels for photo images
    est_Pcls((cv-1)*n_testData+1:cv*n_testData) = ...
        svmpredict(YclsP(testID), XtestP, wcls); 
end

sum([est_Pcls;est_Ccls] == [YclsP; YclsC])/(n_data*2)

end
