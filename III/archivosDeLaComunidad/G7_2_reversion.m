h_pb = load('filtro1.dat');     %Filtro pasa bajos
h_pb = h_pb/4.014;
Tam_pb = size(h_pb);            %obtengo tamaño del vector
h_pa = zeros(Tam_pb);           %Inicializacion del filtro pasa altos

%Reversion del espectro
for i=1 : Tam_pb
    h_pa(i) = ((-1)^i)*h_pb(i);   %multiplico por -1 las componentes impares de kernel
end

%-------------------------------
% Paso a frecuencia
K = 1000;
H_pb = fft(h_pb,K);
H_pa = fft(h_pa,K);

%-------------------------------
%Paso a frecuencia digital (de 0 a 1)
Y_pa = zeros(K/2,1);
Y_pb = zeros(K/2,1);
X = zeros(K/2,1);

for i=1 : (K/2-1)
    Y_pa(i,1) = H_pa(i);
    Y_pb(i,1) = H_pb(i);
end

for i=1 : (K/2-1)
    X(i,1) = (i)/K;
end

figure('Name','Respuesta en frecuencia Pasa Bajos','NumberTitle','off')
plot( X, 20*log(abs(Y_pb)) );
hold all
title('Pasa Bajos')
ylabel('G (dB)')
xlabel('frecuencia')

figure('Name','Respuesta en frecuencia Pasa Bajos','NumberTitle','off')
plot( X, 20*log(abs(Y_pa)) );
title('Pasa Altos')
ylabel('G (dB)')
xlabel('frecuencia')