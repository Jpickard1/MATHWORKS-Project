function [pop] = hyperedgePopularity(IM)
%HYPEREDGEPOPULARITY Summary of this function goes here
%   Detailed explanation goes here

[v,e] = size(IM);
vD = sum(IM');
IMd = repmat(vD',[1, e]);
IMd(find(IM==0)) = 1;
pop = prod(IMd,1);

end

