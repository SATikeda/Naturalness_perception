%% calculate variance of the probability
clear all

% load features
load('features_11x11/hstPf.mat');
load('features_11x11/hstPe.mat');
load('features_11x11/hstCf.mat');
load('features_11x11/hstCe.mat');

% set patch size
p_size = 11;

% get the number of pixels in a patch
n_size = p_size*p_size-1;

% get size
[bin, n_ptn, plane, n_data] = size(hstPe);

% allocate memory
v = zeros(n_ptn,3);

% calculate variance
for plane=1:3
    edges = cat(4, hstCe, hstPe);
    edges = squeeze(edges(:,:,plane,:));
    for i=1:n_ptn
        p = double(squeeze(edges(:,i,:)));
        p = bsxfun(@times, p, 1./sum(p));
        v(i, plane) = mean(var(p'));
    end
end

% take the mean of the variance of probabilities
v = mean(v,2);

% sort the variance
[~, id] = sort(v, 'descend');

% get the all combination of factors
ptn = nchoosek(1:n_size, 2);
% sort the combination in descendent order of variance
o_ptn = ptn(id,:);


%% get the candidates  for factorization
all = 1:n_size;
left = all;
cnt = 1;
tmp = zeros(5,5);
clear comb;
for i=1:size(o_ptn,1)
    cand = o_ptn(i,:);
    if sum(ismember(left, cand(1))) > 0 && sum(ismember(left, cand(2))) > 0
        comb(cnt,:) = cand;
        left = setdiff(left, cand);
        cnt = cnt+1;
    end
    if isempty(left)
        break;
    end
end

save(sprintf('comb_%dx%d', p_size, p_size),'comb');







