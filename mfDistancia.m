function [yc yl]=mfDistancia(d,dmax)
if (d>dmax)
    d=dmax;
end

yc=(dmax-d)/dmax;
yl=((d-dmax)/dmax)+1;