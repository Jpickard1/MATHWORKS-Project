function [O] = observeV(HG, k, B, itrs, trials)
%OBSERVEV Summary of this function goes here
%   Detailed explanation goes here
%
%   observeV(HG, 0.1, 2, 5, 2)
%
% B = 2 : No bias
% B = 1 : Bias toward high
% B = 0 : Bias toward low
% O = size(HG.IM,1)

O = cell(itrs*trials, 1);
O{1} = HG;
for i=1:trials
    IM = HG.IM;
    for j=1:itrs
        [n, m] = size(IM);
        mp = (1-k) * m;
        if B==2
            p = ones(n);
            p = p / sum(p);
            p = p';
        else
            p = sum(IM');
            if B==0
                p = 1./p;
            end
            p = p / sum(p);
        end
        
        Ep = 0;
        Vp = [];
        
        while Ep < mp
            p = p/sum(p);
            cp = [0, cumsum(p)];
            r = rand;
            v = find(r>cp, 1, 'last');
            p(v) = 0;
            Vp = [Vp v];
            Ep = length(find(sum(IM(Vp,:)) ~= 0));
        end
        
        Ep = find(sum(IM(Vp,:)) ~= 0);
        IMp = IM(Vp, Ep);
        HGp = Hypergraph('IM', IMp);
        
        if j ~= 1
            HGp.nodeNames = O{(i-1)*itrs+j}.nodeNames(Vp);
            HGp.edgeNames = O{(i-1)*itrs+j}.edgeNames(Ep);
        else
            HGp.nodeNames = O{1}.nodeNames(Vp);
            HGp.edgeNames = O{1}.edgeNames(Ep);
        end

        O{(i-1)*itrs+j+1} = HGp;
        IM = IMp;
    end
end
disp('Run!')
end

%{
for i=1:itrs
    disp(size(O{i}.IM))
end
%}