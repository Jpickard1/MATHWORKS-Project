function [f,t,o] = uf1(f,t,o)
%UF1 Summary of this function goes here
%   Detailed explanation goes here
disp('User Function Called!')
disp(f)
disp(t)
disp(o)
f = f+1;
t = t+1;
o = o+1;
end

