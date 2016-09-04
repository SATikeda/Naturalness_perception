function [est_Pcls, est_Ccls ] = doSVM_cls( Xp, YclsP, Xc, YclsC, n_fold, opt )
%DOSVMCV do SVM classification
%        Xp:    cell array containing photo images
%     YclsP:    photo image's label
%        Xc:    cell array containing CG images
%     YclsC:    CG image's label
%    n_fold:    number of fold
%       opt:   option for libsvm

% get data size
n_data = size(Xp,1);
% get test daata size in each fold
n_testData = floor(n_data / n_fold);

%allocate memory 
est_Pcls = -Inf*ones(n_data,1);
est_Ccls = -Inf*ones(n_data,1);

% cross validation
for cv =1:n_fold
    % get test data ID
    testID = (cv-1)*n_testData+1:cv*n_testData;
    % get training data ID
    trainID = setdiff(1:n_data, testID);
    % get label for training data
    Ycls = [YclsP(trainID); YclsC(trainID)];
    % get feature matrix of training data
    X = [Xp(trainID,:); Xc(trainID,:)];

    % get test data
    XtestC = Xc(testID,:);
    XtestP = Xp(testID,:);

    % get minimums and ranges of features
    minimums = min(X, [], 1);
    ranges = max(X, [], 1) - minimums;
    ranges(ranges==0) = 1;
    
    % normalization: make features [0, 1]
    X = (X - repmat(minimums, size(X, 1), 1)) ./ repmat(ranges, size(X, 1), 1);
    XtestC = (XtestC - repmat(minimums, size(XtestC, 1), 1)) ./ repmat(ranges, size(XtestC, 1), 1);
    XtestP = (XtestP - repmat(minimums, size(XtestP, 1), 1)) ./ repmat(ranges, size(XtestP, 1), 1);

    % train classifier
    wcls = svmtrain(Ycls,X, opt);
    % predict labels for CG images
    est_Ccls((cv-1)*n_testData+1:cv*n_testData) = ...
        svmpredict(YclsC(testID), XtestC, wcls); 
    % predict labels for photoimages
    est_Pcls((cv-1)*n_testData+1:cv*n_testData) = ...
        svmpredict(YclsP(testID), XtestP, wcls); 
end

% show accuracy
sum([est_Pcls;est_Ccls] == [YclsP; YclsC])/(n_data*2)

end
