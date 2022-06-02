function R = tsugeno(beta,beta1,Per,dim,xbest,xn,up,low,bestfit,worstfit,fInd)

    %dif = abs(fobj - fa);

    R4 = initialization(4,1,up,low); 
    for i = 1 : dim
        R(i,1) = beta * (xbest(i) + xn(i))*((fInd-bestfit)/(bestfit-worstfit)); 
        %R(i,2) = beta1 *(xbest(i) + xn(i));
        R(i,2) = (xbest(i) - xn(i))*beta1*((fInd-bestfit)/(bestfit-worstfit));
        %R(i,3) = Per * ((rand-0.5) * 2);
        R(i,3) =((fInd-bestfit)/(bestfit-worstfit))*((rand-0.5)*2)*Per;      
        %R(i,3) =abs(((bestfit-fInd)/(bestfit-worstfit)))*((rand-0.5)*2)*Per;      
        R(i,4) = R4(i);
    end
   
end

