function [ X ] = getImages( fname )
%GETIMAGES get images from folder
% fname:   folder name

% get file names
flist = dir(fname);

% split file path and file names
[path, name, ext] = fileparts(fname);

% allocate memory to store image data
X= cell(length(flist), 1);

for i = 1:length(X)
    % read image
    img = imread(sprintf('%s\\%s', path, flist(i).name));
    % store image
    X{i} = img;
end


end

