function [ mid ] = midint( x1,x2,n,func )
%integrate Demonstration of various simple integration techniques
%mid midpoint rule
%x1 lower limit
%x2 upper limit
%func function to be integrated
    dx = (x2-x1)/n;
    x = x1;
    mid=0.;
    for i= 1:n
        mid = mid + dx * func(x+dx/2);
        x= x+dx;
    end
