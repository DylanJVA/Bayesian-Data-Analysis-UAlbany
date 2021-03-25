function Obj = radiusExplore(Obj, Try, logLstar)
%radiusExplore function
%The radiusExplore function searches randomly around a previous radius to
%find one with better likelihood
% Usage:
%           Obj = radiusExplore(Obj, Try, logLstar);
%           
% Where:
%           Obj is the object being set by exploring the data
%           Try is a temporary object used while exploring
%           logLstar is a likelihood
% Modified: 
%           Dylan VanAllen
%           07 December 2020 
    n=1000;
    step = 0.005; %Step size for (0,1)
    accept = 0; %counter of mcmc acceptances
    reject = 0; %counter of mcmc rejections
    for m = 20:-1:0
        Try.area = Obj.area + step*(rand()*2 - 1);
        Try.r = sqrt(Try.area/pi);
        Try.logL = log(probRadius(Try.r)/n); %Sets a log likelihood for temp object
        if Try.logL > logLstar %Is temp object likelihood higher?
            Obj = Try; %If so, accept this new object
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
return

