% =============================
% nlwalras.m
% This version: 2026-10-28
% Oliver Holtemoeller
% Tested: Octave 11.3
% =============================

disp('************************************************');
disp('Walrasian Equilibrium');

clear all;

disp('');
disp('Numerical solution (nonlinear)');
disp('------------------------------');
NumParams = [0.3, 1, 1, 1];

xinit = [ 0.5, 0.5, 0.5, 0.5 ];
[xopt, resids, efl] = fsolve(@(x)walrasequil(x, NumParams),xinit);
disp(['w = ', num2str(xopt(1))]);
disp(['c = ', num2str(xopt(2))]);
disp(['n = ', num2str(xopt(3))]);
disp(['y = ', num2str(xopt(4))]);
disp('');
disp('************************************************');
