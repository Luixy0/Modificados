function X = findrange(X,low,up,dim,N)

if size(up,2)==1
    
    for j = 1 : N
        
        for i = 1:dim   
            if (X(j,i) < low) 
                X(j,i) = low;
            end
            if (X(j,i) > up)
                X(j,i) = up;
            end
        end
        
    end
    
end

if size(up,2) > 1
    
     for j = 1 : N
         
         for i = 1:dim
            high=up(i);down=low(i);
            if (X(j,i) < down)
                X(j,i) = down;
            end
            if (X(j,i) > high)
                X(j,i) = high;
            end
            
         end
         
     end
    
end
