function [O] = collectSubhypergraphs5(ds, OE0, OE1, OE2, OE3, OE4)
%COLLECT Summary of this function goes here
%   Detailed explanation goes here
%
% Auth: Joshua Pickard
%       jpic@umich.edu
% Date: January 30 2023

O = cell(6,1);
O{1} = OE0;
O{2} = OE1;
O{3} = OE2;
O{4} = OE3;
O{5} = OE4;

filename = ds + "_Observations.mat";
save(filename, "O")

end

