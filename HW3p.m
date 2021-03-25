%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                       Bayesian Data Analysis
%                       and Signal Processing
%
%          A PHY 451/551 and I CSI 451/551 and IINF 451/551
%                             FALL 2020
%
%                     Instructor: Kevin H. Knuth
%
%
% HW 3p
% Working with Data: Climate Change
%
% The purpose of this homework set is to introduce you to data analysis in
% Matlab.  This involves importing data into Matlab and performing basic 
% manipulations.
%
% We will perform some *crude* analyses of atmospheric CO2 data.
%
% TURN IN:
% Zip file containing:
%    1. this M-file with your code inserted
%    2. The MAT-files containing the data as instructed below
%    3. A report summarizing your work, illustrating your results (figures) 
%       and discussing your answers to the questions posed below.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Problem by: Kevin H. Knuth
% Created on: 8 August 2006
% Modified on: 6 October 2020 by Dylan VanAllen
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Download (or unzip) the Vostok Ice Core Sample Data Set
% Import them into Matlab using the Import Data function in the File Menu
% Restructure the data into two arrays:
% vyear <1x363>   - years BP (before present, which was 2003)
% vco2  <1x363>   - co2 concentration in ppm
% V               - number of measurements
% save the results in a mat-file
%
% These data are provided courtesy of:
% Historical carbon dioxide record from the Vostok ice core
% J.-M. Barnola, D. Raynaud, C. Lorius
% Laboratoire de Glaciologie et de Géophysique de l'Environnement, CNRS,
% BP96, 38402 Saint Martin d'Heres Cedex, France 
% and
% N.I. Barkov
% Arctic and Antarctic Research Institute, Beringa Street 38, 199397, St.
% Petersburg, Russia

% Import the data into Matlab using the Import Data function in the 
% File Menu.  Restructure the data into two arrays as instructed above.
% Omit the missing data
load('co2data.mat');
vyear = flip(2003 - vostokicecoreco2.AirAge);
vco2 = flip(vostokicecoreco2.CO2);
ROV = range(vco2)
Mean = mean(vco2)
sigma = std(vco2)
tiledlayout(2,2)
% Plot the CO2 levels over time
nexttile
plot(vyear, vco2);
title('Vostok Ice Core Samples')
xlabel('Year (CE)')
ylabel('CO2 (ppm)')

% QUESTIONS TO DISCUSS IN YOUR REPORT
% What is the range of variability of the CO2 levels?
% Compute the mean and standard deviation of the CO2 levels?
% Plot a histogram of the CO2 levels.

nexttile
histogram(vco2);
title('Vostok Ice Core Distribution')
xlabel('CO2 (ppm)')
ylabel('# of years with associated CO2')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Download (or unzip) the Mauna Loa Atmopheric Sample Data Set
% Import them into Matlab using the Import Data function in the File Menu
% Restructure the data and save them in these arrays:
% myear  <1x557>   - year
% mmonth <1x557>   - month
% mtime  <1x557>   - time in years
% mco2   <1x557>   - co2 concentration in ppm
% M                - number of measurements
% save the results in a mat-file
% WARNING: THERE ARE MISSING DATA VALUES THAT YOU MUST DEAL WITH.
% Dont interpolate them, just omit them from the data array.
%
% These data are provided courtesy of:
% Atmospheric carbon dioxide record from Mauna Loa
% C.D. Keeling and T.P. Whorf
% Carbon Dioxide Research Group, Scripps Institution of Oceanography,
% University of California, La Jolla, California 92093-0444, U.S.A.

% Import the data into Matlab using the Import Data function in the 
% File Menu.  Restructure the data into two arrays as instructed above.
% Omit the missing data
myear = zeros(557,1);
mco2 = zeros(557,1);
row = 1;
i = 1;
j = 1;
for row = 1:48
    if maunaloaco2.Jan(row) ~= -99.99
        myear(i) = maunaloaco2.Year(row)+1/24;
        mco2(j) = maunaloaco2.Jan(row);
        j = j+1;
        i = i+1;
    end
    if maunaloaco2.Feb(row) ~= -99.99
        myear(i) = maunaloaco2.Year(row)+3/24;
        mco2(j) = maunaloaco2.Feb(row);
        j = j+1;
        i = i+1;
    end
    if maunaloaco2.March(row) ~= -99.99
        myear(i) = maunaloaco2.Year(row)+5/24;
        mco2(j) = maunaloaco2.March(row);
        j = j+1;
        i = i+1;
    end
    if maunaloaco2.April(row) ~= -99.99
        myear(i) = maunaloaco2.Year(row)+7/24;
        mco2(j) = maunaloaco2.April(row);
        j = j+1;
        i = i+1;
    end
    if maunaloaco2.May(row) ~= -99.99
        myear(i) = maunaloaco2.Year(row)+9/24;
        mco2(j) = maunaloaco2.May(row);
        j = j+1;
        i = i+1;
    end
    if maunaloaco2.June(row) ~= -99.99
        myear(i) = maunaloaco2.Year(row)+11/24;
        mco2(j) = maunaloaco2.June(row);
        j = j+1;
        i = i+1;
    end
    if maunaloaco2.July(row) ~= -99.99
        myear(i) = maunaloaco2.Year(row)+13/24;
        mco2(j) = maunaloaco2.July(row);
        j = j+1;
        i = i+1;
    end
    if maunaloaco2.Aug(row) ~= -99.99
        myear(i) = maunaloaco2.Year(row)+15/24;
        mco2(j) = maunaloaco2.Aug(row);
        j = j+1;
        i = i+1;
    end
    if maunaloaco2.Sept(row) ~= -99.99
        myear(i) = maunaloaco2.Year(row)+17/24;
        mco2(j) = maunaloaco2.Sept(row);
        j = j+1;
        i = i+1;
    end
    if maunaloaco2.Oct(row) ~= -99.99
        myear(i) = maunaloaco2.Year(row)+19/24;
        mco2(j) = maunaloaco2.Oct(row);
        j = j+1;
        i = i+1;
    end
    if maunaloaco2.Nov(row) ~= -99.99
        myear(i) = maunaloaco2.Year(row)+21/24;
        mco2(j) = maunaloaco2.Nov(row);
        j = j+1;
        i = i+1;
    end
    if maunaloaco2.Dec(row) ~= -99.99
        myear(i) = maunaloaco2.Year(row)+23/24;
        mco2(j) = maunaloaco2.Dec(row);
        j = j+1;
        i = i+1;
    end
    row = row+1;
end
nexttile
plot(myear, mco2);
title('Mauna Loa Measurements')
xlabel('Year (CE)')
ylabel('CO2 (ppm)')
% QUESTIONS TO DISCUSS IN YOUR REPORT
% -Plot the CO2 levels over modern times
% -Can you determine (roughly) the period of the oscillations?
% -What could cause this?



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Combine the two data sets by concatenating the arrays
% time  <1x920>   - time in years
% co2   <1x920>   - co2 concentration in ppm
% S = V + M       - number of measurements
% Remember that the Vostok data is in years before present, while the Mauna
% Loa data are real dates.

% Combine the two data sets
cyear = [vyear.', myear.'];
cco2 = [vco2.', mco2.'];

% Plot the CO2 levels over time
nexttile
plot(cyear, cco2)
title('CO2 Levels Before and After Industrialization')
xlabel('Year (CE)')
ylabel('CO2 (ppm)')

% QUESTIONS TO DISCUSS IN YOUR REPORT
% - What is the CO2 level in May 1986?
% - Given the calculated one standard deviation calculated using the Vostok ice core sample,
%   is it likely that this modern spike is just one of many natural fluctuations?
% - Can you estimate the probability that this modern spike is a natural fluctuation? (extra credit)
% - What is compelling about this analysis?
% - Why is this analysis insufficient?

