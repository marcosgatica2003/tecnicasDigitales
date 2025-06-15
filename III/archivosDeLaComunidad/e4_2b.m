clear all
close all
clc
%frecuencias en herts
fsample = 44100; 
fcorte  = 3500; % fcorte es el promedio entre fpass y fstop
fpass = 3000;
fstop = 4000;
BT =1000;         %Banda de transicion

%Frecuencias digitales 
FDcorte = fcorte/(fsample/2);
FDBT = BT/(fsample/2); 
FDpass = fpass/(fsample/2);
FDstop = fstop/(fsample/2); 

%numero de taps
Mi = 99; 

%--- generacion de funcion sinc(x)
filtro = zeros(Mi);

for n=1:Mi
  hsinc(n)=FDcorte*sinc(FDcorte*(n-((Mi-1)/2))); %genero funcion sinc
end

vent1=hamming(Mi); 


for i=1 : Mi
    filtro(i) = hsinc(i) * vent1(i);
end
K=1000;
H = fft(filtro,K); %respuesta en frecuencia
figure('Name','respuesta al impulso','NumberTitle','off')
stem(filtro);

%Paso a frecuencia digital
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
 

