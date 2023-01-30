function [O] = observeEr(HG, k, r, itrs, trials)
%OBSERVEE Summary of this function goes here
%   Detailed explanation goes here
% B = 2 : No bias
% B = 1 : Bias toward high
% B = 0 : Bias toward low
% HG = load_HG("DBLP")
% B=1;k=0.1;itrs=10;
%
% Auth: Joshua Pickard
%       jpic@umich.edu
% Date: January 30, 2023

O = cell(itrs*trials, 1);
O{1} = HG;
for i=1:trials
    IM = HG.IM;
    for j=1:itrs
        [n, m] = size(IM);
        mp = (1-k) * m;
        
        p = hyperedgePopularity(IM);
        p = p .^ r;
        p = p / sum(p);
        
        Ep = [];
        
        while length(Ep) < mp
            p = p/sum(p);
            cp = [0, cumsum(p)];
            r = rand;
            e = find(r>cp, 1, 'last');
            p(e) = 0;
            Ep = [Ep e];
        end
        
        IMp = IM(:, Ep);
        HGp = Hypergraph('IM', IMp);
        
        if j ~= 1
            HGp.nodeNames = O{(i-1)*itrs+j}.nodeNames(Vp);
            HGp.edgeNames = O{(i-1)*itrs+j}.edgeNames(Ep);
        else
            HGp.nodeNames = O{1}.nodeNames(Vp);
            HGp.edgeNames = O{1}.edgeNames(Ep);
        end

        O{(i-1)*itrs + j+1} = HGp;
        IM = IMp;
    end
end

end

