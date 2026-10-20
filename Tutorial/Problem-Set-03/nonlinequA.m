function func = nonlinequA(sol)
  
  % define variables
  x = sol(1);
  y = sol(2);
  
  % define functions
  func(1) = x - 2; 
  func(2) = y - x^2;
  
end
