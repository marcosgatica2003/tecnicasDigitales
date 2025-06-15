h = load('filtro.dat')
%Grafico la respuesta al impulso de los filtros
figure('Name','Respuestas al impulso','NumberTitle','off')
hold all
stem(h);
legend('Respuesta filtro');
%----------------------------------------------------------
K = 1000;                %Cantidad de frecuencias a graficar en la TDF
H = fft(h,K);            %Respuesta en frecuencia del filtro
H_n = zeros(K-1,1);      %Resp del Filtro normalizado en frecuencia (0 - casi 1)
for i=1 : (K-1)
    H_n(i,1) = H(i);
end
X = zeros(K-1,1);         %Eje de frec normalizado 0 - casi 1
for i=1 : (K-1)
    X(i,1) = (i)/K;
end
% Se grafica la respuesta en frecuencia del filtro (Parte Real y parte Imaginaria)
figure('Name','Respuesta en frecuencia','NumberTitle','off')
plot( X, 20*log(abs(H_n)) );
title('Ripple BP = 2.05dB, G(CC) = 28.16dB, At. Banda STOP = 46.61 dB, Fc = Fs')
ylabel('G (dB)')
xlabel('frecuencia')
%Ripple banda de paso = 29,13dB - 27,08dB = 2,05dB
%At. Banda de stop = G en el punto mas alto de la banda de paso menos G del primer lobulo de la banda de stop
%At. Banda de stop = 29,13 - (-17,48 DB) = 46,61 dB
%A la componente de CC la grafica la pone en X=1


%----------------------------------------------------------
%Señal senoidal de frecuencia digital 0.1
f = 0.1;                      %Frecuencia digital de la señal
seno = zeros(K-1,1);          %Resp del Filtro normalizado en frecuencia (0 - casi 1)
for i=1 : (K-1)
    seno(i,1) = sin((f*2*pi*i)/(K/100));
end
seno_f = filter(h,1,seno);   %Filtrado de la señal
%Grafico la salida del filtro 
figure('Name','Salida del filtro','NumberTitle','off')
hold all
plot(X,seno);
plot(X,seno_f);
legend('Entrada','Salida')
title('Amplitud salida = 4.014 , Retardo = 10 muestras')
ylabel('Amplitud')
xlabel('Tiempo')
%----------------------------------------------------------
%Normalizacion de la respuesta en frecuencia
h_n = h/4.055;

seno_f_n = filter(h_n,1,seno);   %Filtrado de la señal
%Grafico la salida del filtro 
figure('Name','Salida del filtro','NumberTitle','off')
hold all
plot(X,seno);
plot(X,seno_f_n);
legend('Entrada','Salida')
title('Amplitud salida = 4.014 , Retardo = 10 muestras')
ylabel('Amplitud')
xlabel('Tiempo')

%----------------------------------------------------------
K = 1000;                %Cantidad de frecuencias a graficar en la TDF
H = fft(h_n,K);            %Respuesta en frecuencia del filtro
H_n = zeros(K-1,1);      
for i=1 : (K-1)
    H_n(i,1) = H(i);
end
X = zeros(K-1,1);         %Eje de frec normalizado 0 - casi 1
for i=1 : (K-1)
    X(i,1) = (i)/K;
end
% Se grafica la respuesta en frecuencia del filtro (Parte Real y parte Imaginaria)
figure('Name','Respuesta en frecuencia normalizada','NumberTitle','off')
plot( X, 20*log(abs(H_n)) );
ylabel('G (dB)')
xlabel('frecuencia')
