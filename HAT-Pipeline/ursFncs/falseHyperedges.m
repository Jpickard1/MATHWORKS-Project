function [F] = falseHyperedges(HGtrue, U)
%FALSEHYPEREDGES Generate false hyperedges for hyperedge prediction
%
% Auth: Joshua Pickard
%       jpic@umich.edu
% Date: January 29, 2023

alpha = 0.5;

F = cell(length(U), 1);
for i=1:length(U)
    e = find(HGtrue.IM(:, U(i)) ~= 0);
    if length(e) < 2
        continue
    end
    n = round(alpha * length(e));
    v = randsample(1:length(e), n);

    replacements = setdiff(1:size(HG.IM, 1), e);
    for j=1:length(v)
        e(v(j)) = randsample(replacements, 1);
        % TODO: make sure one vertex isn't inserted twice

    end
    F{i} = e;
end

% TODO: explicitly verify all false hyperedges are truely false

end

