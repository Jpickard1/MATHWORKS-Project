function [outputArg1,(outputArg2] = sortE(E)
%SORTE Sorts hyperedge set first by size and then by vertex value
%
% Auth: Joshua Pickard
%       jpic@umich.edu
% Date: January 29, 2022

% Sort by size
[~,id] = sort( cellfun( @length, E));
Esize = E(id);

% Within each size, sort by order
lens = cellfun( @length, Esize);
uniqLens = unique(lens);
for i=1:length(uniqLens)
    % disp(i)
    idxs = find(lens == uniqLens(i));

    A = sortcell(Esize(idxs))
    
    Esize(idxs,:) = A(idxs,:);

    Esize{idxs} = sortcell(Esize(idxs))

end


Esorted = Etrue(id);

end

