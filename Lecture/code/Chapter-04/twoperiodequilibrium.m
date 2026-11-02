function fun = twoperiodequilibrium(endog, exog, params)
  % Parameters
  alpha = params.alpha;
  rho   = params.rho;
  theta = params.theta;

  % Exogenous variables
  A1 = exog.A1;
  A2 = exog.A2;
  k1 = exog.k1;
  n1 = exog.n1;
  n2 = exog.n2;

  % Endogenous variables
  y1 = endog(1);
  y2 = endog(2);
  c1 = endog(3);
  c2 = endog(4);
  w1 = endog(5);
  w2 = endog(6);
  r1 = endog(7);
  r2 = endog(8);
  k2 = endog(9);

  % Equilibrium equations
  fun = ones(9,1);
  fun(1) = y1 - A1*k1^alpha*n1^(1-alpha);
  fun(2) = y2 - A2*k2^alpha*n2^(1-alpha);
  fun(3) = c1 - k1 - r1*k1 - w1*n1 + k2;
  fun(4) = c2 - (1+r2)*k2 - w2*n2;
  fun(5) = w1 - (1-alpha)*A1*k1^alpha*n1^(-alpha);
  fun(6) = w2 - (1-alpha)*A2*k2^alpha*n2^(-alpha);
  fun(7) = r1 - alpha*A1*k1^(alpha-1)*n1^(1-alpha);
  fun(8) = r2 - alpha*A2*k2^(alpha-1)*n2^(1-alpha);
  fun(9) = c1 - ((1+rho)/(1+r2))^(1/theta)*c2;
end
