function [ F,J ] = expdls1( v )
%minimization function + Jacobian for exponential decay B+ background
%   Global C: data
%   Global dt: bin size
%   Global tau1 FIXED value of tau
%   v(1)  background level
%   v(2)  amplitude of decay
%OUTPUT
%    F(i,1) deviation in bin i
%    J(i,1) derivative of deviation in bin i with respect to b
%    J(i,2) derivative of deviation in bin i with respect to a
%
global C;
global dt;
global tau1;
[l,m]=size(C);
if (l~=1||m<3)
    error('need at least 3 component vector of input counts')
end
a=v(1);
tau=tau1;
F=zeros(m,1);
J=zeros(m,1);
for i=1:m  %loop to compute deviations and Jacobian
    F(i)=(C(i)-(a*exp(-(i-1/2)*dt/tau)))*C(i)^(-1/2);
    J(i,1)=-exp(-(i-1/2)*dt/tau)*C(i)^(-1/2);
end
end