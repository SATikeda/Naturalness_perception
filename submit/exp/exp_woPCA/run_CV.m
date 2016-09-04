%% calculate cross validation

clear all
addpath('../../tool\libsvm-3.21/windows');

%% get subjective scores
score = xlsread('../../data/results.xlsx', 'C2:C2521');
Yc = score(1:2:2520);
Yp = score(2:2:2520);

med = median(score);
YcSub = double(Yc > med);
YcSub(YcSub == 0) = -1;
YpSub = double(Yp > med);
YpSub(YpSub == 0) = -1;

YcCls = -ones(1260,1);
YpCls = ones(1260,1);

% baseline
[XpSub, XcSub] = makeX('../../features/features_baseline');
rst_BL = zeros(1,2);
rst_BL(1,1) = calcAcc (XpSub, YpSub, XcSub, YcSub, 1);
rst_BL(1,2) = calcAcc (XpSub, YpCls, XcSub, YcCls, 1);

% threshold:2, 3 factorization
[XpSub, XcSub] = makeX('../../features/features_fact3/features_th2');
rst_th2_fact3 = zeros(3,2); % n=6, n=12, n = 25
rst_th2_fact3(1,1) = calcAcc (XpSub, YpSub, XcSub, YcSub, 1:6);
rst_th2_fact3(1,2) = calcAcc (XpSub, YpCls, XcSub, YcCls, 1:6);
rst_th2_fact3(2,1) = calcAcc (XpSub, YpSub, XcSub, YcSub, 1:12);
rst_th2_fact3(2,2) = calcAcc (XpSub, YpCls, XcSub, YcCls, 1:12);
rst_th2_fact3(3,1) = calcAcc (XpSub, YpSub, XcSub, YcSub, 1:25);
rst_th2_fact3(3,2) = calcAcc (XpSub, YpCls, XcSub, YcCls, 1:25);

% threshold:4, 3 factorization
[XpSub, XcSub] = makeX('../../features/features_fact3/features_th4');
rst_th4_fact3 = zeros(4,2); % n=6, n=12, n = 25, 5x5 block
rst_th4_fact3(1,1) = calcAcc (XpSub, YpSub, XcSub, YcSub, 1:6);
rst_th4_fact3(1,2) = calcAcc (XpSub, YpCls, XcSub, YcCls, 1:6);
rst_th4_fact3(2,1) = calcAcc (XpSub, YpSub, XcSub, YcSub, 1:12);
rst_th4_fact3(2,2) = calcAcc (XpSub, YpCls, XcSub, YcCls, 1:12);
rst_th4_fact3(3,1) = calcAcc (XpSub, YpSub, XcSub, YcSub, 1:25);
rst_th4_fact3(3,2) = calcAcc (XpSub, YpCls, XcSub, YcCls, 1:25);


% threshold:6, 3 factorization
[XpSub, XcSub] = makeX('../../features/features_fact3/features_th6');
rst_th6_fact3 = zeros(4,2); % n=6, n=12, n = 25, 5x5 block
rst_th6_fact3(1,1) = calcAcc (XpSub, YpSub, XcSub, YcSub, 1:6);
rst_th6_fact3(1,2) = calcAcc (XpSub, YpCls, XcSub, YcCls, 1:6);
rst_th6_fact3(2,1) = calcAcc (XpSub, YpSub, XcSub, YcSub, 1:12);
rst_th6_fact3(2,2) = calcAcc (XpSub, YpCls, XcSub, YcCls, 1:12);
rst_th6_fact3(3,1) = calcAcc (XpSub, YpSub, XcSub, YcSub, 1:25);
rst_th6_fact3(3,2) = calcAcc (XpSub, YpCls, XcSub, YcCls, 1:25);

save;