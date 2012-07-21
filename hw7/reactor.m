function [ ] = reactor(prob)

n = [1,0];
u = [-1, 1];
times = 0;
pt = 0.01;
bar(u,n)

p = input('Press enter to continue...');

while sum(n) <= 2^14 && sum(n) > 0
    if n(1) >= 1
        times = times + 1;
        for i = 1:n(1)
         	x=rand;
            if x <= prob
                n(1) = n(1) + 1;
                if sum(n) > 2^14
                    display(n);
                    title(sprintf('Times: %g -- Neutrons %g ',times,sum(n)));
                    xlabel('Core ----- Outside'); ylabel('Number');
                    error('Done!'); 
                end
                bar(u,n)
                pause(pt)
            elseif x <= prob + .3 && x > prob
                n(1) = n(1) - 1;
                n(2) = n(2) + 1;
                bar(u,n)
                pause(pt)
            else
            end
        end
    end
    
    if n(2) >= 1
        times = times + 1;
        for i = 1:n(2)
            x=rand;
            if x <= prob
                n(2) = n(2) + 1;
                if sum(n) > 2^14
                    display(n);
                    title(sprintf('Times: %g -- Neutrons %g ',times,sum(n)));
                    xlabel('Core ----- Outside'); ylabel('Number');
                    error('Done!');
                end
                bar(u,n)
                pause(pt)
            elseif x <= prob + .07 && x > prob
                n(2) = n(2) - 1;
                n(1) = n(1) + 1;
                bar(u,n)
                pause(pt)
            elseif x <= prob + .07 + 0.1 && x > prob + .07
                n(2) = n(2) - 1;
                bar(u,n)
                pause(pt)
            else
            end
        end
    end
end

display(n);
bar(u,n)
title(sprintf('Times: %g -- Neutrons %g ',times,sum(n)));
xlabel('Core ----- Outside'); ylabel('Number');

end