%------- frecuencias en herts -------------------------
fsample = 44100; % Equivale a 1 en frecuencia digital
fcorte  = 3000;  
BT = 500;         %Banda de transicion
% ------- Frecuencias digitales ----------------------
Fd_corte = fcorte/fsample;
%Fd_BT = 500/44100 = 0.0113378

%---- numero de taps
M = 707; %8/Fd_BT = 705,6

%--- generacion de funcion sinc(x)
s = zeros(M);
s_h = zeros((M-1)/2 + 1);
filtro1 = zeros(M);
filtro2 = zeros(M);
filtro3 = zeros(M);

for i=1:((M-1)/2)+1
    s_h(i)  = sinc( (i-1)*Fd_corte );
end

k=354;
for i=1 : (M-1)/2 
     s(i) = s_h(k);
     k=k-1;
end
k=354;
for i=1 : ((M-1)/2)+1
     s(k) = s_h(i);
     k=k+1;
end


vent1 = blackman(M);
vent2 = kaiser(M);
vent3 = chebwin(M);

for i=1 : M
    filtro1(i) = s(i) * vent1(i);
    filtro2(i) = s(i) * vent2(i);
    filtro3(i) = s(i) * vent3(i);
end

%busco respuesta en frecuencia
K=1000;
H1 = fft(filtro1,K);%blackman
H2 = fft(filtro2,K);%kaiser
H3 = fft(filtro3,K);%chebychev

%----- normalizacion ---------------
for i=1 : M
    filtro1(i) = (s(i) * vent1(i))/H1(1);
    filtro2(i) = (s(i) * vent2(i))/H2(1);
    filtro3(i) = (s(i) * vent3(i))/H3(1);
end

H1 = fft(filtro1,K);%blackman
H2 = fft(filtro2,K);%kaiser
H3 = fft(filtro3,K);%chebychev

%Paso a frecuencia digital
Y1 = zeros(K/2,1);
Y2 = zeros(K/2,1);
Y3 = zeros(K/2,1);
X = zeros(K/2,1);

for i=1 : (K/2-1)
    Y1(i,1) = H1(i);
    Y2(i,1) = H2(i);
    Y3(i,1) = H3(i);
end

for i=1 : (K/2-1)
    X(i,1) = i/K;
end

%Grafico superposicion de pasabajos y pasa altos
figure('Name','Ventana Blackman','NumberTitle','off')
plot( X, 20*log(abs(Y1)));
xlabel('Frecuencia')
ylabel('Ganancia dB')
title('fc = 3,087KHz -- At.Banda de stop = 178.56dB -- Ripple banda paso = 0dB ')
hold all

figure('Name','Ventana Kaiser','NumberTitle','off')
plot( X, 20*log(abs(Y2)));
xlabel('Frecuencia')
ylabel('Ganancia dB')
title('fc = 3,043KHz -- At.Banda de stop = 64.717dB -- Ripple banda paso = 0.99dB ')

figure('Name','Ventana Chebychev','NumberTitle','off')
plot( X, 20*log(abs(Y3)));
xlabel('Frecuencia')
ylabel('Ganancia dB')
title('fc = 3,098KHz -- At.Banda de stop = 261.36dB -- Ripple banda paso = 0dB')

    