%*** 8-1 *** Implementación y respuesta en frecuencia de un filtro IIR

%*** 8.1.1*** Crear un programa que calcule la salida de un filtro IIR de orden N, tomando como referencia el
% ejercicio 6.1, donde se debe agregar un segundo registro de desplazamiento para las muestras de
% salida a multiplicar por los coeficientes A. Luego se sumarán las sumas de productos de ambas
% estructuras (Coeficientes a y b).

% *** 8.1.2*** Asumiendo una frecuencia de muestreo de 256 Hz, crear una señal compuesta por la suma de dos
% tonos senoidales, de 50 y 100Hz, con una duración de 8 segundos. Filtrar la señal con el programa
% del punto 8.1.1 con los siguientes coeficientes:
% B = [0.0528556 0.0017905 0.0017905 0.0528556]
% A = [1.00000 2.12984 1.78256 0.54343]
% y determinar a partir del espectro de la señal de salida la amplitud de ambos tonos.

N=4;    %tamaño del vector de coeficientes de entrada

fs=256;   % frecuencia de muestreo
F1=50;    % frecuencia del tono senoidal 1
F2=100;   % frecuencia del tono senoidal 2

K=2000;                %cantidad de muestras
x=(0:(K/2-1))*fs/K;    %frecuencias digitales

%convertimos F1 y F2 a frecuencias digitales
f1=F1*2/fs;     
f2=F2*2/fs;

t=fs*8;          %cantidad de muestras para 8 seg

%Coeficientes del filtro
A=[1 -2.12984 1.78256 -0.54343 0.0];
B=[0.0528556 0.0017905 0.0017905 0.0528556];
     
%generamos señal senoidal de 50 hz
s1=zeros(1,t);
for i=1:t               
    s1(i)=sin(pi*f1*(i));
end

%generamos señal senoidal de 100 hz
s2=zeros(1,t); 
for i=1:t              
    s2(i)=sin(pi*f2*(i));1
end

%la señal a filtrar es la suma de s1+s2
s=s1+s2;     

%tamaño de la señal de entradas
L=length(s1);

%hacemos la tranformada de fourier de s 
S=mag2db(abs(fft(s,K)));

%Graficamos el espectro de frecuancias de la señal de entrada
figure
plot(x,S(1:K/2));    
title('señal de entrada');
 xlabel('Frecuencia[Hz]');
ylabel('Amplitud[dB]');
    
% -------- Aplico el filtro por convolución --------

y=zeros(1,N+L-1);      %salida
s=[s zeros(1,N)];      %concateno la entrada para que tenga dimensión L+N, igual que la salida

%Creo los shift register con los que voy a trabajar
sr_in=zeros(1,N);
sr_out=zeros(1,N);

for n=1:N+L-1
    sr_in=[s(1,n) sr_in(1:N-1)];   %actualizo el sr, concatenando el elemento actual de la entrada
                                   %con los primeros N-1 elementos que tenia guardados en el sr.
    for i=1:N
        y(n)= y(n) + sr_in(i)*B(i) - sr_out(i)*A(i+1);   %este es el algoritmo del filtro IRR
                                                         %notar que A esta desplazado un lugar a la derecha                                                                  
    end
    sr_out=[y(1,n) sr_out(1:N-1)]; %actualizo el sr, concatenando el elemento actual de la salida
                                   %con los primeros N-1 elementos que tenia guardados en el sr.
end

Y=fft(y,K);
y1=20*log10(abs(Y(1:K/2)));

%Medición de amplitud
x_50=find(x>=50);
y_50=y1(x_50(1));
x_100=find(x>=100);
y_100=y1(x_100(1));

%graficamos
figure;
   plot(x,y1);
   title({'Espectro de la señal filtrada con convolucion',strcat('Amplitud a 50[Hz]=',num2str(y_50)), strcat('Amplitud a 100[Hz]=',num2str(y_100))});
   xlabel('Frecuencia[Hz]');
   ylabel('Amplitud[dB]');

% *** 8-1-3 *** Filtrar la misma señal utilizando la función filter. Graficar la salida sobre la salida del punto
% anterior y comprobar que ambas señales son iguales.

%Filtro con función filter
y_filter=filter(B,A,s);
Y_filter=fft(y_filter,K);

figure;
plot(x,20*log10(abs(Y_filter(1:K/2))));
title('Espectro de la señal filtrada con filter');
xlabel('Frecuencia[Hz]');
ylabel('Amplitud[dB]');

   
% *** 8-1-4 *** Utilizando [N,w]=freqz(B,A) obtener la respuesta en frecuencia del filtro y graficar
% magnitud en dB y la frecuencia en Hz. Determinar valores de magnitud en 50Hz y 100Hz y
% exhibirlos sobre el gráfico usando la función text.

[H,w_rad]=freqz(B,A);       %freqz regresa la respuesta en frec de modulo y fase
w_hz=(w_rad/pi)*(fs/2);     %la función anterior regresa w en rad/muestras
H_dB=20*log10(abs(H));

figure(4);
    plot(w_hz,H_dB);
    title('Respuesta en frecuencia del filtro');
    xlabel('Frecuencia[Hz]');
    ylabel('Amplitud[dB]');


