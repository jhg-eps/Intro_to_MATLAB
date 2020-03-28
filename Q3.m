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