% Prior
% Prior sets an object according to the prior
% This function is a matlab implementation of the Lighthouse Problem
% presented in Sivia and Skilling 2006, pp. 192-194.
%
% Usage:
%           Obj = Prior(Obj);
%           
% Where:
%           Obj is the object being set
%               using the Matlab structure array defined by struct
%
% GNU General Public License software: Copyright Sivia and Skilling 2006
% Originally written in C
% Modified: 
%           Kevin Knuth
%           08 June 2006 
%           Converted to Matlab

function Obj = Prior(Obj)

    Obj.u = rand();
    Obj.v = rand();
    Obj.x = 4.0 * Obj.u - 2.0;
    Obj.y = 2.0 * Obj.v;
    Obj.logL = logLhood(Obj.x, Obj.y);

return
