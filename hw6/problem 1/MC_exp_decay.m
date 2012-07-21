function [] = MC_exp_decay( n,tau,N,dt2,b,percent )
% written by Rolfe G. Petschek March 27, 2009
% editted by some people

global C;
global dt;
global tau1;

dt = dt2; %To avoid a global var error...

C=zeros(1,n);
for i=1:N  %generate N decays with an exponential distribution
    ibin=ceil(-(tau/dt)*log(rand(1)));
    if(ibin<=n)
        C(ibin)=C(ibin)+1;
    end
end

t=zeros(1,n);
for i=1:n %add in Poisson "background" noise
    C(i)=C(i)+poissrnd(b*dt*N);
    t(i)=dt*(i-1/2);
end

%fit
options=optimset('Jacobian','on','Algorithm','trust-region-reflective',...
    'Tolfun',10^(-10),'Display','off');
[v,chi2,error,exitflag]=lsqnonlin(@expdls,[1,1,1],[0,0,0],[100000,100000,100000],options);
fprintf('fitted parameters, background, %g, amplitude, %g, tau, %g\n',v(1),v(2),v(3));
fprintf('reduced chi squared: %g \n', chi2/(n-3));
p=chi2cdf(chi2,n-3);
fprintf('Confidence limit like cumulative probability, %g \n', p)
fprintf('If this is remarkably close to zero or unity, take care\n')

% restricted fit to compute / errors on tau
f=zeros(1,41);
p=zeros(1,41);
tauc=zeros(1,41);
for i=1:41
    tauc(i)=v(3)*(1+(i-21)/80);
    tau1=tauc(i);
    [v1,chi2p]=lsqnonlin(@expdls1,[v(1),v(2)],[0,0],[100000,100000],options);
    f(i)=(chi2p-chi2)*(n-3)/chi2;
    p(i)=1-fcdf(f(i),1,n-3);
end

i=1; %Find somewhere to start...
while(p(i)-percent) < 0
    i=i+1;
end

%Find the lower tau confidence
lowertau = solve(tauc(i-1),tauc(i),10^-2,v,chi2,n,percent);
display(lowertau);
display(confidence(lowertau,v,chi2,n,percent)+percent);

while(p(i)-percent) > 0 %Find somewhere to start...
    i=i+1;
end

%Find the upper tau confidence
uppertau = solve(tauc(i-1),tauc(i),10^-2,v,chi2,n,percent);
display(uppertau);
display(confidence(uppertau,v,chi2,n,percent)+percent);

%First Plot...
figure(1)
errorbar(t,C,C.^(1/2),'+');
hold on;
F=zeros(1,n);

for i=1:n %Find the actual fit
    F(i)=v(1)+v(2)*exp(-dt*(i-(1/2))/v(3));
end

tau1 = lowertau;
[v1,chi2p]=lsqnonlin(@expdls1,[v(1),v(2)],[0,0],[100000,100000],options);
for i=1:n %Find lower confidence
    lower(i)=v1(1)+v1(2)*exp(-dt*(i-(1/2))/lowertau);
end

tau1 = uppertau;
[v1,chi2p]=lsqnonlin(@expdls1,[v(1),v(2)],[0,0],[100000,100000],options);
for i=1:n %Find upper confidence
    upper(i)=v1(1)+v1(2)*exp(-dt*(i-(1/2))/uppertau);
end

%First Plot
plot(t,F,'r')
plot(t,lower,'green')
plot(t,upper,'black')
legend('data points','Least square fit','lower confidence','upper confidence')
xlabel('time')
ylabel('counts')
title('Data and fit')
hold off;

%Second and third plots
figure(2)
plot(tauc,f)
xlabel('Decay rate \tau')
title('f statistic as a function of \tau')
figure(3)
plot(tauc,p)
title('Confidence limit as a function of \tau')

end