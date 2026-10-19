% ========================================================
% Example 2.1: Graphical Solution of Non-Linear Equations
% This version: 14.10.2024
% Author: Oliver Holtemoeller
% Tested: Matlab R2024a, Octave 6.4
% ========================================================

clear all;
close all;

DoSavePlot = 0;

% Define quantity
qsca = 15;
qvec = [ 0:0.01:qsca ];

% Define vector of prices
pvec = [0.01:0.01:1];

% First case
[ p1 fval ] = fsolve(@(psca)demfun1(psca,qsca), 0.5);

% Plot demand function
hf = figure(1);
hold on;
plot(pvec, 10*pvec.^(-0.2), 'linewidth', 2);
plot(pvec, qsca*ones(length(pvec),1), 'linewidth', 2);
plot(p1, qsca, 'o', 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k');
plot(p1*ones(length(qvec),1), qvec, ':k', 'linewidth', 1.5);
hold off;
xlabel('Price');
ylabel('Quantity');
title('10 p^{-0.2}');

if DoSavePlot==1,
  saveas(hf, "fig_demfun1.png", "png");
end

% Second case
[ p2 fval ] = fsolve(@(psca)demfun2(psca,qsca), 0.5);

% Plot demand function
hf = figure(2);
hold on;
plot(pvec, 5*pvec.^(-0.2)+5*pvec.^(-0.5), 'linewidth', 2);
plot(pvec, qsca*ones(length(pvec),1), 'linewidth', 2);
plot(p2, qsca, 'o', 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k');
plot(p2*ones(length(qvec),1), qvec, ':k', 'linewidth', 1.5);
hold off;
xlabel('Price');
ylabel('Quantity');
title('5 p^{-0.2} + 5 p^{-0.5}');

if DoSavePlot==1,
  saveas(hf, "fig_demfun2.png", "png");
end
