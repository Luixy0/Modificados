function [yg, yb]=mfRango(fmin,fmax,fx)
 

yb = trimf(fx,[fmin fmax inf]);
yg = trimf(fx,[-inf fmin fmax]);


%ya=(1/(1-Np))*(r-Np);
%yb=1-((r-Np)/(1-Np));
