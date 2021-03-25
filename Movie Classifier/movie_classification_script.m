% movie classification script
% Kevin H Knuth
% 27 Oct 2020
%
% At present,the classifier suggests that I will like ALL of the movies.
% I suspect that there are not enough examples of movies that I did not
% like.  The number of examples should be roughly equal to provide a good
% sample.
%

% Import Data
% data is stored as a cell array
% 25 rows (instances)
% column 1: movie name
% column 2: user rating (0-5 with blanks)
% column 3: rating (empty)
% column 4: action (1 or nothing)
% column 5: adventure
% column 6: animation
% column 7: comedy
% column 8: crime
% column 9: disaster
% column 10: documentary
% column 11: drama
% column 12: epic
% column 13: fantasy
% column 14: history
% column 15: horror
% column 16: musical
% column 17: mystery
% column 18: romance
% column 19: scifi
% column 20: sports
% column 21: thriller
% column 22: war
% column 23: western
% column 24: tomatometer (0-100)
% column 25: audience (0-100)

% Here we use the short_movie data set which has the following columns
% column 1: movie name
% column 2: has the movie been seen (0, 1)
% column 3: action
% column 4: fantasy
% column 5: romance
% column 6: scifi
% With this data, the classifier will be able to predict whether the user
% has or has not seen a given movie.

cd('C:\Users\Kevinator\kevin\albany\teaching\2020 Fall\Bayesian Data Analysis\movies');
load('moviev2_data.mat');

% get number of features
F = size(data,2)-2;

% approximate the prior probabilities from the data (training data)
% score (0, 1) --> index (1, 2)
p = zeros(1,2);
for i = 1:size(data,1)
    R = getRATING(i, data);
    p(R+1) = p(R+1) + 1;
end
p = p / sum(p);

% approximate the likelihoods
% p(x_i | y_i)
% 20 features X
% feature (absent, present) --> index (1, 2) x
% score (0, 1) --> index (1, 2) y
C = zeros(F,2,2); % (F features, absent/present, score (0,1))
for i = 1:size(data,1)
    R = getRATING(i, data);
    if (R >= 0) % if they have seen the movie and gave it a score
      % get feature vector
      X = getFeatureVECTOR(i, data);
      for j = 1:length(X)
          C(j,X(j)+1,R+1) = C(j,X(j)+1,R+1) + 1;
      end
    end
end

% add 1/2 to every count (to handle zero counts)
C = C + 0.5;


% try it
C(4,2,2) % number of scifi movies that were liked
C(4,2,1) % number of scifi movies that were NOT liked
C(4,1,2) % number of NON-scifi movies that were liked
C(4,1,1) % number of NON-scifi movies that were NOT liked

% generate likelihoods
% example:
% s = sum(C(16,1,:));
% L(16,1,1) = C(16,1,1)/ s;
% L(16,1,2) = C(16,1,2)/ s;

for f = 1:F    % loop over features
    for i = 1:2     % loop over absent/present
        s = sum(C(f,i,:));
        L(f,i,1) = C(f,i,1)/s;
        L(f,i,2) = C(f,i,2)/s;
    end
end

% try to predict 2001 space odyssey (movie #1)
% find p(y_j, X) = prod( p(x_i | y_i) p(y_j | I)/Z
% posterior Q
% Q(25 movies, like/dislike)

Q = zeros(size(data,1),2);
pL = zeros(size(data,1),2);
for m = 1:size(data,1)
    X = getFeatureVECTOR(m, data);
    % generate a product of likelihoods
    for R = 0:1 % preference
        pL(m,R+1) = 1;
        for f = 1:F    % loop over features
            pL(m,R+1) = L(f,X(f)+1,R+1) * pL(m,R+1);
        end
        % multiply by the appropriate prior
        % save in Q (posterior)
        Q(m,R+1) = p(R+1)*pL(m,R+1);
    end
    % normalize the probabilities
    s = Q(m,1) + Q(m,2);
    Q(m,1) = Q(m,1)/s;
    Q(m,2) = Q(m,2)/s;
end


% try it!
correct = 0;
for m = 1:size(data,1)
    if (Q(m,1) < Q(m,2))
        str = ': PREDICT YOU HAVE SEEN';
        predict = 1;
    else
        str = ': PREDICT YOU HAVE NOT SEEN';
        predict = 0;
    end
    
    movieNAME = data{m,1};
    if (predict == getRATING(m, data))
        cstr = ': CORRECT';
        correct = correct + 1;
    else
        cstr = ': INCORRECT';
    end
    moviestr = strcat(movieNAME, str, cstr, ' (p = ', num2str(Q(m,2)), ')' );
    fprintf('%s\n', moviestr);
end
correctstr = ['Percent Correct = ' num2str(correct/size(data,1)) '%'];
fprintf('%s\n', correctstr);
