function [O] = collectSubhypergraphs(OVH,OVN,OVL,OEH,OEN,OEL)
%COLLECT Summary of this function goes here
%   Detailed explanation goes here

O = cell(6,1);
O{1} = OVH;
O{2} = OVN;
O{3} = OVL;
O{4} = OEH;
O{5} = OEN;
O{6} = OEL;

save('Observations.mat',"O");

end

