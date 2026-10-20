% Advanced Macroeconomics Winter Term 2025/26
% Tutorial 3 - Problem 3
% Example b)*
% Date: 23/10/2025
% Author: Alexandra Gutsch

clear all;

disp('************************************************');
disp(' Problem 3 - Example b)*');

% vector with inital values for x_1,x_2 and x_3
x_0 = [1 1 1];

% solve equation system using function nonlinequB 
[x, f_x, efl] = fsolve(@(x) nonlinequB(x), x_0);

% display resulting values of x_1, x_2 and x_3
disp(['x_1 = ', num2str(x(1))]);
disp(['x_2 = ', num2str(x(2))]);
disp(['x_3 = ', num2str(x(3))]);

disp('************************************************');