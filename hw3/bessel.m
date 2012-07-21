function [ total, jj ] = bessel( t )
%t is the independent variable

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%    Method One    %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
i = 0;
y(i+1) = ((((-t)^2 / 4)^(i)) / factorial(i)^2);
total = y(i+1);
i = i + 1;

while( abs((-t^2 / 4)^(i) / factorial(i)^2) >= 10^(-8) ) 
   y(i+1) = y(i) + (-t^2 / 4)^(i) / factorial(i)^2;
   display(y(i+1));
   i = i + 1;
end

total = y(i);
display(i);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%    Method Two    %%%%%%%%%%
%%%%%%%%%    By: Garcia    %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m_top = ceil((20+15*abs(t)^(1/3)) + abs(t));
j(m_top+1) = 0;
j(m_top) = 1;

for m=m_top-2:-1:0    % Downward recursion
  j(m+1) = 2*(m+1)/(t)*j(m+2) - j(m+3);
end

%* Normalize using identity and return requested values
norm = j(1);              
for m=2:2:m_top           
  norm = norm + 2*j(m+1);
end

jj = j(1)/norm;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%    Plot Settings    %%%%%%%%
%%%%%% For Use In Command Line %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%subplot(2,2,1);
%plot(x,y,'rs--',x,b,'-');
%xlabel('Points');
%ylabel('y');
%title('Method 1');
%legend('Method 1','Matlab besselj');

%subplot(2,2,3);
%plot(x, abs(b-y));
%xlabel('Points');
%ylabel('Error');
%title('Error in Method 1');
%legend('Error');

%subplot(2,2,2);
%plot(x,j,'rs--',x,b,'-');
%xlabel('Points');
%ylabel('y');
%title('Method 2');
%legend('Method 2','Matlab besselj');

%subplot(2,2,4);
%plot(x, abs(b-j));
%xlabel('Points');
%ylabel('Error');
%title('Error in Method 2');
%legend('Error');
   

    
    