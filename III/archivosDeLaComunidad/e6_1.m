%Guia 6, Ejercicio 1


%PUNTO 1.1 creacion de un FIR rechaza banda
fs = 39065.5; %frecuencia de muestreo X(puse 44,1KHz como ejemplo), igual a la utilizada en configuracion del ADC de la Guia 5
f_c = 3000; %frecuencia de interferencia 3KHz
AB = 200; %la banda de rechazo la hago de 200Hz, osea fc+-200
f_i = f_c - AB/2; %frecuencia inferior
f_s = f_c + AB/2; %frecuencia superior

%formo las frecuencias digitales
f_id = f_i/(fs/2);
f_cd = f_c/(fs/2);
f_sd = f_s/(fs/2);


Fpb = [0, f_id, f_sd, 1]; %defino los tramos de frecuencias del filtro
Apb = [1,    1,    0, 0]; %defino las amplitudes en los tramos de frecuencias

Fpa = [0, f_id, f_sd, 1]; %defino los tramos de frecuencias del filtro
Apa = [0,    0,    1, 1]; %defino las amplitudes en los tramos de frecuencias

taps = 100; %defino el numero de taps del kernel del filtro

%determino los coeficientes mediante algoritmo Remez(o Equirripple) ya que utiliza menos taps para igual definicion de filtro que el LMS
%h_pb = firpm(taps, Fpb, Apb); %filtro pasa bajos
%h_pa = firpm(taps, Fpa, Apa); %filtro pasa altos

%determino los coeficientes mediante algoritmo LMS
h_pb = firls(taps, Fpb, Apb); %filtro pasa bajos
h_pa = firls(taps, Fpa, Apa); %filtro pasa altos

h_eb = h_pb - h_pa; %se forma el filtro elimina banda con las respuestas del pasa bajo y el pasa alto

%grafico la respuesta en frecuencia de los filtros
N = fs*10; %muestras a emplear en la FFT
Hpb = fft(h_pb, N); %realizo la FFT del filtro pasa bajo
Hpa = fft(h_pa, N); %realizo la FFT del filtro pasa alto
Heb = fft(h_eb, N); %realizo la FFT del filtro elimina banda

Amp_Hpb = mag2db(abs(Hpb)); %convierto los valores de magnitud a valores en dB
Amp_Hpa = mag2db(abs(Hpa)); %convierto los valores de magnitud a valores en dB
Amp_Heb = mag2db(abs(Heb)); %convierto los valores de magnitud a valores en dB

x = [0 : (N/2)-1]; %creo un vector auxiliar que me permite crear luego los valores de frecuencias digitales
fd = x / ((N/2)-1); %vector con valores de frecuencias digitales

figure()
plot(fd, Amp_Hpb(1 : (N/2))) %grafico la respuesta del filtro pasa bajo
grid on
xlabel('Frecuencia digital.')
ylabel('Amplitud [dB]')
title('PUNTO 1.1. Espectro de filtro pasa bajo.')
legend('Espectro pasa bajo.')

figure()
plot(fd, Amp_Hpa(1 : (N/2))) %grafico la respuesta del filtro pasa alto
grid on
xlabel('Frecuencia digital.')
ylabel('Amplitud [dB]')
title('PUNTO 1.1. Espectro de filtro pasa alto.')
legend('Espectro pasa alto.')

figure()
plot(fd, Amp_Heb(1 : (N/2))) %grafico la respuesta del filtro elimina banda
grid on
xlabel('Frecuencia digital.')
ylabel('Amplitud [dB]')
title('PUNTO 1.1. Espectro de filtro elimina banda.')
legend('Espectro elimina banda.')

figure()
plot(fd*(fs/2), Amp_Heb(1 : (N/2))) %grafico la respuesta del filtro elimina banda en Hz
grid on
xlim([0 fs/2])
xlabel('Frecuencia [Hz].')
ylabel('Amplitud [dB]')
title('PUNTO 1.1. Espectro de filtro elimina banda.')
legend('Espectro elimina banda.')


%Los coeficientes del filtro elimina banda obtenido, deben cuantizarse con definición S16.15
%la funcion fi(v, s, w, f) devuelve el punto-fijo de un objeto con valor "v", con valor de signo "s",
%longitud de la palabra "w" y longitud de la parte fraccional "f".

h_eb_fx = fi(h_eb, 1, 16, 15); %convierto el kernel h_eb(en dominio del tiempo) a formato S16.15
%ello significa que a los coeficientes de h_eb, tendran 1 bit de signo, 16 bits en total y 15 de parte fraccionaria


tam = length(h_eb_fx); %determino el tamaño del kernel obtenido en formato S16.15
s = zeros(1, tam);
s=[];
for n = 1 : tam
	temp = h_eb_fx(n);
	s = [ s ',0x' temp.hex];
	%s(n) = ['0x' h_eb_fx.hex(n)];
	%s(n) = strcat('0x', h_eb_fx.hex(n));
end

disp(s);
