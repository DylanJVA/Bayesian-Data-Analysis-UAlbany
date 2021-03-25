function prob = probMCircles(M,A,N,R,K)
    prob = factorial(N)/(factorial(M)*factorial(N-M))*(pi*R^2*K/A)^M*(1-(pi*R^2*K/A))^(N-M);
return