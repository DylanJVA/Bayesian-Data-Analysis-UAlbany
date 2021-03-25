%main.m this is the main program for Homework 8 the lighthouse problem
%Dylan VanAllen
[Obj, Samples, Try, n, MAX] = apply;

H = 0.0; %information
logZ = -realmax; %log evidence

for i = 1:n %Set prior objects for all n
    Obj(i) = Prior(Obj(i));
end

logwidth = log(1.0 - exp(-1.0 / n)); %Interval of prior mass

for nest = 1:MAX %Begin nested sampling
    worst = 1;%Worst (initially 1 instead of 0 because indexing in matlab
              %begins at 1 instead of 0 as in C
    for i = 1:n 
        if (Obj(i).logL < Obj(worst).logL) %Find the worst object
            worst = i;
        end
    end
    Obj(worst).logWt = logwidth + Obj(worst).logL;
    if (logZ > Obj(worst).logWt)
        logZnew = logZ + log(1+exp(Obj(worst).logWt - logZ)); %Update evidence
    else
        logZnew = Obj(worst).logWt + log(1 + exp(logZ - Obj(worst).logWt));
    end
    H = exp(Obj(worst).logWt - logZnew) * Obj(worst).logL + exp(logZ - logZnew) * (H + logZ) - logZnew;
    %Update information
    logZ = logZnew;
    %Posterior Samples
    Samples(nest) = Obj(worst);
    %Kill worst object in favour of copy of different survivor
    copy = ceil(n*rand());
    while((copy==worst) && n>1)
        copy = ceil(n*rand());
    end
    %Evolve the copied object 
    logLstar = Obj(worst).logL;
    Obj(worst) = Obj(copy);
    Obj(worst) = Explore(Obj(worst), Try, logLstar);
    %Shrink interval
    logwidth= logwidth - 1.0/n;
end
fprintf("# iterates = %d\n", nest);
fprintf("Evidence: ln(Z) = %g +- %g\n", logZ, sqrt(H/n));
fprintf("Information: H = %g nats = %g bits\n", H, H/log(2.));
Results(Samples, nest, logZ);
    
            
            