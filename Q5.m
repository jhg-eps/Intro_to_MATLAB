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