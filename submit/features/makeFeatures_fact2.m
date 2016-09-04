%% get features for our method (thir order factorization)

% load sampling shape
load('11x11_ptn');

% load threshold for binary
load('ths_2');

% factorization candidates
load('comb_2factor');
comb = comb_2factor;

% get the number of factors
n_ptn = size(comb,1);

% initialize random seed
rng(2016);

%get data
load('../data/data');

% add path
addpath('../src/2factorization');

%% get features for 2 gray level
[hstPeSub, hstPfSub, hstCeSub, hstCfSub] = getFeatures_2fact( Xp_sub, Xc_sub, indices, comb, thsE, thsF );
save('features_fact2/features_th2/hstPeSub', 'hstPeSub');
save('features_fact2/features_th2/hstPfSub', 'hstPfSub');
save('features_fact2/features_th2/hstCeSub', 'hstCeSub');
save('features_fact2/features_th2/hstCfSub', 'hstCfSub');
clear hstPeSub;
clear hstPfSub;
clear hstCfSub;
clear hstCeSub;

rng(2016);
% load threshold for four gray levels
load('ths_4');

%% get features for 4 gray level
[hstPeCls, hstPfCls, hstCeCls, hstCfCls] = getFeatures_2fact( Xp_cls, Xc_cls, indices, comb, thsE, thsF );
save('features_fact2/features_th4/hstPeSub', 'hstPeSub');
save('features_fact2/features_th4/hstPfSub', 'hstPfSub');
save('features_fact2/features_th4/hstCeSub', 'hstCeSub');
save('features_fact2/features_th4/hstCfSub', 'hstCfSub');
clear hstPeSub;
clear hstPfSub;
clear hstCfSub;
clear hstCeSub;


rng(2016);
% load threshold for four gray levels
load('ths_6');

%% get features for six gray levels
[hstPeCls, hstPfCls, hstCeCls, hstCfCls] = getFeatures_2fact( Xp_cls, Xc_cls, indices, comb, thsE, thsF );
save('features_fact2/features_th6/hstPeSub', 'hstPeSub');
save('features_fact2/features_th6/hstPfSub', 'hstPfSub');
save('features_fact2/features_th6/hstCeSub', 'hstCeSub');
save('features_fact2/features_th6/hstCfSub', 'hstCfSub');
clear hstPeSub;
clear hstPfSub;
clear hstCfSub;
clear hstCeSub;

clear all;









