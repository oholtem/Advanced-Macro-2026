% Getting Started
% This version: 11.10.2024
% Tested: MATLAB R2024a
%         Octave 6.4

close all;
clear all;

% ========
% Matrices
% ========

% Enter matrix
A = [ 16, 3, 2, 13; 5, 10, 11, 8; 9, 6, 7, 12; 4, 15, 14, 1 ]

% Column sums
sum(A)

% Transpose matrix
A'

% Row sums
sum(A')' 

% Diagonal elements
diag(A)

% Sum of diagonal elements
sum(diag(A))

% Subscripts: Sum of elements in the fourth columns
A(1,4) + A(2,4) + A(3,4) + A(4,4)

% Colon operator
1:10

100:-7:50

A(1:4,4)

A(1:4,end)

% ===========
% Expressions
% ===========

% Variables
num_students = 25

% Operators
aa = 2+2
bb = aa-1
cc =aa*bb
dd = cc/aa
ee = aa^3
ff = (aa+bb)*cc
gg = (1+sqrt(5))/2
hh = log(gg) 
ii = exp(hh)

% =====================
% Working with Matrices
% =====================

% Generating matrices
Z = zeros(2,4)

F = 5*ones(3,3)

N = fix(10*rand(1,10)) 

R = randn(4,4) 

% Elementwise operations
N.^2

A.*A 

% Concatenation
B = [A, A+32; A+48, A+16]

% Deleting rows and columns
X = A;

X(:,2) = [] 

% Linear Algebra
A + A'

A'*A

RInv = inv(R) 

round(RInv*R)

v = ones(4,1)

A*v 

% ======
% Arrays
% ======  % structuring certain values

% Building tables
n = (0:9)';
pows = [ n, n.^2, 2.^n ]

x = (1:0.1:2)';
logs = [ x, log10(x) ]

% Multivariate data
D = [ 72, 134, 3.2;
      81, 201, 3.5;
      69, 156, 7.1;
      82, 148, 2.4;
      75, 170, 1.2 ]
      
mu = mean(D) 

sigma = std(D) 

% Scalar expansion
B = A-8.5 

B(1:2, 2:3) = 0

% Logical subscripting 
x = [ 2.1, 1.7, 1.6, 1.5, NaN, 1.9, 1.8, 1.5, 5.1, 1.8, 1.4, 2.2, 1.6, 1.8 ];

x = x(isfinite(x))

x = x(abs(x-mean(x)) <= 3*std(x))

B=A;
B(~isprime(B)) = 0

% The find function
k = find(isprime(A))' 

A(k) 

A(k) = NaN

% ============================
% Controlling Input and Output
% ============================

% The format function
x = [ 4/3, 1.2345e-6 ];
format short
x
format short e
x
format short g
x
format long
x
format long e
x
format long g
x
format bank
x
format rat
x
format hex
x

format short

% Suppressing output % add ;
A = magic(10); 

% Entering long statements
s = 1 -1/2 + 1/3 - 1/4 + 1/5 -1/6 + 1/7 ...
    -1/8 + 1/9 - 1/10 + 1/11 - 1/12;

% ========
% Graphics
% ========

% Creating a plot
x = 0:pi/100:2*pi;
y = sin(x);
plot(x,y);
xlabel('x = 0:2\pi');
ylabel('Sine of x');
title('Plot of the Sine Function', 'FontSize', 12);

% Multiple data sets in one graph
x = 0:pi/100:2*pi;
y = sin(x);
y2 = sin(x-0.25);
y3 = sin(x-0.5);
plot(x,y,x,y2,x,y3);
legend('sin(x)', 'sin(x-0.25)', 'sin(x-0.5)');

% Specifying line styles and colors
x = 0:pi/100:2*pi;
y = sin(x);
plot(x,y, 'ks')

% Placing markers at every tenth data point
x1 = 0:pi/100:2*pi;
x2 = 0:pi/10:2*pi;
plot(x1,sin(x1), 'r:', x2,sin(x2),'r+');

% Adding plots to an existing graph
x = 0:pi/100:2*pi;
y = sin(x);
y2 = sin(x-0.25);
y3 = sin(x-0.5);
hold on;
plot(x,y);
plot(x,y2);
plot(x,y3);
hold off;
legend('sin(x)', 'sin(x-0.25)', 'sin(x-0.5)');

% Figure windows
n=2;
figure(n);
x = 0:pi/100:2*pi;
y = sin(x);
plot(x,y);

% Clearing the figure for a new plot
figure(1);
clf reset;

% Multiple plots in one figure
x = 0:pi/100:2*pi;
subplot(2,2,1); plot(x, sin(x)); title('sin(x)');
subplot(2,2,2); plot(x, cos(x)); title('cos(x)');
subplot(2,2,3); plot(x, log(x)); title('ln(x)');
subplot(2,2,4); plot(x, exp(x)); title('exp(x)');

% Controlling the axes and adding text
figure(1);
clf reset;
x = 0:pi/100:2*pi;
y = sin(x);
plot(x,y);
axis([0, 2*pi, -2, 2]);
grid on;
text(2,1,'Some text.');

% Saveing figures
saveas(1, "plotexample.png", "png");

% ===========
% Programming
% ===========

% Flow control: if
a = 1;
b = 2;
if a > b
  disp('greater');
elseif a == b
  disp('equal');
elseif a < b
  disp('less');
else
  disp('Error.');
end

% Flow control: for
for n = 1:10
  n
end

% Other data structures: Structures
S.name = 'Leon Walras';
S.birthyear = 1834;
S

S(2).name = 'John Maynard Keynes';
S(2).birthyear = 1883;

S(3) = struct('name', 'Milton Friedman', ...
              'birthyear', 1912);
S 

% Functions
x2fun(4)

% Anonymous functions
sqr = @(x) x.^2;
sqr(5)

% =================
% Matlab or Octave?
% =================
MyEnv.Octave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
MyEnv.Matlab = ~MyEnv.Octave;
MyEnv
