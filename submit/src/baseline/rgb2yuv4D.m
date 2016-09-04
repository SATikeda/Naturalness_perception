function [ YUV ] = rgb2yuv4D( img4D  )
%RGB2YUV RGB2YUV for 4D data
%   img4D:  sampled patches (4D data)

R = img4D(:,:,1, :);
G = img4D(:,:,2, :);
B = img4D(:,:,3, :);

%convert RGB to YUV
Y = 0.299*R + 0.587*G + 0.114*B;
U = 128 - 0.168736*R - 0.331264*G + 0.5*B;
V = 128 + 0.5*R - 0.418688*G - 0.081312*B;
YUV=cat(3,Y,U,V);

end
