function F = nonlinequC(varendo, varexo, pars)
  
  % parameters
  alpha = pars.alpha;
  beta = pars.beta;
  
  % exogenous variables
  A = varexo.A;
  k = varexo.k;
  n = varexo.n;
  
  % endogenous variables
  w = varendo(1);
  r = varendo(2);
  y = varendo(3);
  
  % first order sonditions and production function
  F(1) = w - beta*A*k^alpha*n^(beta-1);
  F(2) = r - alpha*A*k^(alpha-1)*n^beta;
  F(3) = y - A*k^alpha*n^beta;
  
end
