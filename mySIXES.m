% mySIXES
% rolls a six sided dice n times
% 
%
% Usage:
%           numsixes = mySIXES(n)
%           
% Where:
%           input_args  = n, the number of times you want to roll the dice
%           output_args = numsixes = the number of sixes in these n rolls
%
% Created By: 
%           Dylan VanAllen
%           9/15/2020
%
% Modified 9/15/2020
function numsixes = mySIXES(n)
results = zeros(6,1);
numsixes = 0;
for roll = 1:n
    results(roll) = randi([1 6]);
end
for result = 1:n
    if results(result) == 6
        numsixes = numsixes + 1;
    end
end 
       