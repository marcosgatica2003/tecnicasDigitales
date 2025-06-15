clear all
close all
clc


fs=22050;   % frecuencia de muestreo
F1=1000;    % frecuencia uno
F2=1100;   % frecuencia dos

K=2*fs;                
x=(0:(K/2-1))*fs/K;    

f1=F1/(fs/2);     
f2=F2/(fs/2);
%-------------------
%muestras para 2 seg
t=fs*2;        
     

s1=zeros(1,t);
for i=1:t               
    s1(i)=0.5*(sin(pi*f1*(i))); % generacion de onda senoidal
end


s2=zeros(1,t); 
for i=1:t              
    s2(i)=0.5*(sin(pi*f2*(i))); % generacion de onda senoidal
end

s=s1+s2;   %suma de señales senoidales  

%hacemos la tranformada de fourier de s 
S=(fft(s,K));

%Graficamos el espectro de frecuencias de la señal de entrada
figure
plot(x,20*log(abs(S(1:K/2)/22050)));    
title('señal de entrada');
 xlabel('Frecuencia[Hz]');
ylabel('Amplitud[dB]');
    
%sound(s,fs);

F=[0,f1,f2,1];
A=[1,1,0.01,0.01];

h =firpm(157,F,A);

H=fft(h,K);

audi=conv(h,s);

AUDI=fft(audi,K);

yy = zeros((K/2),1);
xx = zeros((K/2),1);


for i=1 : ((K/2)-1)
    yy(i,1) = H(i);
end

for i=1 : ((K/2)-1)
    xx(i,1) = i/(K/2);
end

figure(2)
plot( xx*(fs/2), 20*log((abs(yy))));
title('filtro');
ylabel('G (dB)')
xlabel('frecuencia Hz')

aa = zeros((K/2),1);
bb = zeros((K/2),1);


for i=1 : ((K/2)-1)
    aa(i,1) = AUDI(i);
end

for i=1 : ((K/2)-1)
    bb(i,1) = i/(K/2);
end

figure
plot(bb*(fs/2),20*log(abs(aa(1:K/2)/fs)));    
title('señal filtrada');
 xlabel('Frecuencia[Hz]');
ylabel('Amplitud[dB]');
    


sound(audi,fs);


