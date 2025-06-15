N=100;
K=50;
f=2
y1=zeros(N,K); % Crea arreglo de ceros de k filas y N columnas
y2=zeros(N,K); % Crea arreglo de ceros de k filas y N columnas
y3=zeros(N,K); % Crea arreglo de ceros de k filas y N columnas
for K=2:2:K
    for n=0:N-1 % Para n que va de 0 a N-1
        y1(n+1,K)=((8/pi)*((-1)^((K-2)/2)))/((K-1)^2)*sin(2*(K-1)*pi*f*n/N); % Se guarda en y1 los valores IMPARES de la funcion Y1
        y2(n+1,K)=(4/pi)*(1/(K-1))*sin(2*(K-1)*pi*f*n/N); % Se guarda en y2 los valores IMPARES de la funcion Y2
        y3(n+1,K)=(-1/pi)*(1/(K-1))*sin(2*(K-1)*pi*f*n/N); % Se guarda en y3 los valores IMPARES de la funcion Y3
        y3(n+1,K-1)=(-1/pi)*(1/(K-2))*sin(2*(K-2)*pi*f*n/N); % Se guarda en y3 los valores PARES de la funcion Y3
    end % Fin del for
end
ytot=y1+y2+y3; %Suma total de las funciones y1,y2 y y3
hold all
plot(ytot(:,(5+1))) %Plot de la suma
legend('ytot');
title('Suma de 3 senoidales muestreadas');
xlabel('Tiempo');
ylabel('Amplitud');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NOTA: Se suman y se restan unos a las posiciones K, ya que el bucle for
%comienza en K=2, siendo este un k=1 segun la formula. Es por esto que por
%ejemplo en Y1, en vez de ser 2*k*pi*n/N, es 2*(K-1)*pi*n/N. De esta
%manera, para graficar el valor K=5, es necesario sumar uno, ya que k=5, es
%K=6 (segun el bucle). Para los valores pares de Y3, se aplica la misma
%lógica, solo que debe restarse uno.
