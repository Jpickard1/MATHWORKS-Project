function [K, U] = partitionE(HG, k)
%PARTITIONE Summary of this function goes here
%   Detailed explanation goes here
%
% AUTH: Joshua Pickard
%       jpic@umich.edu
% DATE: January 31, 2023

popE = hyperedgePopularity(HG.IM);
popSort = sort(popE);
cutOffIdxs = round(1:length(popSort)/(k):length(popSort));
cutOffs = popSort(cutOffIdxs);
cutOffs(end+1) = Inf;

K = cell(k, 1);
U = cell(k, 1);
for i=1:k
    U{i} = find(and(popE >= cutOffs(i), popE < cutOffs(i+1)));
    K{i} = find(or(popE < cutOffs(i), popE >= cutOffs(i+1)));
end

end

