function [labels, scores] = predictHyperedges(HGtrue, HGobserved)
%PREDICTHYPEREDGES 
%
% Auth: Joshua Pickard
%       jpic@umich.edu
% Date: January 29, 2023


%% Params
nPredictors = 2;    % Number of predicotrs to use
predictors = ["CN", "LHN"];   % List of predictors

%% Set hyperedges to predict

T = HGtrue.edgeNames;               % True hyperedges
K = HGobserved.edgeNames;           % Known hyperedges
Uidx = setdiff(T,K);                % Unknown hyperedge idxs
U = trueHyperedges(HGtrue, Uidx, HGobserved.nodeNames);   % True hyperedge cell array
F = falseHyperedges(HGtrue, Uidx, HGobserved.nodeNames);  % False hyperedge cell array

% TODO: uncomment this line
% clear HGtrue;   % Delete true structure to prevent any information 
                  % accidentally being used for predictions

H = [F; U];                             % True + False hyperedges to evaluate
H = mapCore(HGobserved.nodeNames, H);   % Map idxs from HGtrue to idxs of HG observed
labels = ones(length(H), 1);            % Set True labels
labels(1:length(F)) = 0;                % Set False labels
scores = zeros(length(H), nPredictors); % Scores of each hyperedge for each predictor

% Repeat for each predictor type
% H = repmat(H, nPredictors, 1);
% labels = repmat(labels, nPredictors, 1);
% params = repmat(params, nPredictors, 1);

%% Compute pairwise similarity matrices
C = full(HGobserved.cliqueGraph);
similarity = cell(nPredictors, 1);
for i=1:nPredictors
    disp(predictors(i))
    similarity{i} = compute_similarity(C, predictors(i));
end

%% Score Hyperedges

ss = size(similarity{1});

% parfor i=1:length(H)
for i=1:length(H)
    e = H{i};
    p = nchoosek(e, 2);
    vecP = sub2ind(ss, p(:,1), p(:,2));
    % Loop over all edge predictors
    for j=1:nPredictors
        scores(i,j) = sum(similarity{j}(vecP));        
        disp(string(i) + ":" + string(j));
    end
end


end

