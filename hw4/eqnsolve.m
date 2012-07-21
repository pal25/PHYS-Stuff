function [soln] = eqnsolve(func, funcderv, c, tolerence)
%This m-file uses Newton-Raphson to solve for the value of an equation

% func = A pointer for the function that is being evaluated
% funcderv = A pointer for the derivative of the function
% c = The condition we're trying to solve the function for
% tolerence = The accepted difference between two successive terms

%Random initial stuff
x = c - 1;
newx = c;
i = 1;

%Loop until the difference is small enough
while(abs(newx - x) > tolerence)
    x = newx;
    newx = x + ((c - func(x)) / funcderv(x));
    y(i) = newx;
    a(i) = i;
    i = i + 1;
    
    %Make sure the method stays in check
    if (i > 2) && (abs(newx-x) > 10^6*abs(y(2)-y(1)))
        error('Change in x is too large.'); 
    end
end

%Plot and print the solution
plot(a,y,'--rs')
soln = newx;
end
    
    
