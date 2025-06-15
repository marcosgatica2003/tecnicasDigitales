clear all;
close all;

%pwelch(señal, muestras, muestras que se superponen,1024, fs)
%pwelch(x,1024,512,1024,fs)señal,tamaño de ventana, tamaño fft, frecuencia de muestreo
% esto me da el espectro promediado

[xt,Fs]=audioread('numeros.wav');

f1=0.5;
desp=500; %cuanto de desplazo en el punto 5
%----------creo filtro pasa bajos---------------------
F=[0,0.4,0.45,1]; 
A=[1,1,0,0];

h =firpm(100,F,A);

Y = filter(h,1,xt); %filtro la señal
tam=length(Y);

for i=1: tam               
    s1(i)=(cos(pi*f1*(i))); % generacion de onda coseno
end

for i=1: tam               
    Y1(i)= s1(i)*Y(i);
end
figure(1);
pwelch(Y1,1024,600,1024,Fs);
%----------creo filtro pasa altos---------------------
Fb=[0,0.5,0.55,1]; 
Ab=[0,0,1,1];

hb =firpm(100,Fb,Ab);

Yb = filter(hb,1,Y1); %filtro la señal

for i=1: tam               
    s1(i)=cos(pi*i*(f1+(desp/Fs*2))); % generacion de onda coseno
end

for i=1: tam               
    Y2(i)= s1(i)*Yb(i);
end
figure(2);
pwelch(Y2,1024,600,1024,Fs);

%----------creo filtro pasa bajos---------------------

Fc=[0,0.5+(desp/Fs),0.55,1]; %debo sumarle los 100Hz
Ac=[1,1,0,0];

hc =firpm(100,Fc,Ac);

Y3 = filter(hc,1,Y2); %filtro la señal
figure(3);
pwelch(Y3,1024,600,1024,Fs);

sound(Y3*4,Fs);

