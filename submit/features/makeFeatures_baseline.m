%% make features for baseline 

% add path
addpath('../src/baseline');

% load 3x3 patch pattern
load('idx_3x3patch');

% initialize random seed
rng(2016);

% load data
load('../data/data');

%get features
[hstPeSub, hstPfSub, hstCeSub, hstCfSub] = getFeaturesBL( Xp_sub, Xc_sub, indices );
save('features_baseline/hstPeSub', 'hstPeSub');
save('features_baseline/hstPfSub', 'hstPfSub');
save('features_baseline/hstCeSub', 'hstCeSub');
save('features_baseline/hstCfSub', 'hstCfSub');

