
h = load('low_pass.dat');
%Grafico la respuesta al impulso de los filtros
figure('Name','Respuestas al impulso','NumberTitle','off')
hold all
stem(h);
%----------------------------------------------------------
K = 1000;  
H = fft(h,K);  %Respuesta en frecuencia del filtro
H_n = zeros((K/2)-1,1);      %Resp del Filtro normalizado en frecuencia (0 - casi 1)
for i=1 : ((K/2)-1)
    H_n(i,1) = H(i);
end

X = zeros((K/2)-1,1);         %Eje de frec normalizado 0 - casi 1
for i=1 : ((K/2)-1)
    X(i,1) = (i)/(K/2);
end
% Se grafica la respuesta en frecuencia del filtro (Parte Real y parte Imaginaria)
figure('Name','Respuesta en frecuencia','NumberTitle','off')
plot( X, 20*log(abs(H_n)) );
title('Ripple BP = 1.06dB, G(CC) = 13,86 dB, At. Banda rechazo = 59,7 dB, Fc = 0,664')
text (0,13.86,'G(cc)')
text (0.664,9.951,'fc')
ylabel('G (dB)')
xlabel('frecuencia')
%Ripple banda de paso = (13,86dB - 11,73dB)/2 = 1,06dB
%At. Banda de rechazo = G en el punto mas alto de la banda de paso menos G del primer lobulo de la banda de stop
%At. Banda de rechazo = 13,86 - (-45,84 DB) = 59,7 dB


