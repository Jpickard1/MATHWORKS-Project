function [T] = tableMaker(O, ds, itrs, trials, latex, columnHeaders)
%TABLEMAKER Summary of this function goes here
%   Detailed explanation goes here

% Auth: Joshua Pickard
%       jpic@umich.edu
% Date: January 30, 2023

% |V| vs |E|
% avg d(V) vs |E|
% avg d(E) vs |E|
% max d(V) vs |E|
% max d(E) vs |E|

% |conncomp| vs |E|
% clustering vs |E|

%%
tabName = ["numV", "avgDv", "avgDe", "maxDv", "maxDe", "numConnComp", "maxEigA"];

% itrs = 10;
% trials = 5;

tic;
% Number of vertices
t1 = table();
for i=1:length(O)
    m = cell(itrs, 1);
    s = cell(itrs, 1);
    for j=1:(itrs)
        E = zeros(trials, 1);
        M = zeros(trials, 1);
        for k=1:trials
            % disp(j+1 + ((k-1) * itrs));
            HG = O{i}{j+1 + ((k-1) * itrs)};
            [x, y] = size(HG.IM);
            M(k) = x;
            E(k) = y;
        end
        m{j} = mean(M);
        s{j} = std(M);
    end
    t1 = [t1 m s];
end
disp(toc);

tic;
% Mean vertex degree
t2 = table();
for i=1:length(O)
    m = cell(itrs, 1);
    s = cell(itrs, 1);
    for j=1:(itrs)
        E = zeros(trials, 1);
        M = zeros(trials, 1);
        for k=1:trials
            % disp(j+1 + ((k-1) * itrs));
            HG = O{i}{j+1 + ((k-1) * itrs)};
            vD = sum(HG.IM');
            M(k) = mean(vD);
        end
        m{j} = mean(M);
        s{j} = std(M);
    end
    t2 = [t2 m s];
end
disp(toc);

tic;
% Mean Edge Degree
t3 = table();
for i=1:length(O)
    m = cell(itrs, 1);
    s = cell(itrs, 1);
    for j=1:(itrs)
        E = zeros(trials, 1);
        M = zeros(trials, 1);
        for k=1:trials
            % disp(j+1 + ((k-1) * itrs));
            HG = O{i}{j+1 + ((k-1) * itrs)};
            eD = sum(HG.IM);
            M(k) = mean(eD);
        end
        m{j} = mean(M);
        s{j} = std(M);
    end
    t3 = [t3 m s];
end
disp(toc);

tic;
% Max vertex degree
t4 = table();
for i=1:length(O)
    m = cell(itrs, 1);
    s = cell(itrs, 1);
    for j=1:(itrs)
        E = zeros(trials, 1);
        M = zeros(trials, 1);
        for k=1:trials
            % disp(j+1 + ((k-1) * itrs));
            HG = O{i}{j+1 + ((k-1) * itrs)};
            vD = sum(HG.IM');
            M(k) = max(vD);
        end
        m{j} = mean(M);
        s{j} = std(M);
    end
    t4 = [t4 m s];
end
disp(toc);
tic;
% Max Edge Degree
t5 = table();
for i=1:length(O)
    m = cell(itrs, 1);
    s = cell(itrs, 1);
    for j=1:(itrs)
        E = zeros(trials, 1);
        M = zeros(trials, 1);
        for k=1:trials
            % disp(j+1 + ((k-1) * itrs));
            HG = O{i}{j+1 + ((k-1) * itrs)};
            eD = sum(HG.IM);
            M(k) = max(eD);
        end
        m{j} = mean(M);
        s{j} = std(M);
    end
    t5 = [t5 m s];
end
disp(toc);
tic;
% Number connected components
t6 = table();
for i=1:length(O)
    m = cell(itrs, 1);
    s = cell(itrs, 1);
    for j=1:(itrs)
        M = zeros(trials, 1);
        for k=1:trials
            HG = O{i}{j+1 + ((k-1) * itrs)};
            G = graph(HG.cliqueGraph);
            M(k) = length(unique(conncomp(G)));
        end
        m{j} = mean(M);
        s{j} = std(M);
    end
    t6 = [t6 m s];
end
disp(toc);
% Largest Eigenvalue of A
tic;
t7 = table();
for i=1:length(O)
    m = cell(itrs, 1);
    s = cell(itrs, 1);
    for j=1:(itrs)
        M = zeros(trials, 1);
        for k=1:trials
            HG = O{i}{j+1 + ((k-1) * itrs)};
            A = HG.cliqueGraph();
            M(k) = eigs(A, 1);
            % G = graph(HG.cliqueGraph);
            % M(k) = length(unique(conncomp(G)));
        end
        m{j} = mean(M);
        s{j} = std(M);
    end
    t7 = [t7 m s];
end
disp(toc);

T = {t1,t2,t3,t4,t5,t6,t7};

%% Generate latex files
if latex
    for i=1:length(T)
        fileName = char(ds + "_" + tabName(i) + "_table")
        expTable2latex(T{i}, fileName, columnHeaders)
    end
end


end


