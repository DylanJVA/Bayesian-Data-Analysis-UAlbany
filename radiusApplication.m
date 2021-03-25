% radiusApplication
%
% Usage:    [Obj, Samples, Try, n, MAX, A, N, M, K] = radiusApplication
%
% Where:
%           Obj       Structure array for n simulation objects
%           Samples   Structure array for MAX simulation samples
%           Try       Structure array for trial simulation
%           n         Number of Simulation Objects
%           MAX       Number of Iterations
%
%
% 
% Problem:      Determine the radius of a circle given how many circles are
% on the sheet, how large the sheet is, how many grains landed in circles,
% and how many grains landed on the sheet. 
% Inputs to the Problem:
%   radiusPrior(Area) is uniform over (0,A/K)
% Outputs to the Problem:
%   Evidence    is Z = INTEGRAL L(r) radiusPrior(r) dr
%   Posterior   is P(r) = L(r)/Z estimating lighthouse position
%   Information is H = INTEGRAL P(r) log(P(r)/radiusPrior(r)) dr
%
% Modified: 
%           Dylan VanAllen
%           07 December 2020

function [Obj, Samples, Try, n, MAX, A, N, M, K] = radiusApplication

    n = 100;    % Number of Objects
    MAX = 1000;  % Number of Iterations
    A = 8.5*11; %Area of the sheet of paper (in^2)
    N = 50; % #Rice grains that landed on the paper
    M = 18; % #Rice grains that landed inside a circle
    K = 15; % #Circles
    
    % Define the fieldnames
    % This is all you will have to change if you want to change the structure
    fieldnames = {'area', 'r', 'logL', 'logWt'};

    % set up the Objects and Samples
    f = size(fieldnames,2);

    cObj = cell([n, f]);
    Obj = cell2struct(cObj, fieldnames, 2);

    cSamples = cell([MAX, f]);
    Samples = cell2struct(cSamples, fieldnames, 2);

    cTry = cell([1, f]);
    Try = cell2struct(cTry, fieldnames, 2);
    
return 