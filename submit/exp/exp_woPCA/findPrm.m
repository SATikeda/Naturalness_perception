function [ bestcv, bestc, bestg ] = findPrm( Xp, YclsP, Xc, YclsC, n_fold )
%FINDPRM find best parameter for classification
%        Xp:    cell array containing photo images
%     YclsP:    photo image's label
%        Xc:    cell array containing CG images
%     YclsC:    CG image's label
%    n_fold:    number of fold

% get data size
n_data = size(Xp,1);

% try parameter C and g
bestcv = 0;
for log2c = -1:2:3,
  for log2g = -4:2:1,
    % specify the parameters C and g
    cmd = ['-q -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)];
    % do SVM
    [est_Pcls, est_Ccls ] = doSVM_cls( Xp, YclsP, Xc, YclsC, n_fold, cmd );
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

