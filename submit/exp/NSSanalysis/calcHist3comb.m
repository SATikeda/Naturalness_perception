function [ hst ] = calcHist3comb( samples, all_comb )
%CALCHIST calculate histogram for third order statistics
%   samples:     sampled patch
%  all_comb:     all combinations of factors

% get size
[n_pixels, plane, n_points] = size(samples);

% get number of factors
n_ptn = size(all_comb,1);

% allocate memory
hst = zeros(2^2, n_ptn, 3,'uint32');

% centering the data
sc = bsxfun(@minus, int16(samples), int16(samples(1,:,:)));

%remove centered pixel
sc8 = sc(2:n_pixels, :, :);

% binarize the pixel
b = sc8 > 0;

% calculate code
code = 2*uint8(b(all_comb(:,1), :, :)) + uint8(b(all_comb(:,2), :, :))+1;

% calculate histogram
for c = 1:4
     hst(c,:,:)= sum(code == c,3);
end

end

