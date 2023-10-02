function HG = load_HG(ds)
%LOAD_HG Summary of this function goes here
%   Detailed explanation goes here

% DS = {"DBLP", "Cora Reference", "Cora Citation", "Citeseer Reference", "Citeseer Citation"}
DS = {'DBLP', 'Cora Reference', 'Cora Citation', 'Citeseer Reference', 'Citeseer Citation', 'ArnetMiner Citation', 'Oddysey', 'ER'};

if ~any(strcmp(DS,ds))
    error('INVALID DATA SET: ' + ds)
end

if strcmp(ds, 'ER')
    HG = HAT.uniformErdosRenyi(20,20,3);
else
    S = HAT.load(ds);
    IM = full(S);
    HG = Hypergraph('IM', IM);
end

end

