% apply
% "LIGHTHOUSE NESTED SAMPLING APPLICATION"
% GNU General Public License software: Copyright Sivia and Skilling 2006
% This function is a matlab implementation of the Lighthouse Problem
% presented in Sivia and Skilling 2006, pp. 192-194.
%
% Usage:    [Obj, Samples, Try, n, MAX] = apply
%
% Where:
%           Obj       Structure array for n simulation objects
%           Samples   Structure array for MAX simulation samples
%           Try       Structure array for trial simulation
%           n         Number of Simulation Objects
%           MAX       Number of Iterations
%
%
% The Problem:
%
%            u=0                                   u=1
%             ----------------------------------------
%       y=2  |::::::::::::::::::::::::::::::::::::::::| v=1
%            |:::::::::::::::::::::::::LIGHT::::::::::|
%       north|:::::::::::::::::::::::::HOUSE::::::::::|
%            |::::::::::::::::::::::::::::::::::::::::|
%            |::::::::::::::::::::::::::::::::::::::::|
%       y=0  |::::::::::::::::::::::::::::::::::::::::| v=0
% --*--------------*-----*---------*-**--**--*-*-------------*---
%             x=-2        coastline -->east         x=2
%
% Problem:      Lighthouse at (x,y) emitted n flashes observed at D(.) on
%               the coast
% Inputs to the Problem:
%   Prior(u)    is uniform over (0,1), mapped to x = 4*u-2; and
%   Prior(v)    is uniform over (0,1), mapped to y = 2*v; so that
%   Position    is 2-dimensional -2<x<2, 0<y<2 with flat prior
%   Likelihood  is L(x,y) = PRODUCT[k] (y/pi)/((D(k)-x)2+y^2)
% Outputs to the Problem:
%   Evidence    is Z = INTEGRAL L(x,y) Prior(x,y) dxdy
%   Posterior   is P(x,y) = L(x,y)/Z estimating lighthouse position
%   Information is H = INTEGRAL P(x,y) log(P(x,y)/Prior(x,y)) dxdy
%
% Originally written in C
% Modified: 
%           Kevin Knuth
%           08 June 2006 
%           Converted to Matlab

function [Obj, Samples, Try, n, MAX] = apply

    global D;   % data

    n = 100;    % Number of Objects
    MAX = 1000;  % Number of Iterations

    % Skilling defines the structure here, which is necessary in C
    % We actually create the objects here

    % Define the fieldnames
    % This is all you will have to change if you want to change the structure
    fieldnames = {'u', 'v', 'x', 'y', 'logL', 'logWt'};

    % set up the Objects and Samples
    f = size(fieldnames,2);

    cObj = cell([n, f]);
    Obj = cell2struct(cObj, fieldnames, 2);

    cSamples = cell([MAX, f]);
    Samples = cell2struct(cSamples, fieldnames, 2);

    cTry = cell([1, f]);
    Try = cell2struct(cTry, fieldnames, 2);

    % Skilling sets the data D in logLhood, which is faster in C when compiled.
    % I have moved that definition here so that the data are abstracted out
    % from the actual program.

    % N = 64      % Number of Flashes

    D = [4.73, 0.45, -1.73, 1.09, 2.19, 0.12, 1.31, 1.00, 1.32, 1.07, 0.86, ...
        -0.49, -2.59, 1.73, 2.11, 1.61, 4.98, 1.71, 2.23,-57.20, 0.96, 1.25,...
        -1.56, 2.45, 1.19, 2.17,-10.66, 1.91, -4.16, 1.92, 0.10, 1.98, ...
        -2.51, 5.55, -0.47, 1.91, 0.95, -0.78, -0.84, 1.72, -0.01, 1.48, ...
        2.70, 1.21, 4.41, -4.79, 1.33, 0.81, 0.20, 1.58, 1.29, 16.19, 2.75,...
        -2.38, -1.79, 6.50,-18.53, 0.72, 0.94, 3.64, 1.94, -0.11, 1.57, 0.57];
return 