priormean = 50000;
priorunc = 10000;
tanknum = [038839 019401 012031 020106 004802 006570 046893 047594 028633 002976 011687 017580 040877 000767 002142 008412 032312 036423 032243 022446];
x = 0:100000;
priorprob = zeros(length(x),1);
postprob = zeros(length(x),1);
i = 1;
max = 0;
for xi = x 
    priorprob(i) = (priorunc*sqrt(2*pi))^-1*exp(-1*(xi-priormean)^2/(2*priorunc)^2);
    postprob(i) = priorprob(i);
    for tank = 1:20
        if xi >= tanknum(tank)
            postprob(i) = postprob(i)*(1/xi);
        else
            postprob(i) = postprob(i)*0;
        end
    end
    if postprob(i) > max
        max = xi;
    end
    i = i + 1;
end
postprob = postprob ./ sum(postprob);
plot(x, postprob, x, priorprob);
disp(max);

