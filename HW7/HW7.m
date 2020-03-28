% 1)
%Maximize the profit. Suppose a farmer has 75 acres to plant, and must decide how 
% many acres are devote to crop A or crop B
%(x acres for crop A or y acres for crop B)

%The profit is defined as P(x,y)=143x+69y
%Storage space constraint: 110*x+30*y <= 4000
%Finance budget constraint: 120*x+210*y <= 15000
%Area constraint: x+y <= 75
%In addition, the area constraints: %x >= 0
                                    %y >= 0
                                
% All of our linear inequalities:
  %  Storage space constraint: 110*x+30*y <= 4000
  %  Finance budget constraint: 120*x+210*y <= 15000
  %  Area constraint: x+y <= 75
% Turning them into the inequality coefficient Matrix A
A = [110 30  % Storage space constraint
    120 210  % Finance budget constraint
    1 1];    % Area constraint
% The RHS of the linear equalities
b = [4000 15000 75];
% The objective function coefficients  
P = [-143 -69];
Aeq = [];
beq = [];
lb = [0, 0];
ub = [75, 75];
vars = linprog(P,A,b,Aeq,beq,lb,ub)

%OUTPUT: 
% vars =
% 
%    21.8750
%    53.1250
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2)
%Production planning: Two products A and B, require production time in two departments. Find out how many As and Bs we should produce to maximize the profit.

%                                Product A	Product B
%Required time in department 1	1 hour	    1 hour
%Required time in department 2	1.25 hour	0.75 hour

%Available time in each department is 200 hours.
%Maximum market potential for product B is 150 units.
%Profit per unit is $4 for product A and $5 for product B.
%tspentby1makingA + tspentby1makingB = tspentby1 <= 200
%1 hour*num_A      + (1 hour)*num_B  <= 200 hours
%tspentby2makingA + tspentby2makingB = tspentby2 <= 200
%1.25 hour*num_A   +  0.75 hour*num_B <= 200 hours

% We then have:
% our objective function (what we want to maximize): F = -num_A*4 + -5*num_B (so we find max rather than min)
% department 1 inequality: (1 hour)*num_A      + (1 hour)*num_B  <= 200 hours
% department 2 inequality: (1.25 hour)*num_A   +  (0.75 hour)*num_B <= 200 hours
% market potential inequality: num_B <= 150

F = [-4 -5];
A = [1 1         % department 1 inequality
     1.25 0.75   % department 2 inequality             the LHS of each inequality.
     0 1];     % market potential inequality
b = [200 200 150];  % the values on the RHS of each inequality
Aeq = [];
beq = [];

VALS = linprog(F,A,b,Aeq,beq)  % find how much of each product we should sell, print result!

%OUTPUT:
% VALS =
% 
%    50.0000
%   150.0000

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3) Minimize the objective function: f(x,y,z)=(x^2+y^2)^2?x^2?y+z^2
VALS_0 = [0,0,0];   % initial guess array
F = @(x)(x(1)^2 + x(2)^2)^2 - x(1)^2 - x(2) + x(3)^2; % anonymous function declaration 
% x => x(1), y => x(2), z => x(3)

[VALS,FVAL] = fminunc(F,VALS_0)  % find the minimum of this unconstrained function using the default options
% for fminunc (can be changed with optimoptions(@fminunc,....)
    % "returns the value of the objective function FUN at the solution X."
    % - MATLAB "help fminunc" command 

%OUTPUT:    
% VALS =
% 
%     0.0000    0.6300   -0.0000
% 
% 
% FVAL =
% 
%    -0.4725

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4)
%Minimize the objective function: f(x1,x2)=2x21+20x22+6x1x2+5x1
%f(x1,x2)=2(x1)^2+20(x2)^2+6*(x1)*(x2)+5(x1)
%with the constraint that x1 - x2 = -2 or x1 - x2 + 2 = 0

VALS_0 = [0,0];   % initial guess array
F = @(x) 2*(x(1))^2 + 20*(x(2))^2 + 6*(x(1))*(x(2)) + 5*(x(1));
A = [];   % A and b are zero because we do not have any inequalities to satisfy
b = [];
Aeq = [1, -1]; % Manifested as (1)*x(1) + (-1)x(2)... (coefficient matrix for our variables)
beq = -2;      % is equal to -2 !
VALS = fmincon(F,VALS_0,A,b,Aeq,beq) % find the minimum near the initial guess, print the result

%OUTPUT:
% VALS =
%
%   -1.7321    0.2679

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
