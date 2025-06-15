%--- Especificaciones del filtro
fc = 50;   %50Herts
fs = 1000; %1KHz
BT = 1;     %1Hz


%----- frecuencias digitales
%BT_d = BT/fs;  %=0.001
fc_d = 2*fc/fs;  %=0.05

%-------- Cantidad de taps
% M = 8/BT = 8000 ---> Uso 8001
M = 8001;

%------ Generacion funcion sinc pasa bajos
h_pb = zeros(M,1);
h_pb_aux = zeros((M-1)/2 + 1,1);

for i=1:((M-1)/2)+1
    h_pb_aux(i)  = sinc( (i-1)*fc_d );
end

k=M/2+0.5;
for i=1 : (M-1)/2 
     h_pb(i) = h_pb_aux(k);
     k=k-1;
end

k=M/2+0.5;
for i=1 : ((M-1)/2)
     h_pb(k) = h_pb_aux(i);
     k=k+1;
end

%creo a Filtro pasa altos
h_pa = zeros(M,1);       %Inicializacion del filtro pasa altos normalizado

%Genero delta(n) retardado
Retardo = zeros(k);
Retardo(M/2+0.5)=1;

for i=1 : k 
        h_pa(i) = Retardo(i) - h_pb(i);
end


%------ Generacion del kernel del pasa bajos
vent = blackman(M);
for i=1:M
    h_pb(i) = h_pb(i)*vent(i);
    h_pa(i) = h_pa(i)*vent(i);
end

%----- generacion del kernel del pasa banda
h_pasabanda = conv(h_pb,h_pa);

%busco respuesta en frecuencia
K=8000;
H_pasabanda = fft(h_pasabanda,K);

%Paso a frecuencia digital
Y_pasabanda = zeros(K/2,1);
X = zeros(K/2,1);

for i=1 : (K/2-1)
    Y_pasabanda(i,1) = H_pasabanda(i);
end

for i=1 : (K/2-1)
    X(i,1) = i*1000/K;
end

%Grafico superposicion de pasabajos y pasa altos
figure
plot( X, 20*log(abs(Y_pasabanda)));
xlabel('Frecuencia Hz')
ylabel('Ganancia dB')
title('Respuesta pasabanda')















 


