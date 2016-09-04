% get features for analysing natural images

% get 11 x 11 block pattern
load('11x11_ptn');

% get # samples and plane
[n_sample, plane] = size(indices);

%get images
load('../../data/data');

% get number of data
n_data = size(Xp_sub,1);

% add path
addpath('../../src/ourmethod');

% calculate all combinations of 11 x 11 patch
all_comb = nchoosek(1:n_sample-1,2);

% allocate memory
hstPe = zeros(2^2, nchoosek(n_sample-1, 2), plane, n_data, 'uint16');
fprintf(1, 'calculating histograms...\n');

parfor f=1:n_data
    % get samples
    samples = getEdgeSamples(Xp_sub{f}, indices);
    % calculate histogram
    hstPe(:,:,:,f) = calcHist3comb(myRgb2yuv(samples), all_comb);
    f
end
save('features/hstPe', 'hstPe');
clear hstPe

% allocate memory
hstCe = zeros(2^2, nchoosek(n_sample-1, 2), plane, n_data, 'uint16');
fprintf(1, 'calculating histograms...\n');
parfor f=1:n_data
    % get samples
    samples = getEdgeSamples(Xc{f}, indices);
    % calc histogram
    hstCe(:,:,:,f) = calcHist3comb(myRgb2yuv(samples), all_comb);
    f
end
save('features/hstCe', 'hstCe');
clear hstCe

% allocate memory
hstPf = zeros(2^2, nchoosek(n_sample-1, 2), plane, n_data, 'uint16');
fprintf(1, 'calculating histograms...\n');
parfor f=1:n_data
    % get samples
    samples = getFlatSamples(Xp{f}, indices);
    % calc histogram
    hstPf(:,:,:,f) = calcHist3comb(myRgb2yuv(samples), all_comb);
    f
end
save('features/hstPf', 'hstPf');
clear hstPf

% allocate memory
hstPf = zeros(2^2, nchoosek(n_sample-1, 2), plane, n_data, 'uint16');
fprintf(1, 'calculating histograms...\n');
parfor f=1:n_data
    % get samples
    samples = getFlatSamples(Xc{f}, indices);
    % calc histogram
    hstCf(:,:,:,f) = calcHist3comb(myRgb2yuv(samples), all_comb);
    f
end
save('features/hstCf', 'hstCf');
clear hstCf
