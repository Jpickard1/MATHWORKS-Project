function [h] = plotter(O)
%PLOTTER Summary of this function goes here
%   Detailed explanation goes here

% |V| vs |E|
% |conncomp| vs |E|
% clustering vs |E|
% max d(E) vs |E|
% max d(V) vs |E|
% avg d(E) vs |E|
% avg d(V) vs |E|
mkrs = {'.','*', '^', 'x', 'o', 's'};

numP = 5;
h = figure;
subplot(numP,1,1);
xlabel("Number of Edges"); ylabel("Number of Vertices"); hold on;
for i=1:6
    E = [];
    M = [];
    for j=1:length(O{i})
        HG = O{i}{j};
        [n, m] = size(HG.IM);
        M = [M n];
        E = [E m];
    end
    scatter(E, M, mkrs{i});
end
set(gca, 'xdir', 'reverse');
subplot(numP,1,2);
xlabel("Number of Edges"); ylabel("Avg Vx Degree"); hold on;
for i=1:6
    E = [];
    M = [];
    for j=1:length(O{i})
        HG = O{i}{j};
        [n, m] = size(HG.IM);
        E = [E m];
        vD = sum(HG.IM');
        M = [M mean(vD)];
    end
    scatter(E, M, mkrs{i});
end
set(gca, 'xdir', 'reverse' );
subplot(numP,1,3);
xlabel("Number of Edges"); ylabel("Avg E Degree"); hold on;
for i=1:6
    E = [];
    M = [];
    for j=1:length(O{i})
        HG = O{i}{j};
        [n, m] = size(HG.IM);
        E = [E m];
        eD = sum(HG.IM);
        M = [M mean(eD)];
    end
    scatter(E, M, mkrs{i});
end
set(gca, 'xdir', 'reverse' );
subplot(numP,1,4);
xlabel("Number of Edges"); ylabel("Max Vx Degree"); hold on;
for i=1:6
    E = [];
    M = [];
    for j=1:length(O{i})
        HG = O{i}{j};
        [n, m] = size(HG.IM);
        E = [E m];
        vD = sum(HG.IM');
        M = [M max(vD)]
    end
    scatter(E, M, mkrs{i});
end
set(gca, 'xdir', 'reverse' );
subplot(numP,1,5);
xlabel("Number of Edges"); ylabel("Max E Degree"); hold on;
for i=1:6
    E = [];
    M = [];
    for j=1:length(O{i})
        HG = O{i}{j};
        [n, m] = size(HG.IM);
        E = [E m];
        eD = sum(HG.IM);
        M = [M max(eD)]
    end
    scatter(E, M, mkrs{i});
end
set(gca, 'xdir', 'reverse' );

%{
for i=1:4
    for j=1:length(O{i})
        HG = O{i}{j};
    end
end
%}

end

