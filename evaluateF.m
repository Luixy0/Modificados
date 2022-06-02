function   [fitness]=evaluateF(X,h)
[N,~]=size(X);

for i=1:N 
    L=X(i,:); 
    fitness(i)=test_functions(L,h);
end