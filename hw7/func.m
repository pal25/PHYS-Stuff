function [ans1] = func( x,y,z,w,v )
ans1 = exp(x.^2 * cos(y.^2 + z.*w)) / (w+2);
ans2 = cos((x + y.^2 + z.^3 + v * w).^2) * exp(2*x);
ans3 = x.^3;
end