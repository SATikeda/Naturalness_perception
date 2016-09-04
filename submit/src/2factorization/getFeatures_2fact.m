function [hstPe, hstPf, hstCe, hstCf] = getFeatures_2fact( Xp, Xc, indices, comb, thsE, thsF )
%GETFEATURES Get feature vectors (baseline)
%      Xp:   cell array containing photo images
%      Xc: Å@cell array containing CG images
% indices:   indices to extract patch data
%            indices are specified as linear indices of 17x17 block patch
%    comb:   indices of factors; (n x 2) matrix, where n is the number offactors
%    thsE:   threshold for edge samples
%    thsF:   threshold for flat samples

% get the number of factors
n_ptn = size(comb,1);

% get the number of planes
plane = size(indices,2);

% get the number of data
n_data = size(Xp,1);

% get the number of intensity levels
n_bits = size(thsE,3) +1;

% allocate memory
hstPe = zeros(n_bits, n_ptn, plane, n_data, 'uint32');
fprintf(1, 'calculating histograms...\n');

% get samples for each photo image in edge region
parfor f=1:n_data
    % get 4000 samples from edge region
    samples = getEdgeSamples(Xp{f}, indices);
    %calculate histogram
    hstPe(:,:,:,f) = calcHist2combBits(myRgb2yuv(samples), comb, thsE);
    f
end

%allocate memory
hstCe = zeros(n_bits, n_ptn, plane, n_data, 'uint32');
fprintf(1, 'calculating histograms...\n');

% get samples for each CG image in edge region
parfor f=1:n_data
    % get 4000 samples from edge region
    samples = getEdgeSamples(Xc{f}, indices);
    % calculate histogram
    hstCe(:,:,:,f) = calcHist2combBits(myRgb2yuv(samples), comb, thsE);
    f
end

% allocate memory
hstPf = zeros(n_bits, n_ptn, plane, n_data, 'uint32');
fprintf(1, 'calculating histograms...\n');

% get samples for each photo image in flat region
parfor f=1:n_data
    % get 4000 samples from flat region
    samples = getFlatSamples(Xp{f}, indices);
    % calculate histogram
    hstPf(:,:,:,f) = calcHist2combBits(myRgb2yuv(samples), comb, thsF);
    f
end

% allocate memory
hstCf = zeros(n_bits, n_ptn, plane, n_data, 'uint32');
fprintf(1, 'calculating histograms...\n');

% get samples for each CG image in flat region
parfor f=1:n_data
    % get 4000 samples from flat region
    samples = getFlatSamples(Xc{f}, indices);
    % calculate histogram
    hstCf(:,:,:,f) = calcHist2combBits(myRgb2yuv(samples), comb, thsF);
    f
end

end

