function[ mu, stdev ] = distrib( m_number,n_number )
%mnumber - Sum of the squares of "random" numbers
%nnumber - Random numbers used to calculate M.

for i=1:m_number
    for j=1:n_number
        n(j) = randn^2;
    end
    m(i) = sum(n);
end

%Calculate mu
mu = sum(m) / m_number;

%Bin the numbers
for i=1:2*n_number
    c(i) = 0;
end

for j=0:(2*n_number-1)
    for i=1:m_number
        if m(i) >= j && m(i) < j+1 
            c(j+1) = c(j+1) + 1;
        end
    end
end

%Computes (xi - mu)^2
for i=1:m_number
    m_mu(i) = (m(i) - mu)^2;
end

%Calculate standard deviation
sigmasqrd = sum(m_mu) / (m_number - 1);

stdev = sqrt(sigmasqrd);

%Plot everything
for i=1:(2*n_number+1)
    x(i) = i-1/2; 
    gaussian(i) = 1/(sqrt(2*pi)*stdev) * exp(-(x(i)- mu)^2 / (2*sigmasqrd));
    h(i) = 1 / (sqrt(4*pi*n_number) * exp((x(i) - n_number)^2 / (4*n_number)));
    g(i) = x(i)^(n_number/2 - 1) / (exp(x(i)/2) * 2^(n_number / 2) * gamma(n_number / 2));
end

for i=1:(2*n_number)
    b(i) = i;
end

plot(x,gaussian,'-',x,h,'yellow',x,g,'black',b,c/m_number,'-');
title('Distributions and Number Bin');
xlabel('Values of Random Numbers');
ylabel('Percentage');
legend('Gaussian Distribution', 'Other Distribution?', 'Gamma Distribution', 'Number Bin');


%Debug
% for i=1:m_number
% x(i) = i;
% mu2(i) = mu;
% splus(i) = mu + stdev;
% sminus(i) = mu - stdev;
% end
% 
% plot(x,m,'p',x,mu2,'--rs',x,splus,x,sminus,'-')

end

