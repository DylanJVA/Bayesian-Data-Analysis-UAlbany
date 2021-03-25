% Metropolis-Hastings MCMC Code
% Bayesian Data Analysis
% PHY/CSI/INF 451/551
% 3 Nov 2020
% Kevin H Knuth


% define a pdf to explore
% this one is the sum of two gaussians
A1 = 1;
A2 = 1;
mu1 = 10;
mu2 = 0;
sigma1 = 2;
sigma2 = 3;
prob = @(x)(A1*(sqrt(2*pi*sigma1))^(-1) * exp( (-1/(2*sigma1^2)) .* (x - mu1).^2)   +  A2*(sqrt(2*pi*sigma2))^(-1) * exp( (-1/(2*sigma2^2)) .* (x - mu2).^2));

% plot the pdf
x = -10:0.1:20;
y = prob(x);
figure;
plot(x,y);

% metropolis hastings markov chain monte carlo (mcmc)
range = 50;
step = range*10;
x(1) = range*randn;
px = prob(x(1));
for i = 1:50000
    y = x(i) + step*randn;
    py = prob(y);
    
    p = min([1, py/px]);
    r = rand;
    
    if (r < p)
        x(i+1) = y;  % accept proposal y
    else
        x(i+1) = x(i); % reject proposal y
    end
    px = prob(x(i+1));
end

% collect samples (throw away BURN IN)
s = x(10000:end);

% look at the mean and standard deviations
% (which are not always so helpful in bi-modal pdfs)
smean = mean(s)
sstd = sqrt(var(s))



    
    