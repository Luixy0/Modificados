function dmax= distMax( dim,up,low)

sum = 0;

if size(up,2)==1
        for i = 1:dim   %%%%%%%%%% Solo 1 vez?
            sum = sum + ((up-low) ^ 2);
        end
end

if size(up,2) > 1
         for i = 1:dim
            sum = sum + (up(i)-low(i) ^ 2);    
         end
           
end

dmax = sqrt(sum);



