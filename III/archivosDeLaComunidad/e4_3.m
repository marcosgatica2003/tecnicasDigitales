%frecuencias en herts
fsample = 44100; 
fcorte  = 3500; %fcorte es el promedio entre fpass y fstop
fpass = 3000;
fstop = 4000;
BT =1000;         %Banda de transicion

%Frecuencias digitales 
FDcorte = fcorte/(fsample/2);
FDBT = BT/(fsample/2); 
FDpass = fpass/(fsample/2);
FDstop = fstop/(fsample/2); 

%numero de taps
Mi =99; 


filtro = zeros(Mi);

for n=1:Mi
  hsinc(n)=FDcorte*sinc(FDcorte*(n-((Mi-1)/2))); %genero funcion sinc
end

vent1=hamming(Mi); 


for i=1 : Mi
    filtro(i) = hsinc(i) * vent1(i);
end
K=10000;
H = fft(filtro,K);

Y = zeros((K/2),1);
X = zeros((K/2),1);

for i=1 : ((K/2)-1)
    Y(i,1) = H(i);
end

for i=1 : ((K/2)-1)
    X(i,1) = i/(K/2);
end

%Grafico superposicion de pasabajos y pasa altos
figure('Name','filtro pasa bajo','NumberTitle','off')
plot( X*(fsample/2), 20*log(abs(Y)));
ylabel('G (dB)')
xlabel('frecuencia Hz')
 

%-------------------------------------------------
%GENERAMOS FILTRO PASA ALTO

Max_pb = max(filtro);

pb = filtro;
Center_pb = find(filtro==max(Max_pb));

%Filtro pasa altos
k = size(filtro);      % tamaño de filtro
pa = zeros(k);     


%Genero delta(n) retardado
Retardo = zeros(k);
Retardo(Center_pb)=1;

for i=1 : k 
        pa(i) = Retardo(i) - pb(i);
end

% fft
K = 1000;
H_pb = fft(pb,K);
H_pa = fft(pa,K);

%Paso a frecuencia digital
Y_pa = zeros(K/2,1);
Y_pb = zeros(K/2,1);
X = zeros(K/2,1);

for i=1 : ((K/2)-1)
    Y_pa(i,1) = H_pa(i);
    Y_pb(i,1) = H_pb(i);
end

for i=1 : ((K/2)-1)
    X(i,1) = (i)/(K/2);
end

figure('Name','Respuesta en frecuencia','NumberTitle','off')
plot( X*(fsample/2), 20*log(abs(Y_pa)),X*(fsample/2), 20*log(abs(Y_pb)) );
hold all
title('Pasa altos')
ylabel('G (dB)')
xlabel('frecuencia')
legend('Filtro pasa altos','Filtro pasa bajos')
