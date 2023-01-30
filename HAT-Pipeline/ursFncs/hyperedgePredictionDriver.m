function [predictions] = hyperedgePredictionDriver(O, itrs, trials)
%HYPEREDGEPREDICTION Performs hyperedge prediction on subhypergraphs using
%   local similarity indices.
%
%       itrs = 5; trials = 2;
%
% Auth: Joshua Pickard
%       jpic@umich.edu
% Date: January 29, 2023

% Extract Ground Truth Hyperedge Set
HGtrue = O{1}{1};

% Extract set of subhypergraphs produced from iteration 1
Opredict = cell(6,length(2:itrs:length(O{1})));
for i=1:length(O)
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

end

