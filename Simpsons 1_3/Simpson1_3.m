function [I] = Simpson1_3(x, y)
% Numerical evaluation of integral by Simpson's 1/3 Rule
% Inputs
%   x = the vector of equally spaced independent variable
%   y = the vector of function values with respect to x
% Outputs:
%   I = the numerical integral calculated
size = length(x);
if ((size ~= length(y)) || size < 2)
    error("Input vectors X and Y must have the same length, and must be at least two points");
end

h = x(2)- x(1);
for i = 2:(size-1)
    h2 = x(i+1)- x(i);
    if (abs(h-h2) > 0.001)
        error("Input vector X must have equal spacing")
    end
end

if mod(size,2) == 0
    trap = 1;
    
else
    trap = 0;
end
num1_3 = (size-1-trap)/2;
s = 0;

if (num1_3 > 0)
    for i = 1:2:(2*num1_3)
        s = s + h/3*(y(i)+4*y(i+1)+y(i+2));
    end
end

if(trap)
    s = s + h/2*(y(size)-y(size-1));
    disp("Trapezoidal rule was used on last iteration");
end
I = s;
end