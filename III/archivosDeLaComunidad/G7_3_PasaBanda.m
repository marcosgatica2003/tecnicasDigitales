%Cargo los filtros
h_pb = load('filtro1.dat');
h_pa = load('filtro2.dat');

h_pb = h_pb/4.014;
h_pa = h_pa/ 1.167;

%---------------------------------------------------------
%--------------- FILTRO PASA BANDA -----------------------
%---------------------------------------------------------
% El filtro pasa banda se obtiene convolucionando un pasa 
% bajos con un pasa altos.

h_pbanda = conv(h_pb,h_pa);

%Grafico respuesta al impulso
figure('Name','Respuesta al impulso','NumberTitle','off')
plot(h_pbanda);
hold all
title('Pasa Banda')
ylabel('G (dB)')
xlabel('frecuencia')

%busco respuesta en frecuencia
K=1000;
H_pb = fft(h_pb,K);
H_pa = fft(h_pa,K);

%Paso a frecuencia digital
Y_pa = zeros(K/2,1);
Y_pb = zeros(K/2,1);
X = zeros(K/2,1);

for i=1 : (K/2-1)
    Y_pa(i,1) = H_pa(i);
    Y_pb(i,1) = H_pb(i);
end

for i=1 : (K/2-1)
    X(i,1) = (2*i)/K;
end

%Grafico superposicion de pasabajos y pasa altos
figure
plot( X, 20*log(abs(Y_pb)));
hold all
plot( X, 20*log(abs(Y_pa)));
xlabel('Frecuencia digital')
ylabel('Ganancia dB')
title('Superposicion respuentas en frecuencia')
legend('Pasa bajos','Pasa altos');

%busco respuesta en frecuencia
K=10000;
H_pbanda = fft(h_pbanda,K);

%Paso a frecuencia digital
Y_pbanda = zeros(K/2,1);
X = zeros(K/2,1);

for i=1 : (K/2-1)
    Y_pbanda(i,1) = H_pbanda(i);
end

for i=1 : (K/2-1)
    X(i,1) = (2*i)/K;
end


figure
plot( 20*log(abs(Y_pbanda)));
xlabel('Frecuencia digital')
ylabel('Ganancia dB')
title('Respuesta filtro pasa banda');









