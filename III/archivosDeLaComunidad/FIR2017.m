%Especificaciones del filtro
fc1 = 2850;   
fc2 = 3150;
fs = 39062;   %frecuencia de muestreo necesaria para digitalizar freuencias, se usa la del ejercicio anterior


%frecuencias digitales
f_d1 = 2*fc1/fs; 
f_d2 = 2*fc2/fs;

%Cantidad de taps
M = 399;

%Generacion funcion sinc pasa bajos
h_pb1 = zeros(M,1);      %Inicializacion del filtro pasa bajos normalizado
h_pb2 = zeros(M,1);
h_pb1aux = zeros((M-1)/2 + 1,1);
h_pb2aux = zeros((M-1)/2 + 1,1);

for i=1:((M-1)/2)+1
    h_pb1aux(i)  = sinc( (i-1)*f_d1 );
    h_pb2aux(i)  = sinc( (i-1)*f_d2 );
end

k=M/2+0.5;
for i=1 : (M-1)/2 
     h_pb1(i) = h_pb1aux(k);
     h_pb2(i) = h_pb2aux(k);
     k=k-1;
end

k=M/2+0.5;
for i=1 : ((M-1)/2)
     h_pb1(k) = h_pb1aux(i);
     h_pb2(k) = h_pb2aux(i);
     k=k+1;
end

for i=1 : M
    h_pb1(i) = h_pb1(i)*f_d1;
    h_pb2(i) = h_pb2(i)*f_d2;
end

%Creo a Filtro pasa altos
h_pa = zeros(M,1);       %Inicializacion del filtro pasa altos normalizado

%Retardado
Retardo = zeros(k);
Retardo(M/2+0.5)=1;

for i=1 : k 
        h_pa(i) = Retardo(i) - h_pb2(i);
end


vent = blackman(M);
for i=1:M
    h_pb1(i) = h_pb1(i)*vent(i);
    h_pa(i) = h_pa(i)*vent(i);
end


%Eliminabanda

h_eb = zeros(M,1);
disp('Antes de la cuantificacion')
for i=1:M
    h_eb(i) = h_pb1(i) + h_pa(i);
    disp(h_eb(i))
end





disp('Despues de la cuantificacion')
for i=1:M
      
      h_hex = fi(h_eb(i),1,16,15);  % Convierte los coeficientes en S16.15
      s = ['0x' h_hex.hex];   %Crea una cadena y antepone 0x
      disp(s)  % Muestra la cadena por consola
end

%busco respuesta en frecuencia
K=8000;
H_eliminabanda = fft(h_eb,K);

%Paso a frecuencia digital
Y_eliminabanda = zeros(K/2,1);
X = zeros(K/2,1);

for i=1 : (K/2-1)
    Y_eliminabanda(i,1) = H_eliminabanda(i);
end

for i=1 : (K/2-1)
    X(i,1) = i*39016/K;
end

%Grafico superposicion de pasabajos y pasa altos
plot(X, 20*log(abs(Y_eliminabanda)));
xlabel('Frecuencia Hz')
ylabel('Ganancia dB')
title('Respuesta Eliminabanda')






















 


