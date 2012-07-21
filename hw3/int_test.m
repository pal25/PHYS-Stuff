function [ dx ] = int_test ( func, xmin, xmax, npoints, ninterp )
%Tests Garcia's interpolation function
%   func  Function to be interpolated
%   xmin  Lower limit of range
%   xmax  Upper limit of range
%   npoints  Number of points to be taken from the "real" function
%   ninterp  Number of interpolated points between points at which the 
%      function in evaluated
dx=(xmax-xmin)/(npoints-1);
dxi=dx/(ninterp-1);
n=1;
xc=xmin;
for i=1:npoints-1
    for j=1:4
        xi(j)=xmin+(i+j-2)*dx;
        yi(j)=func(xi(j));
    end
    for j=0:ninterp
        x(n)=xc;
        y(n)=intrpf(x(n),xi,yi);
        n=n+1;
        xc=xc+dxi;
    end
    for j=0:ninterp-1
        x2(n)=xc;
        y2(n)=intrpf2(x2(n),xi,yi);
        n=n+1;
        xc=xc+dxi;
    end
    
end
x(n)=xmax;
y(n)=func(xmax);
plot(x,y,'rs--')
end