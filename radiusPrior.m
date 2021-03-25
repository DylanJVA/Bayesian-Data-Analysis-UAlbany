function Obj = radiusPrior(Obj,A,K)
% radiusPrior
% radiusPrior sets an object according to the prior
%
% Usage:
%           Obj = Prior(Obj,A,K);
%           
% Where:
%           Obj is the object being set
%               using the Matlab structure array defined by struct
%
% Modified: 
%           Dylan VanAllen
%           7 December 2020
    n = 1000;
    Obj.area = rand()*A/K; %A random area . I changed this due to John Skilling's suggestion 
                           %to use a uniform area rather than uniform radius
    Obj.r = sqrt(Obj.area/pi);
    Obj.logL = log(probRadius(Obj.r)/n);
return
