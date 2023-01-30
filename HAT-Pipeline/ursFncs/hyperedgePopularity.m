function [pop2] = hyperedgePopularity(IM)
%HYPEREDGEPOPULARITY Summary of this function goes here
%   Detailed explanation goes here
% Auth: Joshua Pickard
%       jpic@umich.edu
% Date: January 27, 2023

[v,e] = size(IM);
vD = sum(IM');
pop2 = zeros(e,1);
for i=1:e
    pop2(i) = prod(vD(find(IM(:,i) ~= 0)));
end



end

