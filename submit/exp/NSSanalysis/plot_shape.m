%% show obtained shape

% set patch size
p_size=11;

% get obtained result
load(sprintf('comb_%dx%d', p_size, p_size));

%% show the factors
% allocate memory
union_ptn = zeros(p_size, p_size);
% center of the patch
center = (p_size*p_size+1)/2;
for i=1:size(comb,1)
    id = comb(i,:);
    id = id + (id >= center); 
    union_ptn(id(1)) = union_ptn(id(1))+1;
    union_ptn(id(2)) = union_ptn(id(2))+1;
    imagesc(union_ptn <= 0);colormap(gray);
    i
    pause;
end