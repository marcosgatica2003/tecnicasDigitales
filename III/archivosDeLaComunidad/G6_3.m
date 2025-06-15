[x, Fs, nbits] = wavread('numeros.wav');    %Lectura del archivo
Ts = 1/Fs;                                  %Periodo de muestreo
Ts_ms = Ts*1000;                            %Periodo de muestro en mS

K = 10 / Ts_ms;                 %Nro de muestras para 10mS
N = 100/(K*Ts_ms);              %Mayor retardo (para i=N) equivale a un retraso total de 100ms.
a = 10^((-3*i)/20);             %Valor para -3dB de potencia que la muestra anterior

tam_x = size(x);                %Obtencion del tamaño del audio
tam_h = (N*K);                  %Tamaño de h = cant de muestras para 100mS
h = zeros(tam_h,1);             %Inicializacion del kernel

h(1)=1;                                 %Impulso en h(1)
for i = 1:N
        h(i*K) = (10^((-3*i)/20));      %Valor para -3dB de potencia que la muestra anterior   
end

l = conv(h,x);          %Convolucion
l = l/max(abs(l));      %Normalizacion
sound(l, Fs, nbits)     %Reproduccion de sonido