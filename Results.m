function Results(Samples, nest, logZ)
%Results function
%The results function takes in the samples object, a number of samples, and
%log evidence. It then prints the mean and standard deviation
% Usage:
%           Results(Samples, nest, logZ)
%           
% Where:
%           Samples is an object of posterior samples
%           nest is the number of samples
%           logZ is the log evidence to be accumulated and printed
% GNU General Public License software: Copyright Sivia and Skilling 2006
% Originally written in C
% Modified: 
%           Dylan VanAllen
%           02 December 2020 
%           Converted to Matlab
    x = 0.0; %mean (first moment) of x & y
    y = 0.0;
    xx = 0.0; %standard deviation (second moment) of x & y
    yy = 0.0;
    for i=1:nest
        w = exp(Samples(i).logWt - logZ);
        x = x + w * Samples(i).x;
        xx = xx + w * Samples(i).x * Samples(i).x;
        y = y + w * Samples(i).y;
        yy = yy + w * Samples(i).y * Samples(i).y;
    end
    fprintf("mean(x) = %g, stddev(x) = %g\n", x, sqrt(xx-x*x));
    fprintf("mean(y) = %g, stddev(y) = %g\n", y, sqrt(yy-y*y));
end

