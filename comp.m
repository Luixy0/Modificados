function t = comp()

load('t0.mat');

tic;
  [xbest,fobj] = fuzzyL2(20);
t1 = toc;


for i = 1:5
tic;    
  [xbest,fobj] = fuzzyL2(20);
t2(i) = toc;
end
t2Mean = mean(t2);


t = (t2Mean - t1)/t0;


end

