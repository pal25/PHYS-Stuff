function [ x ,n ] = solve( xmin,xmax,e,v,chi2,i,percent)
%Solves for a root on a line
% xmin: one user supplied side of the range
% xmax: another user supplied side of the range
% e: tolerance
% v: fitted parameters
% chi2: the chi^2 error
% i: degree of freedom
% percent: the confidence limit
if(xmin>xmax)
    t=xmax;
    xmax=xmin;
    xmin=t;
end

n=0;
fmax=confidence(xmax,v,chi2,i,percent);
fmin=confidence(xmin,v,chi2,i,percent);

if (fmax*fmin>0)
    error('you need to supply two points with differently signs of the function');
end

pre_side=0;
side=0;

while(xmax-xmin>e)
    n=n+1;
    if(side*pre_side>0)
        if(side>0)
            x=(xmax+3*xmin)/4.;
        else
            x=(3*xmin+xmax)/4.;
        end
    else
        x=xmin-fmin*(xmax-xmin)/(fmax-fmin);
    end

    fnew=confidence(x,v,chi2,i,percent);
    
    if (fmax*fnew>0)
        pre_side=side;
        side=1;
        xmax=x;
        fmax=fnew;
    else
        pre_side=side;
        side=-1;
        xmin=x;
        fmin=fnew;
    end
end

end