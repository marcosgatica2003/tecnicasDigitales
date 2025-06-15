%****** 5.2.4 ****** Agregar otro bucle FOR que contenga al bucle presente en el punto 5.2.2, con indice k, y rango de
% 1 a K que permita generar K señales iguales a la señal y del punto 5.2.2, pero cada una con
% amplitud k. Cada señal deberá guardarse en una columna distinta de la matriz y, que se inicializará
% utilizando y=zeros(N,K);. Graficar las señales utilizando stem(y);

muestras=100;
K=100;
y=zeros(muestras,K);
for k=1:K

for n=0:muestras-1
    if n<50
        y(n+1,k)=k*(n/50);
    else
        y(n+1,k)=k*((muestras-n)/50);
    end
end

end
stem(y);

