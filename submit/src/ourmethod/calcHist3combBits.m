function [ hst ] = calcHist3combBits( samples, bid, ths )
%CALCHIST calc histogram with multiple 
%  samples:     sampled patch
%      bid:     set of factors
%      ths:     thresholds for quantization

% get size
[n_pixels, plane, n_points] = size(samples);

% get number of intensity levels
n_bits = size(ths,3)+1;

% get number of factors
n_ptn = size(bid,1);

% allocate memory
hst = zeros(n_bits^2, n_ptn, 3, 'uint32');

% centering the data
sc = bsxfun(@minus, int32(samples), int32(samples(1,:,:)));

%remove centered pixel
sc8 = sc(2:n_pixels, :, :);

% quantize the intensity
b = zeros(size(sc8), 'uint8');
for i = 1:n_bits-1
    b = b + uint8(bsxfun(@le,sc8, ths(:,:, i)));
end
code = n_bits*uint8(b(bid(:,1), :, :)) + uint8(b(bid(:,2), :, :))+1;

% calculate joint probability
for c = 1:n_bits^2
     hst(c,:,:)= sum(code == c,3);
end

end

