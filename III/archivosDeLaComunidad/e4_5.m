clear all
close all
clc
%Filtro pasa bandas
fs=44100;
f2=950; %frecuencia de corte en Hz
f1=1050;

fc1  = f1/(fs/2); 
fc2 = f2/(fs/2);

BT =100/(fs/2);         

Mc = 3000;

 fpb = zeros(Mc,1);

for n=0:Mc-1
  hsinc(n+1)=fc2*sinc(fc2*(n-((Mc-1)/2))); %genero funcion sinc
end

vent1=blackmanharris(Mc); 


for i=1 : Mc
    fpb(i,1) = hsinc(i) * vent1(i);
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

%-----------------------------------------------------------
%creamos filtro pasa bajos para convertirlo en pasa alto
%numero de taps
fc1t=1-fc1;
Mc = 3000; 

 fpbt = zeros(Mc,1);

for n=0:Mc-1
  hsinc(n+1)=fc1t*sinc(fc1t*(n-((Mc-1)/2))); %genero funcion sinc
end

vent1=blackman(Mc); 

for i=1 : Mc
    fpbt(i) = hsinc(i) * vent1(i);
end

%Filtro pasa altos
k = size(fpbt);      % tamaño de filtro
pa = zeros(k);       %Inicializacion del filtro pasa altos


for i=1 : k 
        pa(i) = ((-1)^i)*fpbt(i);
end

% fft
K = 10000;
H_pb = fft(fpbt,K);
H_pa = fft(pa,K);

%-------------------------------
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

febanda=zeros(Mc,1);

%----------------------------
%suma de kernels

for i=1 : (Mc)
   febanda(i,1) = pa(i) + fpb(i);
end
    



FEBANDA=fft(febanda,K);

Fipbanda=zeros(K/2,1);


for i=1 : ((K/2)-1)
    Fipbanda(i,1) = FEBANDA(i);
end
for i=1 : ((K/2)-1)
    X(i,1) = (i)/(K/2);
end


figure('Name','Filtro pasa banda','NumberTitle','off')
plot(X*(22050), 20*log10(abs(Fipbanda)));
hold all
title('Pasa altos')
ylabel('G (dB)')
xlabel('frecuencia')
legend('filtro pasa banda')


%----------Filtrado del audio-------------
[xt,Fs]=audioread('numeros_humm.wav'); %adquiero el audio

Y = filter(febanda,1,xt); %filtro el audio con el elimina banda

sound(Y,Fs); %reproducir audio
