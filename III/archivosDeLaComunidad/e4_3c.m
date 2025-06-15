%frecuencias en herts
fsample = 44100; 
fcorte  = 6050; % 
fpass = 6000;
fstop = 6100;
BT =100;         %Banda de transicion

%Frecuencias digitales 
FDcorte = fcorte/(fsample/2);
FDBT = BT/(fsample/2); 
FDpass = fpass/(fsample/2);
FDstop = fstop/(fsample/2); 

%numero de taps
Mc =1101; 


filtro3 = zeros(Mc);

for n=1:Mc
  hsinc(n)=FDcorte*sinc(FDcorte*(n-((Mc-1)/2))); %genero funcion sinc
end

vent1=hanning(Mc); 


for i=1 : Mc
    filtro3(i) = hsinc(i) * vent1(i);
end
K=1000;
H = fft(filtro3,K);

Y = zeros(K/2,1);
X = zeros(K/2,1);

for i=1 : ((K/2)-1)
    Y(i,1) = H(i);
end

for i=1 : ((K/2)-1)
    X(i,1) = i/(K/2);
end

%Grafico superposicion de pasabajos y pasa altos
figure('Name','filtro pasa bajo','NumberTitle','off')
plot( X*(fsample/2), 20*log(abs(Y)));
title('Pasa bajo     Rp<0.1dB')
ylabel('G (dB)')
xlabel('frecuencia Hz')
 

%----------------------
%GENERAMOS FILTRO PASA ALTO

Max_pb = max(filtro3);

pb = filtro3;
Center_pb = find(filtro3==max(Max_pb));

%Filtro pasa altos
k = size(filtro3);      %tamaño de filtro
pa = zeros(k);       


% retardado
Retardo = zeros(k);
Retardo(Center_pb)=1;

for i=1 : k 
        pa(i) = Retardo(i) - pb(i);
end

% fft
K = 1000;
H_pb = fft(pb,K);
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

figure('Name','Respuesta en frecuencia','NumberTitle','off')
plot( X*(fsample/2), 20*log(abs(Y_pa)));
hold all
title('Pasa altos     Rp<0.1dB')
ylabel('G (dB)')
xlabel('frecuencia')
legend('Filtro pasa altos')
