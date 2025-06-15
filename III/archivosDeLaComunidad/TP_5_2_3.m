% ***** 5.2.3 ****** Modificar el programa anterior para generar N muestras en lugar de 100 y graficar la se�al y para
% N=50 utilizando la funci�n stem(y).

muestras=80;
y=zeros(muestras,1);
for n=0:muestras-1
    if n<50
        y(n+1)=n/(muestras/2);
    else
        y(n+1)=(muestras-n)/(muestras/2);
    end
end
stem(y);