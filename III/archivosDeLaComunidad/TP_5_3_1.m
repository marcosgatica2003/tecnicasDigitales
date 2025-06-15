% ****** 5.3 ****** Matrices de señales
 
%****** 5.3.1 ****** Utilizando los elementos de los ejercicios 5.1 y 5.2, crear tres matrices Y1,Y2 e Y3 con N filas y K
% columnas, donde cada elemento se obtiene de acuerdo a las siguientes fórmulas.

N=100;
K=100;
Y1=zeros(N,K);
Y2=zeros(N,K);
Y3=zeros(N,K);
for n=0:N 
  
    
for k=0:K
    Y3(n+1,k+1)=(-1)*(1/(pi*k))*sin((2*k*pi*n)/N);
    if ((-1)^(k) > 0)
        Y1(n+1,k+1)=0;
        Y2(n+1,k+1)=0;
    else
        Y1(n+1,k+1)=(8/pi)*(((-1)^((k-1)/2))/k^2)*sin((2*k*pi*n)/N);
        Y2(n+1,k+1)=(4/(pi*k))*sin((2*k*pi*n)/N);
    end
end

end


plot(Y1);
figure;
plot(Y2);
figure;
plot(Y3);
