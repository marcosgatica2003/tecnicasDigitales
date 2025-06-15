clear all
close all
clc
%frecuencias
fs=256;   
f1=50;                
f2=100;   

N = 4;              
K=2*fs;    
            
t =fs*8; %duracion de 8 segundos

F1 = f1/(fs/2); %Frecuencias digitales
F2 = f2/(fs/2);         

s1=zeros(1, t);  %Generamos señales
s2=zeros(1, t);  

for i=1:t               
    s1(i)=sin(pi*F1*(i));
end
 
for i=1:t              
    s2(i)=sin(pi*F2*(i));
end

stotal = s1 + s2;  
SEN=fft(stotal, K); 

y = zeros((K/2),1);
x = zeros((K/2),1);


for i=1 : ((K/2)-1)
    y(i,1) = SEN(i);
    x(i,1) = i/(K/2);
end

figure(1)
plot( x*(fs/2), 20*log((abs(y))/fs));
title('Espectro señal senoidal');
ylabel('G (dB)')
xlabel('frecuencia Hz')

a=[1 -2.12984 1.78256 -0.54343 0.0];
b=[0.0528556 0.0017905 0.0017905 0.0528556];


sfil1=filter(b,a,stotal); %uso la funcion filter
SFIL1=fft(sfil1,K);


for i=1 : ((K/2)-1)
    yy(i,1) = SFIL1(i);
    xx(i,1) = i/(K/2);
end

figure(2)
plot( xx*(fs/2), 20*log((abs(yy))/fs));
title('Señal filtrada con funcion filter');
ylabel('G (dB)')
xlabel('frecuencia Hz')

tam=length(stotal);
salida=zeros(1,N+tam-1);      
stotal=[stotal zeros(1,N)];      

ent=zeros(1,N);
sal=zeros(1,N);

for n=1:N+tam-1
    ent=[stotal(1,n) ent(1:N-1)];   
    for i=1:N
        salida(n)= salida(n) + ent(i)*b(i) - sal(i)*a(i+1);                                                                     
    end
    sal=[salida(1,n) sal(1:N-1)];    
end

SFIL2=fft(salida,K);

for i=1 : ((K/2)-1)
    y1(i,1) = SFIL2(i);
    x1(i,1) = i/(K/2);
end

figure(3)
plot( x1*(fs/2), 20*log((abs(y1))/fs));
title('filtrado con filtro IIR');
ylabel('G (dB)')
xlabel('frecuencia Hz')

[H,w]=freqz(b,a); 

figure(4);
plot(((w/pi)*(fs/2)),20*log10(abs(H)));
title('respuesta en frecuencia filtro');
ylabel('G (dB)')
xlabel('frecuencia Hz')
text(50,-30.7,' 30.7dB atenuación 50Hz');
text(100,-34.04,'34.04dB atenuación 100Hz');