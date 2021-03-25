function Obj = Explore(Obj, Try, logLstar)
%Explore function
%The Explore function evolves the object cell array by comparing it with
%the log likelihood constraint logLstar and uses a temporary 'Try' object
% Usage:
%           Obj = Explore(Obj, Try, logLstar);
%           
% Where:
%           Obj is the object being set by exploring the data
%           Try is a temporary object used while exploring
%           logLstar is a likelihood
% GNU General Public License software: Copyright Sivia and Skilling 2006
% Originally written in C
% Modified: 
%           Dylan VanAllen
%           02 December 2020 
%           Converted to Matlab

    step = 0.1; %Step size for (0,1)
    accept = 0; %counter of mcmc acceptances
    reject = 0; %counter of mcmc rejections
    for m = 20:-1:0
        Try.u = Obj.u + step*(2*rand() -1);
        Try.v = Obj.v + step*(2*rand() -1);
        Try.u = Try.u - floor(Try.u); %Takes decimal part of u & v
        Try.v = Try.v - floor(Try.v); 
        Try.x = 4.0 * Try.u - 2.0; %Maps u & v to x & y respectively
        Try.y = 2.0 * Try.v;
        Try.logL = logLhood(Try.x, Try.y); %Sets a likelihood for temp object
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

