%*** 7-2 *** Obtención de filtro pasa-altos a partir de filtro pasa bajos

% *** 7-2-1 *** Método de inversión de espectro: Obtener la respuesta al impulso del siguiente diagrama,
% utilizando el filtro normalizado y el valor de retardo obtenidos en el ejercicio anterior.


h=load('filtro.dat');   %leemos el kernel (respuesta al impulso) del filtro PB
K=100;                  %cantidad de muestras
x=(0:K/2-1)*2/K;        %frecuencia digital. Va desde 0 hasta  0.98. x= 0, 1*2/k, 2*2/k, 3*2/k,..., 49*2/k
                        %para pasar de frec. digital a real multiplicamos por Fs
H=fft(h,K);             %tranformada de fourier del filtro PB

%Del grafico obtenemos y[n] = x[n]*del[n] - x[n]*h[n] = x[n]*(del[n] - h[n]) 
%el kernel del nuevo filtro PA (h_pa) es la resta de del[n] - h[n] donde 
% del[n] es un impulso retardado 10 muestras (ver 7-1) y h[n] es el kernel del filtro PB
%normalizado (lo pide el enunciado)

% La motivación de inversión espectral proviene de observar que la resta entre
% la señal original y la señal filtrada pasabajos, contiene solo los componentes
% altos de frecuencia. Por lo tanto, el procedimiento equivale a un filtro pasa alto.
% La frecuencia de corte del pasa-altos es la misma que la del pasa-bajos
% original. El filtro pasa bajos debe ser de fase nula o lineal. Eso se
% logra haciendo que la respuesta al impulso sea simétrica.

%normalizamos el kernel del filtro PB 
hn=h/abs(H(1));

%retardo
del=zeros(size(h));
del(10)=1; 

% kernel del filtro PA
h_pa=del-hn;

% *** 7-2-2 *** Obtener la respuesta en frecuencia de la nueva respuesta al impulso y repetir las gráficas 
% del punto 7.1.4

% Respuesta en frecuencia
H_PA=fft(h_pa,K);
PAdb=20*log(abs(H_PA(1:K/2)));    %sacamos valor absoluto de H_PA y pasamos a db 
Hdb=20*log(abs(H(1:(K/2))/H(1))); %normalizamos, sacamos valor absoluto de H y pasamos a db 

%graficamos
figure;
plot(x,Hdb(1:K/2), x,PAdb(1:K/2));
legend('Filtro PB','Filtro PA');
title('Inversión del espectro');

% *** 7-2-3 *** Método de reversión de espectro: Se logra multiplicando los coeficientes del filtro por una
% secuencia de 1 y -1 alternados. hpa[n]=(-1)^n h[n] dicho de otro modo, se cambia el signo de todas las muestras
% impares. Esto revierte el espectro resultante, obteniendo un filtro pasa altos con distinta frecuencia de corte.
% Aplicar reversión de espectro al filtro pasa bajos y graficar respuesta en frecuencia original y
% modificada.

hpa=zeros(length(h));
for n=1:length(h)
   hpa(n)=(-1)^(n)*h(n);
end

Hpa=fft(hpa,K);
PBdb=20*log(abs(H(1:K/2)));
PAdb=20*log(abs(Hpa(1:K/2)));

figure
plot(x,PBdb, x,PAdb)
legend('Filtro PB','Filtro PA');
title('Reversión del espectro');









