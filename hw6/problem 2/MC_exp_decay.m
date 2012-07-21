function [] = MC_exp_decay( n,tauone,N1,tautwo,N2,dt2 )
% written by Rolfe G. Petschek March 27, 2009
% editted by some people

global C;
global dt;
global tau1;

dt = dt2; %To avoid a global var error...

C1=zeros(1,n);
for i=1:N1  %generate N decays with an exponential distribution
    ibin=ceil(-(tauone/dt)*log(rand(1)));
    if(ibin<=n)
        C1(ibin)=C1(ibin)+1;
    end
end

C2=zeros(1,n);
for i=1:N2  %generate N decays with an exponential distribution
    ibin=ceil(-(tautwo/dt)*log(rand(1)));
    if(ibin<=n)
        C2(ibin)=C2(ibin)+1;
    end
end

C = C1+C2;

t=zeros(1,n);
for i=1:n
    t(i)=dt*(i-1/2);
end

%fit
options=optimset('Jacobian','on','Algorithm','trust-region-reflective',...
    'Tolfun',10^(-10),'Display','off');
[v,chi2,error,exitflag]=lsqnonlin(@expdls,[1,1],[0,0],[10^6,10^6],options);
fprintf('fitted parameters, amplitude1+amplitude2, %g, tautotal, %g\n',v(1),v(2));

fprintf('reduced chi squared: %g \n', chi2/(n-2));
p=chi2cdf(chi2,n-2);
fprintf('Confidence limit like cumulative probability, %g \n', p)
fprintf('If this is remarkably close to zero or unity, take care\n\n')


figure(1)
hold on;
plot(t,C2,'g');
plot(t,C1,'r');
plot(t,C1+C2,'b');
F=zeros(1,n);
for i=1:n
    F(i)=v(1)*exp(-dt*(i-(1/2)))/v(2);
end
plot(t,F,'r')
legend('First decay','Second decay','Combined decay','Least square fit')
xlabel('time')
ylabel('counts')
title('Data and fit')
hold off;
%restricted fit to compute / errors on tau
f=zeros(1,41);
p=zeros(1,41);
tauc=zeros(1,41);
for i=1:41
    tauc(i)=v(1)*(1+(i-21)/80);
    tau1=tauc(i);
    [v,chi2p]=lsqnonlin(@expdls1,[v(1)],[0],[10^6],options);
    f(i)=(chi2p-chi2)*(n-2)/chi2;
end
figure(2)
plot(tauc,f)
xlabel('Decay rate \tau')
title('f statistic as a function of \tau')