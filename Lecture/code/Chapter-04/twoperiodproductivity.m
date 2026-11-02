% ===============================================
% TwoPeriodProductivity.m
% General Equilibrium in the Two-Period Model
% Productivity Shocks
% This version: 01.11.2025 (Octave 10.2)
% Author: Oliver Holtemoeller
% ===============================================

close all;
clear all;

% Check for Matlab/Octave
% -----------------------
MyEnv.Octave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
MyEnv.Matlab = ~MyEnv.Octave;

DoSavePlots = 0;

% Colorblind barrier-free color pallet
BfBlack        = [   0,   0,   0 ]/255;
BfOrange       = [ 230, 159,   0 ]/255;
BfSkyBlue      = [  86, 180, 233 ]/255;
BfBluishGreen  = [   0, 158, 115 ]/255;
BfYellow       = [ 240, 228,  66 ]/255;
BfBlue         = [   0, 114, 178 ]/255;
BfVermillon    = [ 213,  94,   0 ]/255;
BfRedishPurple = [ 204, 121, 167 ]/255;

disp(' ');
disp('*********************************************');
disp('*** Two-Period Model: Productivity Shocks ***');
disp('*********************************************');
if MyEnv.Octave
    disp(['Start: ', strftime("%Y-%m-%d %H:%M", localtime(time()))]);
else
    disp(datetime('now','TimeZone','local','Format','yyyy-MM-dd HH:mm'));
end
disp(' ');

% Baseline parameters
params.alpha = 0.3;
params.rho   = 0.05;
params.theta = 1;
BaselineParams = params;

% Exogenous variables
exog.k1 = 1;
exog.n1 = 1;
exog.n2 = 1;
exog.A1 = 1;
exog.A2 = 1;
BaselineExog = exog;

% Specify initial values
initval = [ 1; 1; 1.5; 1; 0.7; 0.5; 0.3; 0.1; 0.5 ];
options = optimset('MaxIter', 10000, 'MaxFunEvals', 90000);

% Baseline scenario
MyResults = [];
[ fsopt, fval, efl ] = fsolve(@(x)twoperiodequilibrium(x, exog, params), initval, options);
MyResults = [ MyResults, fsopt ];

% Temporary productivity shock (A1)
params = BaselineParams;
exog = BaselineExog;
exog.A1 = 1.1;
[ fsopt, fval, efl ] = fsolve(@(x)twoperiodequilibrium(x, exog, params), initval, options);
MyResults = [ MyResults, fsopt ];

% Expected productivity shock (A2)
params = BaselineParams;
exog = BaselineExog;
exog.A2 = 1.1;
[ fsopt, fval, efl ] = fsolve(@(x)twoperiodequilibrium(x, exog, params), initval, options);
MyResults = [ MyResults, fsopt ];

% Permanent productivity shock (A1, A2)
params = BaselineParams;
exog = BaselineExog;
exog.A1 = 1.1;
exog.A2 = 1.1;
[ fsopt, fval, efl ] = fsolve(@(x)twoperiodequilibrium(x, exog, params), initval, options);
MyResults = [ MyResults, fsopt ];

% Display results
fig_counter = 0;
fig_counter = fig_counter + 1;
hf = figure(fig_counter);
subplot(2,2,1);
bar([MyResults(3,1), MyResults(4,1)], 'facecolor', BfBlue);
title('Baseline Scenario');
xlabel('period');
ylabel('consumption units');

subplot(2,2,2);
bar([100*MyResults(3,2)/MyResults(3,1)-100, 100*MyResults(4,2)/MyResults(4,1)-100], 'facecolor', BfOrange);
title('Temporary Productivity Shock');
xlabel('period');
ylabel('dev. from baseline (%)');

subplot(2,2,3);
bar([100*MyResults(3,3)/MyResults(3,1)-100, 100*MyResults(4,3)/MyResults(4,1)-100], 'facecolor', BfOrange);
title('Expected Productivity Shock');
xlabel('period');
ylabel('dev. from baseline (%)');

subplot(2,2,4);
bar([100*MyResults(3,4)/MyResults(3,1)-100, 100*MyResults(4,4)/MyResults(4,1)-100], 'facecolor', BfOrange);
title('Permanent Productivity Shock');
xlabel('period');
ylabel('dev. from baseline (%)');

if DoSavePlots
  saveas(hf, '../../figures/fig_Two-Period-Productivity-C.png', 'png');
end

fig_counter = fig_counter + 1;
hf = figure(fig_counter);
subplot(2,2,1);
bar([100*MyResults(7,1), 100*MyResults(8,1)], 'facecolor', BfBlue);
title('Baseline Scenario');
xlabel('period');
ylabel('interest rate (%)');

subplot(2,2,2);
bar([100*(MyResults(7,2)-MyResults(7,1)), 100*(MyResults(8,2)-MyResults(8,1))], 'facecolor', BfOrange);
title('Temporary Productivity Shock');
xlabel('period');
ylabel('dev. from baseline (pp)');

subplot(2,2,3);
bar([100*(MyResults(7,3)-MyResults(7,1)), 100*(MyResults(8,3)-MyResults(8,1))], 'facecolor', BfOrange);
title('Expected Productivity Shock');
xlabel('period');
ylabel('dev. from baseline (pp)');

subplot(2,2,4);
bar([100*(MyResults(7,4)-MyResults(7,1)), 100*(MyResults(8,4)-MyResults(8,1))], 'facecolor', BfOrange);
title('Permanent Productivity Shock');
xlabel('period');
ylabel('dev. from baseline (pp)');

if DoSavePlots
  saveas(hf, '../../figures/fig_Two-Period-Productivity-R.png', 'png');
end

fig_counter = fig_counter + 1;
hf = figure(fig_counter);
subplot(2,2,1);
bar([100*MyResults(3,1)/MyResults(1,1), 100*MyResults(4,1)/MyResults(2,1)], 'facecolor', BfBlue);
title('Baseline Scenario');
xlabel('period');
ylabel('consumption share (%)');

subplot(2,2,2);
bar([100*(MyResults(3,2)/MyResults(1,2)-MyResults(3,1)/MyResults(1,1)), ...
    100*(MyResults(4,2)/MyResults(2,2)-MyResults(4,1)/MyResults(2,1))], 'facecolor', BfOrange);
title('Temporary Productivity Shock');
xlabel('period');
ylabel('dev. from baseline (pp)');

subplot(2,2,3);
bar([100*(MyResults(3,3)/MyResults(1,3)-MyResults(3,1)/MyResults(1,1)), ...
    100*(MyResults(4,3)/MyResults(2,3)-MyResults(4,1)/MyResults(2,1))], 'facecolor', BfOrange);
title('Expected Productivity Shock');
xlabel('period');
ylabel('dev. from baseline (pp)');

subplot(2,2,4);
bar([100*(MyResults(3,4)/MyResults(1,4)-MyResults(3,1)/MyResults(1,1)), ...
    100*(MyResults(4,4)/MyResults(2,4)-MyResults(4,1)/MyResults(2,1))], 'facecolor', BfOrange);
title('Permanent Productivity Shock');
xlabel('period');
ylabel('dev. from baseline (pp)');

if DoSavePlots
  saveas(hf, '../../figures/fig_Two-Period-Productivity-CY.png', 'png');
end

fig_counter = fig_counter + 1;
hf = figure(fig_counter);
subplot(2,2,1);
bar([100*MyResults(3,1)/(MyResults(1,1)+exog.k1), 100*MyResults(4,1)/(MyResults(1,1)+MyResults(9,1))], 'facecolor', BfBlue);
title('Baseline Scenario');
xlabel('period');
ylabel('consumption wealth ratio (%)');

subplot(2,2,2);
bar([100*(MyResults(3,2)/(MyResults(1,2)+exog.k1)-MyResults(3,1)/(MyResults(1,1)+exog.k1)), ...
    100*(MyResults(4,2)/(MyResults(2,2)+MyResults(9,2))-MyResults(4,1)/(MyResults(2,1)+MyResults(9,1)))], 'facecolor', BfOrange);
title('Temporary Productivity Shock');
xlabel('period');
ylabel('dev. from baseline (pp)');

subplot(2,2,3);
bar([100*(MyResults(3,3)/(MyResults(1,3)+exog.k1)-MyResults(3,1)/(MyResults(1,1)+exog.k1)), ...
    100*(MyResults(4,3)/(MyResults(2,3)+MyResults(9,3))-MyResults(4,1)/(MyResults(2,1)+MyResults(9,1)))], 'facecolor', BfOrange);
title('Expected Productivity Shock');
xlabel('period');
ylabel('dev. from baseline (pp)');

subplot(2,2,4);
bar([100*(MyResults(3,4)/(MyResults(1,4)+exog.k1)-MyResults(3,1)/(MyResults(1,1)+exog.k1)), ...
    100*(MyResults(4,4)/(MyResults(2,4)+MyResults(9,4))-MyResults(4,1)/(MyResults(2,1)+MyResults(9,1)))], 'facecolor', BfOrange);
title('Permanent Productivity Shock');
xlabel('period');
ylabel('dev. from baseline (pp)');

if DoSavePlots
  saveas(hf, '../../figures/fig_Two-Period-Productivity-CW.png', 'png');
end

disp('Done. Bye.');
if MyEnv.Octave
    disp(['End: ', strftime("%Y-%m-%d %H:%M", localtime(time()))]);
else
    disp(datetime('now','TimeZone','local','Format','yyyy-MM-dd HH:mm'));
end
disp('*********************************************');
