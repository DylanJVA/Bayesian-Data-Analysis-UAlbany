
% Numeric Integration
% Kevin H Knuth
% 10 Nov 2020
% Bayesian Data Analysis

mu = 10;
sigma = 2;
prob = @(x)((sqrt(2*pi*sigma^2))^(-1) * exp( (-1/(2*sigma^2)) .* (x - mu).^2) );

% plot the pdf
x = 0:0.1:20;
y = prob(x);
figure; plot(x,y);
hold on;

% select discrete set of points
% here equally spaced
N = 10;     % number of samples
R = 20;     % define the range
clear x;
clear s;
clear p;
s = 0:(R+1)/N:R;
p = prob(s);

w = (s(end)-s(1))/(numel(s)-1);
for i = 1:numel(s)
    % plot samples s and their probabilities p
    plot(s,p,'*');
    xL = s(i)-w/2;  % x Left
    yB = 0;         % y Bottom
    xR = xL+w;      % x Right
    yT = p(i);      % y Top
    v = [xL yB; xL yT; xR yT; xR yB];   % vertices
    f = [1, 2, 3, 4];                   % faces
    patch('Faces',f,'Vertices',v,'FaceColor','blue','FaceAlpha',.3);
end

% find the area under the curve (integrate)
area = sum(w*p);
disp(['area = ' num2str(area)]);
disp(['area - 1 = ' num2str(area-1)]);


% stochastic integration

% plot the pdf
x = 0:0.1:20;
y = prob(x);
figure; plot(x,y);
hold on;

% select discrete set of points
% selected from a uniform distribution U = [0,20];
N = 20;     % number of samples
R = 20;     % define the range
clear x;
clear s;
clear p;
s = R*rand(1,N);
p = prob(s);

w = R/N;
for i = 1:numel(s)
    % plot samples s and their probabilities p
    plot(s,p,'*');
    xL = s(i)-w/2;  % x Left
    yB = 0;         % y Bottom
    xR = xL+w;      % x Right
    yT = p(i);      % y Top
    v = [xL yB; xL yT; xR yT; xR yB];   % vertices
    f = [1, 2, 3, 4];                   % faces
    patch('Faces',f,'Vertices',v,'FaceColor','blue','FaceAlpha',.3);
end

% find the area under the curve (integrate)
area = sum(w*p);
disp(['area = ' num2str(area)]);
disp(['area - 1 = ' num2str(area-1)]);

