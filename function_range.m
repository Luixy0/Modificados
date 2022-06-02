function [ya, yb] = function_range( fobj,Lightn )

ya=(fobj-Lightn)/fobj;
yb=((Lightn-fobj)/fobj)+1;


%ya=(1/(1-fobj))*(Lightn-fobj);
%yb=1-((Lightn-fobj)/(1-fobj));


end

