%----- 6-3 ----- Filtro Peine (Comb Filter)

%*** 6-3-1 *** Crear un filtro peine con: K para que cada retardo individual equivalga a 10ms. 
%Calcular N de manera que el mayor retardo (para i=N) equivalga a un retraso total de 100ms. 
%Calcular el valor de 'a' para que cada versión retrasada de x[n] posea 3dB
%menos de potencia que la anterior.

[r,Fs,nbits]=wavread('numeros.wav'); %leemos el archivo de audio y obtenemos r,Fs,nbit

%-------- 10ms --------

K=0.01*Fs;      %cantidad de muestras que deben pasar para 10ms
N=10;           %Max retardo 100ms
a=sqrt(2)/2;    %la maxima amplitud debe ser -3dB (0.707) que la original

h1=zeros(1,N); %creamos vector de longitud N con ceros
h1(1)=1;
for i=1:N
    h1(i*K)=a^i;
end

%*** 6-3-2 *** Convolucionar la señal leída en el punto 6.2.1 con el filtro. Normalizar la amplitud de la señal para
%que el máximo valor sea menor que 1 y grabar el resultado con la función wavwrite.

y1=conv(h1,r);                          %aplicamos el filtro a r 
wavwrite(y1,Fs,nbits,'6_3_2_10ms.wav');

%graficamos el kernel
stem(h1); title('Kernel del filtro');  
%Abre Filter Visualization Tool, aca podremos ver la respuesta en frecuencia  del filtro.
fvtool(h1,1); 

%*** 6-3-3 *** Repetir los últimos dos puntos para retardos individuales de 20 y 30ms.

%-------- 20ms --------

K=0.02*Fs;  %cantidad de muestras que deben pasar para 10ms
N=5;           %Max retardo 100ms

h2=zeros(1,N); %creamos vector de longitud N con ceros
for i=1:N
    h2(i*K)=a^i;
end

y2=conv(h2,r);
wavwrite(y2,Fs,nbits,'6_3_2_20ms.wav');

%-------- 30ms --------

K=0.03*Fs;  %cantidad de muestras que deben pasar para 10ms
N=3;          %Max retardo 100ms

h3=zeros(1,N); %creamos vector de longitud N con ceros
for i=1:N
    h3(i*K)=a^i;
end

y3=conv(h3,r);
wavwrite(y3,Fs,nbits,'6_3_2_30ms.wav');


        