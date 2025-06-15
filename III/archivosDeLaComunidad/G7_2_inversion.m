h_pb = load('filtro1.dat');     %Filtro pasa bajos
Max_pb = max(h_pb);

h_pb_n = h_pb/4.014;
Center_pb = find(h_pb==max(max(h_pb)));

%creo a Filtro pasa altos
k = size(h_pb);             %guarda el tamaño de h_pb
h_pa_n = zeros(k);       %Inicializacion del filtro pasa altos normalizado

%Genero delta(n) retardado
Retardo = zeros(k);
Retardo(Center_pb)=1;

for i=1 : k 
        h_pa_n(i) = Retardo(i) - h_pb_n(i);
end

%-------------------------------
% Paso a frecuencia
K = 1000;
H_pb_n = fft(h_pb_n,K);
H_pa_n = fft(h_pa_n,K);

%-------------------------------
%Paso a frecuencia digital (de 0 a 1)
Y_pa_n = zeros(K/2,1);
Y_pb_n = zeros(K/2,1);
X = zeros(K/2,1);

for i=1 : (K/2-1)
    Y_pa_n(i,1) = H_pa_n(i);
    Y_pb_n(i,1) = H_pb_n(i);
end

for i=1 : (K/2-1)
    X(i,1) = (i)/K;
end

figure('Name','Respuesta en frecuencia','NumberTitle','off')
plot( X, 20*log(abs(Y_pa_n)) );
hold all
title('Pasa altos')
ylabel('G (dB)')
xlabel('frecuencia')

figure('Name','Respuesta en frecuencia','NumberTitle','off')
plot( X, 20*log(abs(Y_pb_n)) );
title('Pasa bajos')
ylabel('G (dB)')
xlabel('frecuencia')