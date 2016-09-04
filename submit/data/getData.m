clear all
close all
rng(2016);

%% get images for naturalness perception
Xp_sub = getImages('../images/*_photo.jpg');
Xc_sub = getImages('../images/*_CG.jpg');

save('data', 'Xp_sub', 'Xc_sub');

