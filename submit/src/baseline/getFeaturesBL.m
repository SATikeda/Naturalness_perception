function [hstPe, hstPf, hstCe, hstCf] = getFeaturesBL( Xp, Xc, indices )
%GETFEATURES Get feature vectors (baseline)
%      Xp:   cell array containing photo images
%      Xc: Å@cell array containing CG images
% indices:   indices to extract patch data
%            indices are specified as linear indices of 17x17 block patch

% get the number of patch patterns (for baseline, this is set to 1)
n_ptn = size(indices,1);

% the number of planes
n_plane = 3;

% the number of data
n_data = size(Xp,1);

% allocate memory
hstPe = zeros(256, n_ptn, n_plane, n_data, 'int32');
fprintf(1, 'calculating histograms...\n');

% get samples for each photo image in edge region
parfor f=1:n_data
    % get 4000 samples from edge region
    samples = getEdgeSamplesBL(Xp{f}, indices);
    %calculate histogram
    hstPe(:,:,:,f) = calcHistBL(rgb2yuv4D(samples), n_ptn);
    f
end

% allocate memory
hstCe = zeros(256, n_ptn, n_plane, n_data, 'int32');
fprintf(1, 'calculating histograms...\n');

% get samples for each CG image in edge region
parfor f=1:n_data
    % get 4000 samples from edge region
    samples = getEdgeSamplesBL(Xc{f}, indices);
    % calculate histogram
    hstCe(:,:,:,f) = calcHistBL(rgb2yuv4D(samples), n_ptn);
    f
end


% allocate memory
hstPf = zeros(256, n_ptn, n_plane, n_data, 'int32');
fprintf(1, 'calculating histograms...\n');

% get samples for each photoimage in flat region
parfor f=1:n_data
    % get 4000 samples from flat region
    samples = getFlatSamplesBL(Xp{f}, indices);
    % calculate histogram
    hstPf(:,:,:,f) = calcHistBL(rgb2yuv4D(samples), n_ptn);
    f
end

% allocate memory
hstCf = zeros(256, n_ptn, n_plane, n_data, 'int32');
fprintf(1, 'calculating histograms...\n');

% get samples for each CG image in flat region
parfor f=1:n_data
    % get 4000 samples from flat region
    samples = getFlatSamplesBL(Xc{f}, indices);
    % calculate histogram
    hstCf(:,:,:,f) = calcHistBL(rgb2yuv4D(samples), n_ptn);
    f
end

end

