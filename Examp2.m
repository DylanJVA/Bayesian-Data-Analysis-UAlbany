
[x,y] = meshgrid(0:1000);
c = 5;
d = 5;
pxy = zeros(length(x),1);
px = zeros(length(x),1);
pxy = -100*(y-x.^2)^2-(1-x)^2;
px = -(100*d^2+300*x.^4+3*x.^2-6*x+3)/(2*c*(60*c^4+c^2+100*d^2+3));

tiledlayout(2,1)
nexttile
surf(x,y,pxy);
nexttile
plot(x,px)