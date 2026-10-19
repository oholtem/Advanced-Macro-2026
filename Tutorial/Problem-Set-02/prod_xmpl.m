% Advanced Macroeconomics Winter Term 2025/26
% Tutorial 2 - Problem 1
% First Version: 18-10-2024
% Updated: 18-10-2025
% Author: Alexandra Gutsch

clear all; % clear workspace
close all; % close open plots

% if toolbox using range() is not available on PC no subtitle added
toolbox_yes = 0;

% decide about saving plots
SavePlot = 0; % =0 if you don't want to save plots

% define vector with values of capital intensity
kVec = 0:0.001:10; % values from 0 to 10 in 0.001 steps, the smaller the steps, the smoother the line, but the slower the code/ the more iterations

% values of alpha
alphaVec = [0.3, 0.65, 1];

% create empty vector for saving later utility for different values of c 
yVec = []; 

% write for loop
for i = 1:length(alphaVec)
  alpha = alphaVec(i);
    for k = kVec % do following operations for all values of k
      y = k^alpha; % calculate production for each value of capital 
      yVec = [yVec, y]; % write values of y for all k into vector
    end
end

% load results for diferent alphas into vectors
yVec_alpha1 = yVec(1:length(kVec));
yVec_alpha2 = yVec(length(kVec)+1:2*length(kVec));
yVec_alpha3 = yVec(2*length(kVec)+1:3*length(kVec));

% plot production function

myColor1 = [0.1 0.2 0.5]; % blue
myColor2 = [0.3 0.7 0.2]; % green
myColor3 = [0.8 0.1 0.3]; % red
          
hf=figure(); % create object for figure

hold on; % write into one coordinate system
plot(kVec, yVec_alpha1,'color', myColor1,'Linewidth', 2);
plot(kVec, yVec_alpha2,'color', myColor2,'Linewidth', 2);
plot(kVec, yVec_alpha3,'color', myColor3,'Linewidth', 2);
hold off;

xlabel('k', 'FontSize', 11); % (change fontsize)
ylabel('y(k) = k^\alpha', 'FontSize', 11);
ylim([0, 10]); % comment this command out and see what happens
title('Neoclassical Production Function', 'FontSize', 11);
legend({'\alpha = 0.30', '\alpha = 0.65', '\alpha = 1.00'},'location', 'west', 'orientation', 'vertical'); % add legend, adjust location and orientation, can use latex code for greek letters
legend boxoff; % (remove box from legend)
grid on; % add grid to plot

% add subtitle
if toolbox_yes
    text(mean(xlim), min(ylim) - 0.1*range(ylim), ...
         'note: production function in efficiency units', ...
         'HorizontalAlignment', 'center');
end

if SavePlot
  print(hf, '-dpng', 'production.png');
end

