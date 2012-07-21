function [ F, J ] = expdls( v )
%minimization function + Jacobian for exponential decay B+ background
%   Global C: data
%   Global dt: bin size
%Input
%   v(1)  background level
%   v(2)  amplitude of decay
%   v(3) decay rate tau
%Output
%    F(i,1) deviation in bin i
%    J(i,1) derivative of deviation in bin i with respect to b
%    J(i,2) derivative of deviation in bin i with respect to a
%    J(i,3) derivative of deviation in bin i with respect to tau
%
global C;
global dt;
[l,m]=size(C);
if (l~=1||m<3)
    error('need at least 3 component vector of input counts')
end
% name variables
b=v(1);
a=v(2);
tau=v(3);
%allocate space
F=zeros(m,1);
J=zeros(m,3);
for i=1:m  %loop to compute deviations and Jacobian
    F(i)=(C(i)-(b+a*exp(-(i-1/2)*dt/tau)))*C(i)^(-1/2);
    J(i,1)=-C(i)^(-1/2);
    J(i,2)=-exp(-(i-1/2)*dt/tau)*C(i)^(-1/2);
    J(i,3)=-a*exp(-(i-1/2)*dt/tau)*((i-1/2)*dt*tau^(-2))*C(i)^(-1/2);
end
end