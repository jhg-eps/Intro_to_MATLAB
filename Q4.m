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