%Dylan VanAllen
%HW1e roll some dice and find the probability of getting at least n/6 sixes
%on n six-sided dice
for n = 6:6:120;
    count = 0;
    for i = 1:100000 %Iterated 1000000 times to obtain a good estimate
        if mySIXES(n) >= n/6 %When you roll n dice and get sufficient sixes count this
            count = count + 1;
        end
    end
    count = count/100000;%Take the average - how many times you got sufficient sixes/total number of n rolls
    fprintf("The probability of getting at least %i six(es) on %i dice rolls is %0.3f\n", n/6,n, count)
end
       