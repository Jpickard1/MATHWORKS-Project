function plotTable(T, n, x)
%PLOTTABLE This function takse a table and generates a plot according to a
%   few specified formats
%
% INPUT: T - Table with n rows by m columns where m is even. There are m/2
%            variables of interest. Odd columns (1, 3, 5, ...) contain mean
%            measurements, even columns (2, 4, ...) contain standard
%            deviations of the mean measurements. 
%        n - integer: number of measurements corresponding to entries in T
%            % vector: number of measurements corresponding to entries in T
%            % matrix: number of measurements corresponding to entries in T
%        x - vector of x axis labels
%
% Auth: Joshua Pickard
%       jpic@umich.edu
% Date: January 30, 2023

figure;
mkrs = {'.','*', '^', 'x', 'o', 's'};

[n, m] = size(T);
hold on;
for i=1:(m/2)
    disp(string(2*i-1) + ":" +string(2*i))
    D = T{:,2*i-1:2*i};
    M = D(:,1);
    E = D(:,2) / n;
    errorbar(x, M, E, mkrs{i}, "LineStyle","none")
end
hold off;

end

