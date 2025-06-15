[r, Fs, nbits] = wavread('numeros.wav');    %Lectura del archivo
tam_r = size(r);                %Obtencion del tamaño del audio
Ts = 1/Fs;                      %Periodo de muestreo
Ts_ms = Ts*1000;                %Periodo de muestro en mS

Pulsos_retardo = 300 / Ts_ms;   %Long del vector para pulso en 300mS
tam_h = Pulsos_retardo;         %Long del kernel
h = zeros(tam_h,1);             %Inicializacion del kernel
h(Pulsos_retardo) = 1;          %Impulso en t=300mS

l = conv(h,r);                  %Convolucion
tam_l = size(l);                %Obtencion del tamaño de la salida de conv
l(tam_r+1:tam_l)=[];            %Elimina las ultimas muestras para long_l = long_r

hold all
plot(r);
plot(l);
