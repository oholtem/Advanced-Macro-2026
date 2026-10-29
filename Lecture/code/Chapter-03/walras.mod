// Linear Static Equilibrium Model
// Oliver Holtemoeller 28.10.2026
// Tested: Dynare 6.4

// 1. Block: Definition of Variables and Parameters
// Endogenous variables:
var w n y c;
// Exogenous variables:
varexo a;

// Parameters
parameters alpha, sigma, varphi;
alpha = 0.3;
sigma = 1;
varphi = 1;

// 2. Model Block
model(linear);
// Labor supply
w = sigma*c + varphi*n;
// Labor demand
w = a + log(1-alpha) - alpha*n;
// Goods market equilibrium
c = y;
// Production function:
y = a + (1-alpha)*n;
end;

// Initialization Block
initval;
a = 0;
end;

// Compute Static Equilibrium (Steady State):
steady;

disp('Steady State in Levels (not logs):');
steady_state = exp(oo_.steady_state);
disp(['w = ', num2str(steady_state(1))]);
disp(['n = ', num2str(steady_state(2))]);
disp(['y = ', num2str(steady_state(3))]);
disp(['c = ', num2str(steady_state(4))]);
