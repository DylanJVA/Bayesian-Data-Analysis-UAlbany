% myCOSINE
% Compute the values of cos(x) correct to three decimal places using Taylor
% Series
%
% Usage:
%           y = myCOSINE(x)
%           
% Where:
%           input_args  = x, the value of which this function will find
%           the cosine
%           output_args = y = cos(x)
%
% Created By: 
%           Dylan VanAllen
%           9/10/2020
%
% Modified 9/13/2020
function y = myCOSINE(x)
numdecimalplaces = 4; %3+1 in case it is just barely able to be rounded
y = 1;
n = 1;                         
nth_term = 1;
x = abs(x);
x = mod(x, (2*pi)); %cosine repeats every 2pi

if x < pi
    while abs(nth_term) > 10^(-1*numdecimalplaces) 
        %checks if an additional term changes sum by more than 1/10000
        nth_term = ((-1)^n)*(x^(2*n))/prod(1:(2*n)); 
        %taylor series approximation for cos(x)
        y = y + nth_term;
        n = n + 1;
    end
else %here we will use symmetry of cosine before and after pi
    while abs(nth_term) > 10^(-1*numdecimalplaces)          
        nth_term = ((-1)^n)*((pi-x)^(2*n))/prod(1:(2*n)); 
        %cos(pi-x) = -cos(x), pi - x subbed in
        y = y + nth_term;
        n = n + 1;
    end
    y = -1 * y; %cos(pi-x) = -cos(x), final negative sign applied
end
    

    