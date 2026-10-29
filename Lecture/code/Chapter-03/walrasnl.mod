// Non-Linear Static Equilibrium Model
// Oliver Holtemoeller 28.10.2026
// Tested: Dynare 7.2

// 1. Block: Definition of Variables and Parameters
// Endogenous variables:
var w n y c;
// Exogenous variables:
varexo A;

// Parameters
parameters alpha, sigma, varphi;
alpha = 0.3;
sigma = 1;
varphi = 1;

// 2. Model Block
model;
// Labor supply
w = c^sigma * n^varphi;
// Labor demand
w = A * (1-alpha) * n^(-alpha);
// Goods market equilibrium
c = y;
// Production function:
y = A * n^(1-alpha);
end;

// Initialization Block
initval;
A = 1;
w = 0.5;
n = 0.5;
y = 0.5;
c = 0.5;
end;

// Compute Static Solution (Steady State):
steady;

