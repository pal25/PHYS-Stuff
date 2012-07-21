function[ value ] = findeigen( mat, tolerance, maxit )
% This program takes in inputs and gives the largest eigenvector
% mat = coefficient matrix
% tolerence = the difference in estimates to the vector
% maxit = maximum iterations before termination


%Declare some stuff
itcounter = 1;
k = 1;
value1 = 1;
value2 = tolerance;

%Initial guess of eigenvector
for i=1:size(mat,1)
    y(i,1) = 1;
end

%Iterate the eigenvector
while(abs(value1 - value2) / abs(value1) > tolerance)
%for i = 1:100
    if itcounter == maxit %Check maximum iterations
         error('Maximum iterations reached');
    end
    newx = mat * y;
    y = 1 / max(newx) * newx;
    eigen(k) = max(newx);
    value1 = value2;
    value2 = eigen(k);
    k = k + 1;
    itcounter = itcounter + 1;
    
end

%Display the 
display(y); %Eigenvector
display(eigen(k-1)); %Eigenvalue
display(itcounter); %Iteration Counter
end