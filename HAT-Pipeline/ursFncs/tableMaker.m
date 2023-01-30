function [outputArg1,outputArg2] = tableMaker(O, itrs, trials)
%TABLEMAKER Summary of this function goes here
%   Detailed explanation goes here

% |V| vs |E|
% avg d(V) vs |E|
% avg d(E) vs |E|
% max d(V) vs |E|
% max d(E) vs |E|

% |conncomp| vs |E|
% clustering vs |E|



% itrs = 10;
% trials = 5;

% Number of vertices
t1 = table();
for i=1:4
    m = cell(itrs, 1);
    s = cell(itrs, 1);
    for j=0:(itrs-1)
        E = zeros(trials, 1);
        M = zeros(trials, 1);
        for k=1:trials
            disp(j+1 + ((k-1) * itrs));
            HG = O{i}{j+1 + ((k-1) * itrs)};
            [x, y] = size(HG.IM);
            M(k) = x;
            E(k) = y;
        end
        m{j+1} = mean(M);
        s{j+1} = std(M);
    end
    t1 = [t1 m s];
end

% Mean vertex degree
t2 = table();
for i=1:4
    m = cell(itrs, 1);
    s = cell(itrs, 1);
    for j=0:(itrs-1)
        E = zeros(trials, 1);
        M = zeros(trials, 1);
        for k=1:trials
            disp(j+1 + ((k-1) * itrs));
            HG = O{i}{j+1 + ((k-1) * itrs)};
            vD = sum(HG.IM');
            M(k) = mean(vD);
        end
        m{j+1} = mean(M);
        s{j+1} = std(M);
    end
    t2 = [t2 m s];
end

% Mean Edge Degree
t3 = table();
for i=1:4
    m = cell(itrs, 1);
    s = cell(itrs, 1);
    for j=0:(itrs-1)
        E = zeros(trials, 1);
        M = zeros(trials, 1);
        for k=1:trials
            disp(j+1 + ((k-1) * itrs));
            HG = O{i}{j+1 + ((k-1) * itrs)};
            eD = sum(HG.IM);
            M(k) = mean(eD);
        end
        m{j+1} = mean(M);
        s{j+1} = std(M);
    end
    t3 = [t3 m s];
end

% Mean vertex degree
t4 = table();
for i=1:4
    m = cell(itrs, 1);
    s = cell(itrs, 1);
    for j=0:(itrs-1)
        E = zeros(trials, 1);
        M = zeros(trials, 1);
        for k=1:trials
            disp(j+1 + ((k-1) * itrs));
            HG = O{i}{j+1 + ((k-1) * itrs)};
            vD = sum(HG.IM');
            M(k) = max(vD);
        end
        m{j+1} = mean(M);
        s{j+1} = std(M);
    end
    t4 = [t4 m s];
end

% Max Edge Degree
t5 = table();
for i=1:4
    m = cell(itrs, 1);
    s = cell(itrs, 1);
    for j=0:(itrs-1)
        E = zeros(trials, 1);
        M = zeros(trials, 1);
        for k=1:trials
            disp(j+1 + ((k-1) * itrs));
            HG = O{i}{j+1 + ((k-1) * itrs)};
            eD = sum(HG.IM);
            M(k) = max(eD);
        end
        m{j+1} = mean(M);
        s{j+1} = std(M);
    end
    t5 = [t5 m s];
end

% Max Edge Degree
t6 = table();
for i=1:4
    m = cell(itrs, 1);
    s = cell(itrs, 1);
    for j=0:(itrs-1)
        M = zeros(trials, 1);
        for k=1:trials
            HG = O{i}{j+1 + ((k-1) * itrs)};
            G = graph(HG.cliqueGraph);
            M(k) = length(unique(conncomp(G)));
        end
        m{j+1} = mean(M);
        s{j+1} = std(M);
    end
    t6 = [t6 m s];
end





end


