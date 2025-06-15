function X=mi_fft(m)

%m=[0,1,2,3,4,5,6,7]; %muestras
N=length (m);
x=zeros(1,N/2);
z=log2(N);
for a=0:((N/2))-1
    
x(a+1)=-1i*((2*pi*a)/N); %vector de indice del exponencial de los factores de giro (son los cuatro primeros)

end

   
F=exp(x); %hace un vector con los factores de giro

X = bitrevorder(m); %separa par e impar
A=fft(m);
%function Q=mi_butterfly(,B,);

%for step=2.^(0:log2(N/2))
 %   for j=0:step-1
  %   for i=1:step*2:N-j
        % [X(i+j),X(i+j+step)];
   %      [X(i+j),X(i+j+step)]=mi_butterfly(X(i+j),X(i+j+step),F(j*(N/2)/step+1));
        
        
%end
%end
%end

tic  

for p=0:z-1
    step=0;
    cont=0;
    cont2=0;
    Fgiro=1;
    for q=1:N/2
        cont2=cont2+1;
        [X(q+step),X(q+2^p+step)]=mi_butterfly(X(q+step),X(q+2^p+step),F(Fgiro));
        Fgiro=Fgiro+N/(2*(2^p));
        if cont2>=2^p
            cont=cont+1;
            step=(2^p)*cont;
            Fgiro=1;
            cont2=0;
        end
    end
end   
toc
  

end




