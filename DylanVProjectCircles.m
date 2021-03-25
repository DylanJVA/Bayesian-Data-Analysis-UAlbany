A = 8.5*11; %Area of the sheet of paper (in^2)
N = 50; % #Rice grains that landed on the paper
M = 18; % #Rice grains that landed inside a circle
K = 15; % #Circles
n = 100; %Number of prior objects
H = 0.0; %information
logZ = -realmax; %log evidence
fieldnames = {'area','r','logL', 'logWt'};
f = size(fieldnames,2);
cObj = cell([n, f]);
Obj = cell2struct(cObj, fieldnames, 2);
cSamples = cell([1000, f]);
Samples = cell2struct(cSamples, fieldnames, 2);
cTry = cell([1, f]);
Try = cell2struct(cTry, fieldnames, 2);
PDF = zeros(n,1);
maxP=1;


for i=1:n
    
    Obj(i).r = rand()*sqrt(A/K/pi)+0.005;
    Obj(i).logL = log(probRadius(M,A,N,Obj(i).r,K,n));
end


logwidth = log(1.0 - exp(-1.0 / n)); %Interval of prior mass
for nest = 1:1000 %Begin nested sampling
    worst = 1;%Worst (initially 1 instead of 0 because indexing in matlab
              %begins at 1 instead of 0 as in C
    for i = 2:n
        if (Obj(i).logL < Obj(worst).logL) %Find the lowest likelihood
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
    %Shrink interval
    step = 0.001;
    accept = 0;
    reject = 0;
    for m = 20:-1:0 %Begin exploring
        Try.r = Obj(worst).r + step *(2*rand() -1);
        Try.logL = log(probRadius(M,A,N,Try.r,K,n)); %Sets a likelihood for temp object
        if Try.logL > logLstar %Is temp object likelihood higher?
            Obj(worst) = Try; %If so, accept this new object
            accept = accept + 1;
        else
            reject = reject + 1; %If not, reject it
        end
        
        if accept > reject
            step = step * exp(1.0 / accept); %Make sure step size changes so
                                             %that acceptance % is near 50%
        end
        if accept < reject
            step = step / exp(1.0 / reject);
        end
    end
    %Shrink interval
    logwidth= logwidth - 1.0/n;
end
fprintf("# iterates = %d\n", nest);
fprintf("Evidence: ln(Z) = %g +- %g\n", logZ, sqrt(H/n));
fprintf("Information: H = %g nats = %g bits\n", H, H/log(2.));
meanr=0;
rr=0;
for i=1:nest
    w = exp(Samples(i).logWt - logZ);
    meanr = meanr + w * Samples(i).r;
    rr = rr + w * Samples(i).r * Samples(i).r;
end
fprintf("mean(r) = %g, stddev(r) = %g\n", meanr, sqrt(rr-meanr*meanr));
    
            
            