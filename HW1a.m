%Dylan VanAllen
%Create a variable and add 0.1 to that variable 10 times
tic                 %begin stopwatch
for i  = 1:10000000   %adds 0.1 to 0 10 times, 10000000 times
    x=0;
    for i = 1:10
        x=x+0.1;
    end
end
t = toc;
disp(t)             %elapsed time  between 0.075 and 0.085s
disp(x)             %This displays correctly
disp(x-1)           %This shows how the answer is off by 1.11e-16