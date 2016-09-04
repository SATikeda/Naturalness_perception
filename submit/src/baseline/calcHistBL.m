function [ hst ] = calcHistBL( samples, n_ptn )
%CALCHIST cont histogram (baseline method
% samples:  sampled patches
% n_ptn:    the number of patch pattern 
%           (for baseline, we use 3x3 patch shape only, thus usually set to 1)

% allocate memory for histograms
hst = zeros(256, n_ptn, 3, 'int32');

% subtract center pixel from neighbors
sc = int32(samples) - int32(repmat(samples(1,:,:, :), 9, 1, 1, 1));

% remove the center pixel
sc8 = sc([2 3 4 5 6 7 8 9],:,:, :);

for p=1:3
    for ptn=1:n_ptn
        % binarize the image
        b = squeeze(sc8(:,ptn,p,:) > 0);

        % calculate codes
        id = [2^7 2^6 2^5 2^4 2^3 2^2 2^1 2^0] * double(b)+1;

        % count histogram
        hst(:,ptn, p) = int32(histcounts(id, 1:257))';
    end
end

end

