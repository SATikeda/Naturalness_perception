function [ Xp, Xc ] = makeX( folder )
%MAKEX Summary of this function goes here
%   Detailed explanation goes here

load(sprintf('%s/hstCeSub.mat', folder));
load(sprintf('%s/hstCfSub.mat', folder));
load(sprintf('%s/hstPeSub.mat', folder));
load(sprintf('%s/hstPfSub.mat', folder));


[bin, n_ptn, plane, n_data] = size(hstPeSub);

Xp = zeros(n_data, n_ptn, plane, 2, bin);
Xc = zeros(n_data, n_ptn, plane, 2, bin);

for f=1:n_data
    for ptn = 1:n_ptn
        for p = 1:3
            Xp(f, ptn, p, 1, :) = double(hstPeSub(:, ptn, p, f))./ sum(double(hstPeSub(:, ptn, p, f)));
            Xp(f, ptn, p, 2, :) = double(hstPfSub(:, ptn, p, f))./ sum(double(hstPfSub(:, ptn, p, f)));
            Xc(f, ptn, p, 1, :) = double(hstCeSub(:, ptn, p, f))./ sum(double(hstCeSub(:, ptn, p, f)));
            Xc(f, ptn, p, 2, :) = double(hstCfSub(:, ptn, p, f))./ sum(double(hstCfSub(:, ptn, p, f)));
        end
    end    
end

end

