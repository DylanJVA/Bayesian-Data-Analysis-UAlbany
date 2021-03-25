function prob = probRadius(R);
%probRadius function
%The probRadius function takes the data and determines the likelihood for
%each radius
% Usage:
%           prob = probRadius(R);
%           
% Where:
%           prob is the probability of this being the radius given the data
%
% Modified: 
%           Dylan VanAllen
%           07 December 2020 
    [Obj, Samples, Try, n, MAX, A, N, M, K] = radiusApplication;
    prob = factorial(N)/(factorial(M)*factorial(N-M))*(pi*R^2*K/A)^M*(1-(pi*R^2*K/A))^(N-M);
return