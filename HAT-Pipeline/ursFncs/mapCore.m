function [H] = mapCore(nodeNames, H)
%MAPCORE This function maps hyperedges from true hypergraph to hyperedges
%   in observed hypergraph.
%
% Auth: Joshua Pickard
%       jpic@umich.edu
% Date: January 29, 2023

for i=1:length(H)
    % find(H{i} == nodeNames);
    [~,loc] = ismember(nodeNames, H{i});
    e = find(loc~=0);
    if length(e) < 2
        e = [];
    end
    H{i} = e;
end

end

