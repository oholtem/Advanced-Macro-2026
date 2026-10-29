% Solving Linear Systems of Equations
% This version: 26.10.2026
% Tested: Octave 10.2

clear all;

% Define matrices
B_Mat = [ 2, 3; 3, -4 ];
b_vec = [ 18; -7 ];

% Solve: Using inverse of A
x0_vec = inv(B_Mat)*b_vec;

% Solve: Short cut
x1_vec = B_Mat\b_vec;

% Display results
disp('Solution using the inverse of B:');
disp(x0_vec);

disp('');
disp('Solution using the short cut:');
disp(x1_vec);

% Verify the solution
disp('');
disp('Residuals B*x - b:');
disp(B_Mat*x1_vec - b_vec);

% End of script
