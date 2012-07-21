function [approx] = mc(func,a,b,c,d,e,f,g,h,i,j,n)

%This program does a monte carlo approximation for an integral in 4D.
%a,b,c,d,e,f,g,h are dimensions: [a,b]x[c,d]x[e,f]x[g,h]x[i,j]
%n is the number of random numbers to evaluate

t=rand(5,n);                %4-by-N random number matrix
x=a+t(1,:).*(b-a);			%Random number on [a,b]
y=c+t(2,:).*(d-c);			%Random number on [c,d]
z=e+t(3,:).*(f-e);			%Random number on [e,f]
w=g+t(4,:).*(h-g);			%Random number on [g,h]
v=i+t(5,:).*(j-i);			%Random number on [g,h]
interval = (b-a).*(d-c).*(f-e).*(h-g).*(j-i);

for k=1:n %Evaluate the function n times
    z(k) = interval*feval(func,x(k),y(k),z(k),w(k),v(k));
end

%Take the average value of the evaluated function
approx = sum(z) ./ n;

%Calculate standard deviation
mu = sum(z) ./ n;
sample_standard_deviation=(sum(z.^2)-sum(z).^2./(n))./(n-1);
variance_in_mean = sample_standard_deviation/n;
stdev = variance_in_mean^(1/2);
display(stdev);


for k=1:n
    x(k) = k/n;
    gauss(k) = exp(-(x(k)- mu)^2 / (2*stdev.^2))./(stdev*(sqrt(2*pi)));
end

plot(x,gauss)

end
