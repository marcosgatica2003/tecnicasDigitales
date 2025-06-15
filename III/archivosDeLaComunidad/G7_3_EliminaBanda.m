%Cargo el filtro
h_pb = load('filtro1.dat');
h_pb =h_pb/ 4.014;

%genero el filtro pasa altos
Tam = size(h_pb);
h_pa = zeros (Tam);

for i=1:Tam
    h_pa(i) = ((-1)^i) * h_pb(i);
end

%busco respuesta en frecuencia
K=1000;
H_pb = fft(h_pb,K);
H_pa = fft(h_pa,K);

%Paso a frecuencia digital
Y_pa = zeros(K/2,1);
Y_pb = zeros(K/2,1);
X = zeros(K/2,1);

for i=1 : (K/2)
    Y_pa(i,1) = H_pa(i);
    Y_pb(i,1) = H_pb(i);
end

for i=1 : (K/2)
    X(i,1) = i/K;
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


%Genero el filtro elimina banda
h_eb = zeros(Tam);
for i=1:Tam
    h_eb(i) = h_pb(i) + h_pa(i);
end

%busco respuesta en frecuencia
K=1000;
H_eb = fft(h_eb,K);

%Paso a frecuencia digital
Y_eb = zeros(K/2,1);
X = zeros(K/2,1);

for i=1 : (K/2)
    Y_eb(i,1) = H_eb(i);
end

for i=1 : (K/2)
    X(i,1) = i/K;
end

%Grafico superposicion de pasabajos y pasa altos
figure
plot( X, 20*log(abs(Y_eb)));
xlabel('Frecuencia digital')
ylabel('Ganancia dB')
title('Respuesta elimina banda')



