k=9;
theta=.5;
x=1:0.01:20;

p = zeros(length(x),1);
pgauss = zeros(length(x),1);
i = 1;
for xi = x
    p(i) = (gamma(k)*theta^k)^(-1)*xi^(k-1)*exp(-1*xi/theta);
    pgauss(i) = (gamma(k)*theta^k)^(-1)*4^(k-1)*exp(-4/theta)*exp(-1*(xi-4)^2/4);
    
    i = i + 1;
end
plot(x,p,x,pgauss);
legend("P(x) using original pdf","P(x) using gaussian distribution");