results = zeros(6,1);
numsixes = 0;
n=6;
for roll = 1:n
    results(roll) = randi([1 6])
end
for result = 1:n
    if results(result) == 6
        numsixes = numsixes + 1;
    end
end