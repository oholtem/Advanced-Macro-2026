% Advanced Macroeconomics Winter Term 2025/26
% Tutorial 3 - Problem 3
% Example a)
% Date: 23/10/2025
% Author: Alexandra Gutsch

clear all;

disp('************************************************');
disp(' Problem 3 - Example a)');

% vector with inital values for x and y
init = [0 0];

% solve equation system using function nonlinequ 
sol = fsolve (@(sol) nonlinequA(sol), init);

% display resulting values of x and y
disp(['x = ', num2str(sol(1))]);
disp(['y = ', num2str(sol(2))]);

disp('************************************************');