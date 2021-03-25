%Dylan VanAllen
%Plot myCOSINE and cos functions and compare
x = 0:0.01:2*pi;
myCOS = zeros(length(x),1);
diff = zeros(length(x),1);
matlabCOS = cos(x);
n = 1;
for(element = x)
    myCOS(n) = myCOSINE(element);%Populate a vector with values from myCOSINE
    diff(n) = abs(myCOSINE(element)-matlabCOS(n));%Populate a vector with differences at each x between myCOSINE and cos
    n = n + 1;
end
tiledlayout(2,1);
nexttile;
p1 = plot(x,cos(x),x,myCOS); %my cosine will cover matlab's cosine if it is good enough
p1(1).Color = 'red';
p1(2).Color = 'blue';
title("myCOSINE(x) and cos(x) vs x");
legend('cos(x)','myCOSINE(x)')
nexttile;
p2 = plot(x, diff);
title("|myCOSINE(x)-cos(x)| vs x");
