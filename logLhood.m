function logL = logLhood(x,y)
%logLhood function
%The logLhood function takes the data and determines likelihoods for each
%data point given x and y
% Usage:
%           logL = logLhood(x,y)
%           
% Where:
%           logL is the likelihood of a given data point in cartesian
%           coordinates x and y
%
% GNU General Public License software: Copyright Sivia and Skilling 2006
% Originally written in C
% Modified: 
%           Dylan VanAllen
%           02 December 2020 
%           Converted to Matlab
    [Obj, Samples, Try, n, MAX] = apply; %Runs the apply function to get necessary variables
    global D; %Data, defined in apply.m but needs to be declared here for use
    logL=0; %Initial likelihood is 0
    N = size(D,2); %Second dimension of D is the number of data points
    for k=1:N %For every data point, accumulate likelihood
        logL = logL + log((y/pi) / ((D(k)-x)*(D(k)-x)+y*y));
    end
end

