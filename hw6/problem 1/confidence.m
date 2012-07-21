function [ ans ] = confidence(tau, v, chi2, n, percent)
global tau1;
tau1 = tau; %To avoid global error

options=optimset('Jacobian','on','Algorithm','trust-region-reflective',...
    'Tolfun',10^(-10),'Display','off');
[v1,chi2p] = lsqnonlin(@expdls1,[v(1),v(2)],[0,0],[100000,100000],options);
fstat = (chi2p-chi2)*(n-3)/chi2;
ans = 1-fcdf(fstat,1,n-3)-percent;

end