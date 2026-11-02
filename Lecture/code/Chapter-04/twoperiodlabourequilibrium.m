function fun = twoperiodlabourequilibrium(endog, exog, params)
  % Parameters
  alpha = params.alpha;
  rho   = params.rho;
  theta = params.theta;
  gamma = params.gamma;

  % Exogenous variables
  A1 = exog.A1;
  A2 = exog.A2;

  % Endogenous variables
  y1 = endog(1);
  y2 = endog(2);
  c1 = endog(3);
  c2 = endog(4);
  w1 = endog(5);
  w2 = endog(6);
  r  = endog(7);
  n1 = endog(8);
  n2 = endog(9);

  % Equilibrium equations
  fun = ones(9,1);
  fun(1) = y1 - A1*n1^(1-alpha);
  fun(2) = y2 - A2*n2^(1-alpha);
  fun(3) = c1 - y1;
  fun(4) = c2 - y2;
  fun(5) = w1 - (1-alpha)*A1*n1^(-alpha);
  fun(6) = w2 - (1-alpha)*A2*n2^(-alpha);
  fun(7) = w1 - (n1^gamma)/(c1^(-theta));
  fun(8) = w2 - (n2^gamma)/(c2^(-theta));
  fun(9) = c1 - ((1+rho)/(1+r))^(1/theta)*c2;
end
