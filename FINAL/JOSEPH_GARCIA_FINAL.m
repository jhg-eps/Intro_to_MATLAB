% Joseph Garcia
% ECE 498 Final
% 5/10/2016 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1 Given two arrays:
a = [1, 2, 3, 4, 5, 6];
b = [4, 5, 8, 7, 2, 1];
A = cat(1,a,b)
C = intersect(a,b)
% Use one line of Matlab code to complete the following tasks:
% a) Find out the total number of unique values in both a and b
common_unique = union(a,b)
% common_unique =
% 
%      1     2     4     5     7     8

% b) Find out all elements that are in both a and b. Sort the results in
% ascending order
common = intersect(a,b) 
% C =
% 
%      1     2     4     5
% c) Find out all elements that are in a but not in b.
different = setdiff(a,b)
% different =
% 
%      3     6
% d) Remove from a all elements that are elements of b.
% ismember(A,B) "returns an array containing 1 (true) where the data in A
% is found in B. Elsewhere, it returns 0 (false)." In that case, 
a(ismember(a,b)) = []
% a =
% 
%      3     6

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2 Optimization. Supose we need to build a rectangle fence, of which one
% side is a building, as shown below.
% covered area == x*y, we want to maximize that 
% constraint: x + 2y = 300

fun = @(x)(-1*x(1)*x(2));
x0 = [0,0];  % initial guesses for x and y
A = []; % inequality matrix and values are non-existent
b = [];
Aeq = [1 2];   % coefficients for 
beq = [300];
xy_ans = fmincon(fun,x0,A,b,[],beq)% we have the objective function 
% with a negative sign in front because we are trying to find the maximum,
% rather than the minimum, which is what fmincon tries to do.
% xy_ans =
% 
%   150.0000   75.0000 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3a. ) Solve the following linear equations: 
% 2x1 + 2x2 + 3x3 = 1
% 4x1 + 5x2 + 6x3 = 2
% 7x1 + 8x2 + 9x3 = 3

% We use solve like so:

syms x1 x2 x3
[x1sol, x2sol, x3sol] = solve(2*x1 + 2*x2 + 3*x3 == 1, 4*x1 + 5*x2 + 6*x3 == 2, 7*x1 + 8*x2 + 9*x3 == 3)
% x1sol =
%  
% 0
%  
%  
% x2sol =
%  
% 0
%  
%  
% x3sol =
%  
% 1/3

% 3b. ) Find all roots of the following non-linear equation:
% y(x) = x^(4) - 8*x^(2) + 2*x + 3 (using roots for this)
coeffs = [1 0 -8 2 3];
zeros = roots(coeffs)
%zeros =
%
%   -2.8867
%    2.6059
%    0.7873
%   -0.5065

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 4 Solve the following ordinary differential equations numerically:
%dy(1)/dt = y(2);
%dy(2)/dt = 1000*(1 - y(1)^(2))*y(2) - y(1);
%y1(0) = 2;
%y2(0) = 0;

f = @(t,y) [y(2);1000*(1 - y(1)^(2))*y(2) - y(1)]; % anonymous function for DE system
t_range = [0 200];                          % range of interest for our solution
[t,y_sols] = ode45(f,[0 200],[0 0]);           % solve the system of nonlinear DEs using ode45 (medium order accuracy for stiff DEs)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5 Curve fitting. Suppose we have 

x = [-3 -2 -1 0 1 2 3];
y = [8.5 4.3 0.8 0.1 1 3.8 9.2];

% Given the following two fitting options:

p1 = polyfit(x,y,2)
p2 = polyfit(x,y,3)

% Which one is better? Give your explanation.

%By running "plot(x,y)", we see that y is quadratically dependent on x. p1
%= polyfit(x,y,2) is a better fit because it is trying to fit a polynomial
%of degree 2 to the data, rather than a polynomial of order 3. If we were
%to "zoom out" from the data, I still believe that this would be the best
%fit.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%