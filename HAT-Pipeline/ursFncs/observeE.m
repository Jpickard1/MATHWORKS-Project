function [O] = observeE(HG, k, B, itrs, trials)
%OBSERVEE Summary of this function goes here
%   Detailed explanation goes here
% B = 2 : No bias
% B = 1 : Bias toward high
% B = 0 : Bias toward low
% HG = load_HG("DBLP")
% B=1;k=0.1;itrs=10;

% O = size(HG.IM,2)
O = cell(itrs*trials, 1);
O{1} = HG;
for i=1:trials
    IM = HG.IM;
    for j=1:itrs
        [n, m] = size(IM);
        mp = (1-k) * m;
        if B==2
            p = ones(m);
            p = p / sum(p);
            p = p';
        else
            p = hyperedgePopularity(IM);
            if B==0
                p = 1./p;
            end
            p = p / sum(p);
        end
        
        Ep = [];
        
        while length(Ep) < mp
            p = p/sum(p);
            cp = [0, cumsum(p)];
            r = rand;
            e = find(r>cp, 1, 'last');
            p(e) = 0;
            Ep = [Ep e];
        end
        
        Vp = find(sum(IM(:,Ep)') ~= 0);
        IMp = IM(Vp, Ep);
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

