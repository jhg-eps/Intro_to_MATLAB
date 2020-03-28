% Joseph Garcia
% ECE 498 
% Homework 5

% 1. Find the roots of the function: f(x) = 0.05*x - sin(x) (function has roots up to approximately 20)
f = @(x)(0.05*x - sin(x));  % anonymous function description for the function of interest
x_i = 0;
x_f = 22;                       % establish range of values where roots appear to be (graphically)
num_pts = 10;                   
x = linspace(0,22,num_pts);     % create an array of values in the roots range
vals = zeros(1,num_pts);        % array for the roots found in the range
roots_ans = zeros(1,num_pts);       % used for all unique roots found in the range
 
for i=1:num_pts
    vals(i) = fzero(f,x(i));     % find zeros near x(i), store in vals(i)
end
roots_ans = unique(vals)             % find the unique roots in the vals array
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Find the roots of the function: f(x) = x.^(7) + 2*x.(6) + 7*x.^(5) - 8*x.^(4) + 10*x.^(3) + 8*x 
p = [1 2 7 -8 10 0 8 0];   % polynomial coefficients array
ro = roots(p)              % find the roots of the polynomial described in the previous line
% Output
%    0.0000 + 0.0000i
%   -1.5754 + 2.6641i
%   -1.5754 - 2.6641i
%    0.8506 + 0.8081i
%    0.8506 - 0.8081i
%   -0.2751 + 0.7287i
%   -0.2751 - 0.7287i
%poly(ro);                % reconstruct the polynomial from the roots to double check that the roots are correct 
% Output
% 1.0000    2.0000    7.0000   -8.0000   10.0000   -0.0000    8.0000         0
% Original polynomial reconstructed!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Solve the following non-linear equation: 
% 3*x*y + y - z = 1
% x + y*x.^(2) + z = 12
% x - y - z = -2        
u0 = [0;0;0];                                             % initial guesses for what x,y, and z are
options = optimoptions('fsolve','Display','iter');        % set optimization options for fsolve() 
[u,fval] = fsolve(@HW5_NLIN3,u0,options)                  % solve the system of nonlinear equations (solutions in u)
							  % feval is f(u(1)), f(u(2)), f(u(3))
% Here is the HW5_NLIN3 function script:

% function HW5_NLIN3 = HW5_NLIN3(u)
% This function contains the three nonlinear equations seen below: 
% 3*x*y + y - z = 1
% x + y*x.^(2) + z = 12
% x - y - z = -2
% x = u(1), y = u(2), z = u(3)
  
% HW5_NLIN3 = [3*u(1)*u(2) + u(2) - u(3) - 12; 
%              u(1) + u(2)*u(1).^(2) + u(3) - 12; 
%              u(1) - u(2) - u(3) + 2];
%          
