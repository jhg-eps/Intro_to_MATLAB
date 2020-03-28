% Joseph Garcia 
% ECE 498
% Homework 6

% Solve the following ordinary differential equations analytically
% dy/dx=x^2/y
y1 = dsolve('Dy = (x^(2))/y','x')
% dy/dx+y^2?sin(x)=0
y2 = dsolve('Dy + y^(2)*sin(x) = 0', 'x')
% x*dy/dx=sqrt(1?y^(2))
y3 = dsolve('x*Dy = sqrt(1 - y^(2))','x')

% Solve the following ordinary differential equation numerically by using
% the ode45 function
tspan = [0 5];  % create variable value interval
y0 = 1;       % initial conditions
[t,y] = ode45(@(t,y) (-y*t)/sqrt(2 - y^(2)), tspan, y0); % use anonymous function in ode45()
plot(t,y,'o-')   % make the plot
title('$\frac{dy}{dx} = \frac{-yx}{\sqrt{2 - y^{2}}}, y(0) = 1$', 'interpreter', 'latex', 'FontSize', 16)
ylabel('$y(x)$', 'interpreter', 'latex', 'FontSize', 16);                   % set the plot title and axis labels
xlabel('$x$', 'interpreter', 'latex', 'FontSize', 16);

% Solve the following equation by using ode23 function. Plot the values of y1, y2, and y3.
tspan = [0 pi/2];              % create variable value interval
y0 = [1;-1;1];                   % array of initial conditions for each y_{n}(x)
[t, y] = ode23('HW6Q3', tspan, y0);              % apply the ode23 equation system solver.

plot(t,y(:,1),'o-', t,y(:,2), 'o-', t, y(:,3), 'o-')   % plot each of the solution curves.

lh = legend('$\frac{dy_{1}}{dx} = 2y_1 + y_2 + 5y_3 + e^{-2x}$', ...
'$\frac{dy_{2}}{dx} = -3y_1 - 2y_2 - 8y_3 + 2e^{-2x} - \mathrm{cos}(3x)$', ...
'$\frac{dy_{3}}{dx} = 3y_1 + 3y_2 + 2y_3 + \mathrm{cos}(3x)$', ...                   %make a nice legend
'FontSize', 14, ...
'Location','Northwest')
set(lh,'interpreter','latex');                       % set the legend interpreter to latex
title('$y_1(0) = 1, y_2(0) = -1, y_3(0) = 1$', 'interpreter', 'latex', 'FontSize', 16);
xlabel('$x$', 'interpreter', 'latex', 'FontSize', 16);                 % set the plot title and axis labels
ylabel('$y(x)$', 'interpreter', 'latex', 'FontSize', 16);