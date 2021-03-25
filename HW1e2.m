%Dylan VanAllen
%Dice Simulator
%All of these results can be checked easily using P(sixes) = 1 - P(no six)
% = 1 - (5/6)^n
prob1 = myDICE(6);
fprintf("The probability of getting at least one six on 6 dice rolls is %0.3f\n", prob1)
prob2 = myDICE(12);
fprintf("The probability of getting at least two sixes on 12 dice rolls is %0.3f\n", prob2)
prob3 = myDICE(18);
fprintf("The probability of getting at least three sixes on 18 dice rolls is %0.3f\n", prob3)
prob = zeros(20, 1);
x = 6:6:120;%MATLAB cannot handle prod(1:x) with x too large, I chose 120
n = 1;
for element = x
    prob(n) = myDICE(element);
    n = n + 1;
end
plot(x, prob);
xlabel('number of rolls (n)') 
ylabel('Probability of rolling n/6 sixes')
title('How does this probability behave as n gets large?')