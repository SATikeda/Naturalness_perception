function [ YUV ] = myRgb2yuv( img  )
%RGB2YUV RGB2yuv conversion
%   img:    image data

R = img(:,1, :);
G = img(:,2, :);
B = img(:,3, :);

%convert RGB to YUV
Y = 0.299*R + 0.587*G + 0.114*B;
U = 128 - 0.168736*R - 0.331264*G + 0.5*B;
V = 128 + 0.5*R - 0.418688*G - 0.081312*B;
YUV=cat(2,Y,U,V);

end
