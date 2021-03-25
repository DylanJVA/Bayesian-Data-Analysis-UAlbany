%Dylan VanAllen
%Create a vector of 10 0.1s and sum it
tic
v = 0.1+zeros(10,1);    %creates a zero vector with 10 0s and adds 0.1 to each
for i = 1:10000000      %sums vector elements 10000000 times
    sum(v);
end
t = toc;        
disp(t);                %time elapsed is between 0.75 and 0.83s, much slower
                        
disp(sum(v))            %this displays correctly
disp(sum(v)-1)          %This error is the same as part a


