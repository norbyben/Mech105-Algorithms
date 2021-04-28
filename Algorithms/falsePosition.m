function [root, fx, ea, iter] = falsePosition(func, xl, xu, es, maxit, varargin)
%% falsePosition finds the root of a function using false position method
%% INPUTS:
%   func - A function, typically uses the @(x) operator (ex. myFunc = @(x) sin(x) + 2x - 5) 
%   xl - Lower bound for the function, probably retrieved graphically
%   xu - Upper bound for the function
%   es - Maximum relative error (term to term). It should always be greater
%   than true error for the x value. Default: 0.0001%
%   maxit - Max number of iterations. Default: 200
%% OUTPUTS:
%   root - The estimated value for the root after the stopping criterion
%   fx - The value evaluated at the root.
%   ea - The relative error when the function stopped.
%   iter - The number of iterations when the function stopped.
%% Details
% Author -- Benjamin Norby
% Class -- Mech 105, Dr. Bechara
% Date -- 2/25/20
%%
%Recieves number of inputs and outputs an error if too many / few arguments
if (nargin < 3)
    error("Too few input Arguments. Order is function, lower bound, upperbound, relative error % (default .0001%), and max interations (default 200).");
end
if (nargin > 5)
    error("Too many input arguments. Order is function, lower bound, upperbound, relative error % (default .0001%), and max interations (default 200).");
end

%Checks if a sign change is within the bounds
if (func(xl)*func(xu) > 0)
    error("No sign change detected.");
end

% Sets defaults for relative error (es) and max iterations (maxit) if they were unspecified in function call
if (nargin < 5)
    maxit = 200;
end

if (nargin < 4)
    es = 0.0001;
end

%This loop finds the root value using the false position function and
%calculates error while checking for the stopping criterion.
iter = 0;
xr = xl;
while(1)
    xold = xr;
    iter = iter + 1;
    xr = xu - (func(xu)*(xl - xu))/(func(xl) - func(xu));
    ea = 100*abs(xr - xold)/xr;
    
    if (func(xl)*func(xr) < 0)
        xu = xr;
    elseif (func(xu)*func(xr) < 0)
        xl = xr;
    else
        ea = 0;
    end
    
    if (iter >= maxit) || (ea < es)
        break;
    end
end
%Return values
root = xr;
fx = func(root, varargin{:});

end