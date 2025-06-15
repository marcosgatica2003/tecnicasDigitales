%----- 6-2 ----- Convolución con filtro de retardo

%*** 6-2-1 *** Leer el archivo numeros.wav, disponible en autogestión, mediante la función wavread y guardar la
%señal resultante en una variable r. Obtener al mismo tiempo con esta función la frecuencia de
%muestreo y cantidad de bits del archivo wav. Utilizar la ayuda de ser necesario.

%La funcion wavread lee el archivo de audio numeros.wav y retorna
%r: muestras, Fs:frecuencia de muestreo y nbit: cantidad bits por muestra
[r,Fs,nbit]=wavread('numeros.wav');

% *** 6-2-2 *** Crear una señal h que consista en un impulso desplazado 300ms (0.3s) con respecto al origen
%h Seria nuestra respuesta al impulso del filtro o kernel

Ts=1/Fs;  %Período de muestreo la señal 
cantMuest=0.3/Ts; %cantidad de muestras que deben pasar hasta que transcurran 300ms
%cantMuest=0.3*Fs; %forma mas directa de hacer lo anterior
h=zeros(1,cantMuest); %creamos vector de longitud cantMuest con ceros
h(cantMuest+1)=1; %ponemos en la posicion cantMuest+1 del vector en 1

%graficamos el kernel
stem(h); 
title('Kernel del filtro');  

%Abre Filter Visualization Tool, aca podremos ver la respuesta en frecuencia del filtro.
fvtool(h,1); 

%*** 6-2-3 *** Convolucionar la señal r con la señal h para crear una señal l. Eliminar las ultimas muestras de
%la señal l de manera que las señales l y r tengan la misma longitud. 


l=conv(r,h); 

a=size(r); %obtenemos el tamaño del vector r
l(a(1)+1:end)=[]; %Elimina las muestras sobrantes de L.
y=[r,l]; %combinacion de la señal original y la retrazada (variacion de fase)
wavwrite(y,Fs,nbit,'audio_6-2.wav'); %generacion del nuevo archivo de audio.
