%Fuzzy Modificado%

F_index=7;

I=imread('lena.tif');
Iseg=imread('lena.tif');
hist=imhist(I);
[n,m] = size(I);
 hist = hist /(n * m);  



%PARAMETROS DEL ALGORITMO
%Numero de individuos
Np=50;
MaxGeneration=2000;
D=zeros(1,Np);
beta=1.4;%1.2, 1.48   1.4
beta1= 0.05;%0.05  
Per=0.005;%1.5;0.03;     0.005
Tun=1;%1.2  1



%%%%%%%%%%%%%% 
[low,up,dim]=test_functions_range(F_index);

%%%%%%%%%%%%%%
X = initialization(dim,Np,up,low); 
rango=up-low;
%dmax=14.14;
dmax= distMax(dim,up,low);
%modif h 
fitnessAUX=evaluateF(X,hist);
[Lightn,Index]=sort(fitnessAUX,'ascend');
xbest = X(Index(1),:);
fobj=Lightn(1);
fmax=Lightn(end);
%Y=fitnessAUX;

if dim<=2 
figure(3) %Gráfica de la población inicial
hold on
                            x=[low:rango/100:up];
                            y=x;
                            [xg,yg]=meshgrid(x,y);
                            [row,col]=size(xg);
                            for l=1:col
                                for h=1:row
                                    z(h,l)=evaluateF([xg(h,l),yg(h,l)], hist);%%%%%%%%%%%
                                    
                                    %z(h,l)=mifit([X(h,l),Y(h,l)],funcion);%Se calcula z para utilizarlo en el graficado
                                end
                            end
                            figure(1)
                            contour(xg,yg,z);
                            shading interp
plot(X(:,1),X(:,2),'o','markersize',6,'markerfacecolor','r');
plot(xbest(1,1),xbest(1,2),'o','markersize',10,'markerfacecolor','g');
                            figure(2)
                            surf(xg,yg,z);
                            alpha(0.5);
                            shading interp
                            hold off
                            
end
%%%%%%%%%%%%%%%Graficado%%%%%%%%%%%%%%%



i=1;
%Proceso de Evoluciclearon
while i<=MaxGeneration+1
 
    
%  Lb=low*ones(1,dim);
%  Ub=up*ones(1,dim);
%  X=get_cuckoos(X,xbest,Lb,Ub);
%  
%   fitnessAUX=evaluateF(X,F_index);
%     [Lightn,Index]=sort(fitnessAUX,'ascend');
%     
%     if (Lightn(1) < fobj)
%       xbest = X(Index(1),:);      
%       fobj=Lightn(1);
%     end
%     fmax=Lightn(end);
 
    
      
    for j=1:Np
       % Distancia y Rango
      D(j)=Eudistancia(xbest,X(j,:),dim);
      r=find(Index==j);
      %Funciones de membresia
      
      [yc, yl]=mfDistancia(D(j),dmax);    

      %[ya, yb] = mfRango(r,Np);
      [ya, yb]=mfRango(fobj,fmax,Lightn(r));
      %Reglas difusas
      w1=min(yc,yb);
      w2=min(yc,ya);
      w3=min(yl,ya);
      w4=min(yl,yb);
      %dc (j) = ya;
      %dl (j) = yb;
      %Consequente sugeno
	  %se quita fmax,evaluateF(X(j,:)
      R = tsugeno(beta,beta1,Per,dim,xbest,X(j,:),up,low,fobj,fmax,evaluateF(X(j,:), hist));
     
      for k = 1:dim
       Temp(1,k) = ((w1 * R(k,1) + w2 * R(k,2) + w3 * R(k,3) + w4 * R(k,4)) / (w1+w2+w3+w4))*Tun;
       %Temp(1,k) = ((w1 * R(k,4) + w2 * R(k,4) + w3 * R(k,4) + w4 * R(k,4)) / (w1+w2+w3+w4))*Tun;
        %X(j,k) = X(j,k) + (Temp(1,k));
        X2(1,k) = X(j,k) ;
      end
      fitnessAUX_2=evaluateF(X2(1,:) ,hist);
	 
	  % eliminar evaluateF(X(j,:)
      fitnessAUX = evaluateF(X(j,:),hist);
      
      if (fitnessAUX_2 < fitnessAUX)
         X(j,:) =X2(1,:);
      end
      
    end
    
    % X muto y se tiene que validar que todo X tenga sus rangos bien
    % definidos
    X = findrange(X,low,up,dim,Np);
    
    fitnessAUX=evaluateF(X,hist);
    [Lightn,Index]=sort(fitnessAUX,'ascend');
	%i = i+50;
    
    if (Lightn(1) < fobj)
      xbest = X(Index(1),:);      
      fobj=Lightn(1);
    end
    fmax=Lightn(end);
    fit(i,:)=fobj;
    if dim<=2 
% f=vectorize(inline(funcion));

figure(1) %Gráfica de la población actual

                            
                            x1=[low:rango/100:up];
                            y1=x1;
                            [X1,Y1]=meshgrid(x1,y1);
%                             zz=f(X1,Y1);
                            [row1,col1]=size(X1);
                            for q=1:col1
                                for hh=1:row1
                                    zz(hh,q)=evaluateF([X1(hh,q),Y1(hh,q)], hist);
                                    %zz(hh,q)=mifit([X1(hh,q),Y1(hh,q)],funcion);%Se calcula z para utilizarlo en el graficado
                                end
                            end
                            contour(X1,Y1,zz,15);
                            hold on
                            %shading interp
plot(X(:,1),X(:,2),'o','markersize',6,'markerfacecolor','r');
plot(xbest(1,1),xbest(1,2),'o','markersize',10,'markerfacecolor','g');
                            drawnow;
                            hold off
    end
  i = i+1;
end
xbest=fix(sort(xbest));

imgOut=imageGRAY2(Iseg,xbest); %Coloca los valores 0 y 255 a los extremos de los umbrales obtenidos, usar preferentemente
% imgOut=imageGRAY(Iseg,xbest); % No coloca los valores de 0 y 255
imshow(imgOut);

figure(4)
hold on;
imhist(Iseg,400);
imhist(imgOut,600);
hold off;
    


