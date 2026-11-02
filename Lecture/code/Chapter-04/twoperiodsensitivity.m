% ===============================================
% TwoPeriodSensitivity.m
% General Equilibrium in the Two-Period Model
% Variation of Parameters (Sensitivity Analysis)
% This version: 01.11.2026 (Octave 10.2)
% Author: Oliver Holtemoeller
% ===============================================

close all;
clear all;

% Check for Matlab/Octave
% -----------------------
MyEnv.Octave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
MyEnv.Matlab = ~MyEnv.Octave;

DoSavePlots = 0;

disp(' ');
disp('******************************************');
disp('*** Two-Period Model: Sensitivity      ***');
disp('******************************************');
if MyEnv.Octave
    disp(['Start: ', strftime("%Y-%m-%d %H:%M", localtime(time()))]);
else
    disp(datetime('now','TimeZone','local','Format','yyyy-MM-dd HH:mm'));
end
disp('');

% Colorblind barrier-free color pallet
BfBlack        = [   0,   0,   0 ]/255;
BfOrange       = [ 230, 159,   0 ]/255;
BfSkyBlue      = [  86, 180, 233 ]/255;
BfBluishGreen  = [   0, 158, 115 ]/255;
BfYellow       = [ 240, 228,  66 ]/255;
BfBlue         = [   0, 114, 178 ]/255;
BfVermillon    = [ 213,  94,   0 ]/255;
BfRedishPurple = [ 204, 121, 167 ]/255;

% Baseline parameters
params.alpha = 0.3;
params.rho   = 0.02;
params.theta = 1;
BaselineParams = params;

% Exogenous variables
exog.k1 = 1;
exog.n1 = 1;
exog.n2 = 1;
exog.A1 = 1;
exog.A2 = 1;

% Specify initial variables
initval = [ 1; 1; 1.5; 1; 0.7; 0.5; 0.3; 0.1; 0.5 ];
options = optimset('MaxIter', 10000, 'MaxFunEvals', 90000);

% Vary time preference rate (rho)
params = BaselineParams;
MyResults.rho = [];
rhoVec = 0.000:0.005:0.100;
for rho = rhoVec
    params.rho = rho;
    % Solve nonlinear system
    [ fsopt, fval, efl ] = fsolve(@(x)twoperiodequilibrium(x, exog, params), initval, options);
    MyResults.rho = [ MyResults.rho, fsopt ];
end

% Elasticity of intertemporal substitution (1/theta)
params = BaselineParams;
MyResults.theta = [];
thetaVec = 1.0:0.1:5.0;
for theta = thetaVec
    params.theta = theta;
    % Solve nonlinear system
    [ fsopt, fval, efl ] = fsolve(@(x)twoperiodequilibrium(x, exog, params), initval, options);
    MyResults.theta = [ MyResults.theta, fsopt ];
end

% Capital elasticity of output (alpha)
params = BaselineParams;
MyResults.alpha = [];
alphaVec = 0.05:0.05:0.95;
for alpha = alphaVec
    params.alpha = alpha;
    % Solve nonlinear system
    [ fsopt, fval, efl ] = fsolve(@(x)twoperiodequilibrium(x, exog, params), initval, options);
    MyResults.alpha = [ MyResults.alpha, fsopt ];
end

% Display results
fig_counter = 0;

fig_counter = fig_counter + 1;
hf = figure(fig_counter);
plot(rhoVec, MyResults.rho(3,:)./MyResults.rho(1,:), 'color', BfBlue, 'LineWidth',3);
title('Consumption Share in Period 1');
xlabel('time preference rate (\rho)');
ylabel('c_1/y_1');

if DoSavePlots
  saveas(hf, '../../figures/fig_Two-Period-Rho.png', 'png');
end

cVec = 0:0.1:10;
uMat = [];
for c = cVec
    uVec = [];
    for theta = thetaVec
        if theta == 1
            u = log(c);
        else
            u = c^(1-theta)/(1-theta);
        end
        uVec = [ uVec; u ];
    end
    uMat = [ uMat, uVec ];
end
fig_counter = fig_counter + 1;
hf = figure(fig_counter);
hold on;
plot(cVec, uMat(1,:), 'color', BfBlack, 'LineWidth', 3);
plot(cVec, uMat(6,:), 'color', BfBlue, 'LineWidth', 3);
plot(cVec, uMat(11,:), 'color', BfOrange, 'LineWidth', 3);
hold off;
legend('\theta = 1', '\theta = 1.5', '\theta = 2', 'Location','southeast');
title('Utility Function');
ylabel('u(c)');
xlabel('c');

if DoSavePlots
  saveas(hf, '../../figures/fig_Two-Period-U.png', 'png');
end

fig_counter = fig_counter + 1;
hf = figure(fig_counter);
plot(thetaVec, MyResults.theta(3,:)./MyResults.theta(1,:), 'color', BfBlue, 'LineWidth',3);
title('Consumption Share in Period 1');
xlabel('inverse elasticity of intertemporal substitution (\theta)');
ylabel('c_1/y_1');

if DoSavePlots
  saveas(hf, '../../figures/fig_Two-Period-Theta.png', 'png');
end

fig_counter = fig_counter + 1;
hf = figure(fig_counter);
plot(thetaVec, MyResults.theta(3,:)./MyResults.theta(4,:), 'color', BfBlue, 'LineWidth',3);
title('Consumption in Period 1 and Period 2');
xlabel('inverse elasticity of intertemporal substitution (\theta)');
ylabel('c_1/c_2');

fig_counter = fig_counter + 1;
hf = figure(fig_counter);
plot(thetaVec, 1-(MyResults.theta(3,:)./MyResults.theta(1,:)), 'color', BfBlue, 'LineWidth',3);
title('Savings Ratio in Period 1');
xlabel('inverse elasticity of intertemporal substitution (\theta)');
ylabel('1-c_1/y_1');

fig_counter = fig_counter + 1;
hf = figure(fig_counter);
plot(alphaVec, MyResults.alpha(3,:)./MyResults.alpha(1,:), 'color', BfBlue, 'LineWidth',3);
title('Consumption Share in Period 1');
xlabel('capital elasticity of output (\alpha)');
ylabel('c_1/y_1');

if DoSavePlots
  saveas(hf, '../../figures/fig_Two-Period-Alpha.png', 'png');
end

disp('Done. Bye.');
if MyEnv.Octave
    disp(['End: ', strftime("%Y-%m-%d %H:%M", localtime(time()))]);
else
    disp(datetime('now','TimeZone','local','Format','yyyy-MM-dd HH:mm'));
end
disp('******************************************');
