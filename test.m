function [particulas, fobj2] = test()


% parfor j=1:30
%     for i=1:13
%         [xbest,fobj] = fuzzyL (i,50,1000);
%         fobj2(j,i) = fobj;
%         particulas(j,i,:) = xbest;
%         sprintf('Func: %d',i)
%     end
%     sprintf('Iter: %d',i)
% end

parfor j=1:30
    for i=1:19
        [xbest,fobj] = fuzzyL (i);
        fobj2(j,i) = fobj;
        particulas(j,i,:) = xbest;
        sprintf('Func: %d',i)
    end
     sprintf('Iter: %d',i)
end

end

