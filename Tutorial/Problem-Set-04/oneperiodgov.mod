% One Period Model with Government Spending
% Oliver Holtemoeller
% Date: 04/11/2026

% Endogenous Variables
var
    y
    c
    n
    w
    g
    tau
;

% Exogenous Variables
varexo
    a
;

% Parameters
parameters
    alpha
    sigma
    gamma
    varphi
    b
;
alpha = 0.3;
sigma = 1;
gamma = 0.2;
varphi = 1;
b = 2;

model;
[name = 'labor supply condition']
w = (1+tau) * c^sigma * b * n^varphi;

[name = 'production function']
y = exp(a) * n^(1-alpha);

[name = 'FOC firm labor demand']
w = (1-alpha) * y / n;

[name = 'public spending']
g = gamma * y;

[name = 'public budget']
g = tau * c;

[name = 'aggregate resources']
y = c + g;
end;

initval;
a = 0;
y = 0.5;
c = 0.5;
n = 0.5;
w = 0.5;
g = 0.5;
tau = 0.5;
end;

% compute steady state
steady;

stst = oo_.steady_state;
y_0 = stst(1);
c_0 = stst(2);
n_0 = stst(3);
w_0 = stst(4);
g_0 = stst(5);
tau_0 = stst(6);

n_1 = 1/3;
y_1 = n_1^(1-alpha);
w_1 = (1-alpha) * y_1 / n_1;
g_1 = gamma * y_1;
c_1 = y_1 - g_1;
tau_1 = g_1 / c_1;
b_1 = w_1 / (1+tau_1) * c_1^(-sigma) * n_1^(-varphi);
