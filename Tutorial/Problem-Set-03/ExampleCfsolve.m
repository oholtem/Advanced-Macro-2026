% Advanced Macroeconomics Winter Term 2025/26
% Tutorial 3 - Problem 3
% Example c)*
% Date: 23/10/2025
% Author: Alexandra Gutsch

clear all;

disp('************************************************');
disp(' Problem 3 - Example c)*');

% Parameters
pars.alpha = 0.6;
pars.beta  = 0.4;

% Exogenous variables
varexo.A = 1.1;
varexo.k = 1;
varexo.n = 1;

% Define initial values
varin = [0.7 0.3 0.8];

% Compute and display values of endogenous variables
varendo = fsolve (@(x) nonlinequC(x, varexo, pars), varin);

% Quick output
%disp(varendo);

% Display resulting values of r, w, and y
disp(['r = ', num2str(varendo(1))]);
disp(['w = ', num2str(varendo(2))]);
disp(['y = ', num2str(varendo(3))]);

disp('************************************************');
