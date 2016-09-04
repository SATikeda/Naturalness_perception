function [ samples ] = getEdgeSamples( img, indices )
%GETSAMPLES get edge samples(baseline)
%     img:    an image data
% indices:    indices to extract patch data

    % the number of patch patterns (this should be 1 in baseline)
    n_ptn = size(indices,1);

   % apply edge detection by canny filter
     BW1 = edge(rgb2gray(img),'Canny');
    [h, w] = find(BW1 == 1);
    
    % get image size
    [Height, Width] = size(BW1);

    % remove the indeces of end of the image
    id = find(w >= 9 & w <= Width-9 & h >= 9 & h <= Height-9); 
    w = w(id);
    h = h(id);

    % sample 4000 point at random if possible
    if length(id) < 4000
        idx = randi(length(id), length(id), 1);
    else
        idx = randi(length(id), 4000, 1);
    end

    % allocate memory
    samples = zeros(n_ptn, 3, length(idx), 'uint8'); 
    
    % get samples
    for i=1:length(idx)
        % get the center pixel
        I = idx(i);
        % get 17 x 17 patch
        tmp = img(h(I)-8:h(I)+8, w(I)-8:w(I)+8, :);
        % get the patch data by 'indeces'
        samples(:,:, i) = tmp(indices);
    end

end
