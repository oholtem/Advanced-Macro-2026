function f_x = nonlinequB(x)
  
  % define variables (of vector x)
  x_1 = x(1);
  x_2 = x(2);
  x_3 = x(3);
  
  % define f(x) 
  f_x(1) = 2*x_1 + log(x_2) - 3; 
  f_x(2) = x_2*x_3 - 1;
  f_x(3) = log(x_3) - 2;
  
end
