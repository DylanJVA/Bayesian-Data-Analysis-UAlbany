function X = getFeatureVECTOR(row, data)
% getFeatureVECTOR is a function that recovers the a movie's feature vector 
% indicated by the row number of the movie data set
% Usage:
%   Y = getFeatureVECTOR(row, data)
%
% row : row number of a movie in the data set
% data : movie data set in a cell array with N rows and F+2 columns where
% F is the number of featyre vectors
% X : 1 x F feature vector
%
F = size(data,2)-2; % the number of features is assumed to be the number of columns minus 2.

    X = zeros(1,F);
    for i = 3:size(data,2)
        x = data{row,i};
        if (isstring(x))    % this handles empty cells (filled with null strings)
            X(i-2) = 0;
        else
            X(i-2) = 1;
        end
    end
end
