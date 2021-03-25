% myDICE
% determines the probability of getting at least n/6 sixes on n dice rolls
% 
%
% Usage:
%           prob = myDICE(n)
%           
% Where:
%           input_args  = n, the number of times you want to roll the dice
%           output_args = prob = probability of getting at least n/6 sixes
%
% Created By: 
%           Dylan VanAllen
%           9/13/2020
%
% Modified 9/15/2020
function prob = myDICE(n)
%P(>= n/6 sixes) = 1 - P(no sixes) - P(1 six) - ...P(n-1 sixes)
%I used this subtractive method because it takes few iterations than the
%additive method
probcalc = 1;
leastnumsixes = n/6;
for r = 0:1:leastnumsixes-1
   probcalc = probcalc - 5^(n-r)*prod(1:n)/(prod(1:r)*prod(1:(n-r))*6^n);
end
prob = probcalc;
% Another way to do it (in more steps) is:
% P(>= n/6 sixes) = P(n/6 sixes) + P((n/6)+1 sixes) + ... + P(n sixes)
% prob = 0;
% for r = n/6:n
%      prob = prob + 5^(n-r)*prod(1:n)/(prod(1:r)*prod(1:(n-r))*6^n);
% end
end
    