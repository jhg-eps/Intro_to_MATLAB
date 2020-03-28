% 2 Optimization. Supose we need to build a rectangle fence, of which one
% side is a building, as shown below.
% covered area == x*y, we want to maximize that 
% constraint: x + 2y = 300

x0 = [0, 0]  % initial guesses for x and y
A = []; % inequality matrix and values are non-existent
b = [];
Aeq = [1 2];   % coefficients for 
beq = [300];
xy_ans = fmincon(@(x) (-x(1)*x(2)), x0, A, b, Aeq, beq)  % we have the objective function 
% with a negative sign in front because we are trying to find the maximum,
% rather than the minimum, which is what fmincon tries to do.
% xy_ans =
% 
%   150.0000   75.0000 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%