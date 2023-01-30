function [outputArg1,outputArg2] = hyperedgePredictionDriver(O, itrs, trials)
%HYPEREDGEPREDICTION Performs hyperedge prediction on subhypergraphs using
%   local similarity indices.
%
%       itrs = 5; trials = 2;
%
% Auth: Joshua Pickard
%       jpic@umich.edu
% Date: January 1, 2022

% Extract Ground Truth Hyperedge Set
HGtrue = O{1}{1};

% Extract set of subhypergraphs produced from iteration 1
Opredict = cell(6,length(2:itrs:length(O{1})));
for i=1:6
    disp(2:itrs:length(O{i}));
    Opredict(i,:) = O{i}(2:itrs:length(O{i}));
end

%%

predictions = cell(6,1);
for i=1:6
    % params = cell(length(Opredict(i,:)), 1);
    scores = cell(length(Opredict(i,:)), 1);
    labels = cell(length(Opredict(i,:)), 1);
    for j=1:length(Opredict(i,:))
        HGobserved = Opredict{i,j};
        [labels{j}, scores{j}] = predictHyperedges(HGtrue, HGobserved);
    end
    predictions{i} = {labels, scores};
end
save('Predictions.mat',"predictions");

%%
O1 = O{1}(2:itrs:end);

% O(:)(2:itrs:end)

HGs = O{1}{2};
[n, e] = size(HGs.IM);
Etrue = cell(e, 1);
[v, e] = find(HGs.IM ~= 0);
for i=1:max(e)
    Es{i} = v(find(e==i));
end

ismember(Etrue, Es)


[~,id] = sort( cellfun( @length, Etrue ));
Esorted = Etrue(id);
Esorted = sortcell(Etrue, 1)

for i=1:4
    m = cell(itrs, 1);
    s = cell(itrs, 1);
    for j=0:(itrs-1)
        E = zeros(trials, 1);
        M = zeros(trials, 1);
        for k=1:trials
            disp(j+1 + ((k-1) * itrs));
            HG = O{i}{j+1 + ((k-1) * itrs)};
            [score, label, params] = hyperedgePrediction(HGtrue, HG);
            [x, y] = size(HG.IM);
            M(k) = x;
            E(k) = y;
        end
        m{j+1} = mean(M);
        s{j+1} = std(M);
    end
    t1 = [t1 m s];
end

end
