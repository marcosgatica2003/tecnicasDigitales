N=50;
K=3;
legendInfo=[ 'K = 1'];
y1=zeros(N,1); % Crea arreglo de 1 fila y N columnas
y=zeros(100,K); % Crea arreglo de k filas y 100 columnas
for n=0:(N-1) % Para n que va de 0 a N-1
    if n<N/2 % Si n es menor a N/2
        y1(n+1)=n/(N/2); % Se guarda n/(N/2) en la posición n+1
    else % Si no
        y1(n+1)=(N-n)/(N/2); % Se guarda (N-n)/(N/2) en pos. n+1
    end % Fin del if
end % Fin del for
stem(y1)
legend ('50 Muestras')
xlabel ('Numero de muestras')
ylabel ('Amplitud')
figure();
for K=0:(K-1)
    for n=0:99 % Para n que va de 0 a 99
        if n<50 % Si n es menor a 50
            y(n+1,K+1)=(K+1)*(n/50); % Se guarda n/50 en la posición n+1
        else % Si no
            y(n+1,K+1)=(K+1)*((100-n)/50); % Se guarda (100-n)/50 en pos. n+1
        end % Fin del if
    end % Fin del for
    hold all
    stem(y(:,K+1))
    legendInfo = strvcat(legendInfo,[ 'K = ',num2str(K+2)]);
end
legend (legendInfo);
xlabel ('Numero de muestras')
ylabel ('Amplitud')
