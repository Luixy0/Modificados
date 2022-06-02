% This function calculates the value of the objective function.
function fit=test_functions(L,h)

% %Displaced fitness function f01
%up = ones(1,dim) .* up;
%L = up - L;
%fit=sum(L.^2);

fit=Multi_MCE(L,h);



