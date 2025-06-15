clear all
close all
clc
%Filtro pasa bandas
fc1  = 0.1; % fcorte es el promedio entre fpass y fstop
fc2 = 0.2;
BT =0.01;         %Banda de transicion
%creamos filtro pasa bajos
%numero de taps
Mc = 800; 

 fpb = zeros(Mc,1);

for n=1:Mc
  hsinc(n)=fc2*sinc(fc2*(n-((Mc-1)/2))); %genero funcion sinc
end

vent1=hamming(Mc); 


for i=1 : Mc
    fpb(i) = hsinc(i) * vent1(i);
end
K=10000;
Hpb = fft(fpb,K); 

Y = zeros(K/2,1);
X = zeros(K/2,1);

for i=1 : ((K/2)-1)
    Y(i,1) = Hpb(i);
end

for i=1 : ((K/2)-1)
    X(i,1) = i/(K/2);
end

%Grafico de pasabajos 
figure('Name','filtro pasa bajo','NumberTitle','off')
plot( X, 20*log(abs(Y)));
ylabel('G (dB)')
xlabel('frecuencia Hz')
title('Pasa bajos')
 
%-----------------------------------------------------------
%creamos filtro pasa bajos para convertirlo en pasa alto
%numero de taps
fc1t=1-fc1;
Mc = 800; 

 fpbt = zeros(Mc,1);

for n=1:Mc
  hsinc(n)=fc1t*sinc(fc1t*(n-((Mc-1)/2))); %genero funcion sinc
end

vent1=hamming(Mc); 

for i=1 : Mc
    fpbt(i) = hsinc(i) * vent1(i);
end

%Filtro pasa altos
k = size(fpbt);      % tamaño de filtro
fpa = zeros(k);       


for i=1 : k 
        fpa(i) = ((-1)^i)*fpbt(i);
end

% fft
K = 10000;
H_pb = fft(fpbt,K);
H_pa = fft(fpa,K);

%-------------------------------
%Paso a frecuencia digital (de 0 a 1)
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

fpbanda=zeros(Mc,1);

fpbanda=conv(fpb,fpa);

FPBANDA=fft(fpbanda,K);

Y_pbanda=zeros(K/2,1);


for i=1 : ((K/2)-1)
    Y_pbanda(i,1) = FPBANDA(i);
end
for i=1 : ((K/2)-1)
    X(i,1) = (i)/(K/2);
end

figure('Name','Filtro pasa altos','NumberTitle','off')
plot( X, 20*log(abs(Y_pa)) );
hold all
title('Pasa altos')
ylabel('G (dB)')
xlabel('frecuencia')

figure('Name','Filtro pasa altos','NumberTitle','off')
plot( X, 20*log(abs(Y)) );
hold all
title('Pasa bajos')
ylabel('G (dB)')
xlabel('frecuencia')

figure('Name','Filtro pasa banda','NumberTitle','off')
plot( X, 20*log(abs(Y_pa)),X, 20*log(abs(Y)),X, 20*log(abs(Y_pbanda)));
hold all
title('Pasa altos')
ylabel('G (dB)')
xlabel('frecuencia')
legend('Filtro pasa altos','Filtro pasa bajos','filtro pasa banda')