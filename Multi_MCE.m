% this program computes the minimum cross entropy for an image based in
% some threshold values.
% 
% close all
% clear all
% 
% I = imread('lena.tif');
 %h = imhist(I);
 %T = [117];

%h ->histogram
%T -> Thresholds
%I -> Gray Scale Image


function [Dt] = Multi_MCE(L,h)

t=round(L);
T=sort (t);
%T=L;
%normalize the histogram ==>  hn(k)=h(k)/(n*m) ==> k  in [1 256]
%[n,m] = size(I);
 %hn = h /(n * m);
hn=h;

% %Daga
% f2=sum(T(:) == 0);
% f2=length(T)-f2;
%compute miu values
for ii = 1:length(T) + 1
    m1 = 0;
    m2 = 0;
    if ii == 1
        v1 = 1;
        v2 = T(ii) - 1;
    elseif ii == (length(T) + 1) % Original:elseif ii == (length(T) + 1)
        v1 = T(ii-1);
        v2 = 256;
    else
        v1 = T(ii-1);
        v2 = T(ii)-1;
    end
               
    for i = v1:v2  % miu from 1 to tn
        m1 = m1 + (i * hn(i));
        m2 = m2 + hn(i);
    end

    if m2 == 0
        miu(ii)= m1 / (m2+eps);
    else
        miu(ii)= m1 / m2;
    end
    
    %compute each entropy according the thresholds
    Entro = double(0);
    for i = v1:v2 
        if miu(ii) == 0
            Entro = double(Entro + (i * hn(i) * log(miu(ii) + eps)));
        else
            Entro = double(Entro + (i * hn(i) * log(miu(ii))));
        end
    end
    Entropy(ii) = Entro;    
    
end

% entropy of gray level image   1-> L  (L = 256)
imEntropy = double(0);
for i = 1:256
    imEntropy = double(imEntropy + (i * hn(i) * log(i)));
end

%Compute the summatory Dt = entropy of image - entropy1 - entropy2...
Entemp =0;
for i =1: length(Entropy)
 %    if i == 1
  %       Dt = Dt + imEntropy - Entropy(i);
   %  else
    %     Dt = Dt - Entropy(i);
    % end

    Entemp = Entemp + Entropy(i);
end

Dt = imEntropy - Entemp;

%Dt=1/Dt;

end



