function R = getRATING(row, data)
% getRATING is a function that recovers the user rating of the 
% movie indicated by the row number of the movie data set.
% Usage:
%   R = getRATING(row, data)
%
% row : row number of a movie in the data set
% data : movie data set in a cell array with N rows and multiple columns
% R : user rating for the movie (assumed to be in column 2)
%
    r = data{row,2};
    if (isstring(r)) % test if r is a string (empty) or an integer
%         R = -1;
        R = 0;
    else
        R = double(r);
%        x = double(r);
%         if (x < 3)
%             R = 0;  % if the rating is less than 3 (do not like)
%         else
%             R = 1;  % otherwise (like)
%         end
    end
end
