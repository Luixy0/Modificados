function d=Eudistancia(xbest,xn,dim)

sum = 0;

for i = 1 : dim
    sum = sum  + ((xn(i) - xbest(i))^ 2); 
end

d = sqrt(sum);
