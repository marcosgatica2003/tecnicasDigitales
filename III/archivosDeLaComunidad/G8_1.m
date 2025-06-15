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

F1 = f1/(fs/2); %FrecuenciaS digitales
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

yy = zeros((K/2),1);
xx = zeros((K/2),1);


for i=1 : ((K/2)-1)
    yy(i,1) = SEN(i);
end

for i=1 : ((K/2)-1)
    xx(i,1) = i/(K/2);
end

figure(1)
plot( xx*(fs/2), 20*log((abs(yy))));
title('Espectro señal senoidal');
ylabel('G (dB)')
xlabel('frecuencia Hz')
%---------------------Filtro IIR(Con Shift Register)----------------------%
%-------------------------------------------------------------------------%
B = [0.0528556   0.0017905   0.0017905    0.0528556     ];
A = [1.00000    -2.12984     1.78256     -0.54343      0]; 
%Agrego un elemento ya que no se suma el producto de la muestra actual, por
%lo que en el for se comienza con el elemento i+1

stotal = [stotal zeros(1,N)];     %Expando la senal de entrada en N elementos
SR_in  = zeros(1,N);        %Registro de desplazamiento de entrada
SR_out = zeros(1,N);        %Registro de desplazamiento de salida
y = zeros(1, N+t-1);        %Señal de Salida

for n = 1 : N+t-1
    SR_in = [stotal(1,n) SR_in(1:N-1)];
    for i = 1 : N
        y(1,n) = y(1,n) + SR_in(1,i)*B(i) - SR_out(1,i)*A(i+1); 
    end
    SR_out = [y(1,n) SR_out(1:N-1)];
end

Y = fft(y, K);              %Espectro en frecuencia de la señal de salida
Y_n = zeros(K-1,1);         %Salida del Filtro normalizado en frecuencia
for i=1 : (K-1)
    Y_n(i,1) = Y(i);
end
Y_dB = 20*log(abs(Y_n));    %Espectro en frecuencia en dB

%--------------------Filtro IIR (Con funcion filter)----------------------%
%-------------------------------------------------------------------------%
y_f = zeros(1,N+t-1);
y_f = filter(B,A,stotal)           %Respuesta del filtro
Y_f = fft(y_f, K);              %Espectro en frecuencia de la señal de salida
Yf_n = zeros(K-1,1);         %Salida del Filtro normalizado en frecuencia
for i=1 : (K-1)
    Yf_n(i,1) = Y_f(i);
end
Yf_dB = 20*log(abs(Yf_n));    %Espectro en frecuencia en dB

%------------------------Ploteo de ambos filtros--------------------------%
%-------------------------------------------------------------------------%
X = zeros(K-1,1);           %Eje de frec normalizado 0 - casi 1
for i=1 : (K-1)
    X(i,1) = (i)/K;
end

figure('Name','Espectro de frec de señal de salida')
hold all
plot(X(1:K/2-1),Y_dB(1:K/2-1));   
plot(X(1:K/2-1),Yf_dB(1:K/2-1));   
legend('Con SR','Con filter')
title('Espectro de frec de señal de salida')
ylabel('Amp (dB)')
xlabel('frecuencia')

%------------------------Ploteo de ambos filtros--------------------------%
%-------------------------------------------------------------------------%
[H,w] = freqz(B,A);    %Retorna la respuesta en frec h y la frec w
H_dB = 20*log(abs(H));    %Espectro en frecuencia en dB
w_Hz = (w/pi)*fs/2;      %convierto w a frecuencia en herz

pos_50Hz = find(w_Hz >= 50); %determino maginutd a 50 y 100 Hz
H_50Hz = H_dB(pos_50Hz(1));
pos_100Hz = find(w_Hz >= 100);
H_100Hz = H_dB(pos_100Hz(1));

figure('Name','Espectro de frec del Filtro')
plot(w_Hz, H_dB);   
text(50, H_50Hz, num2str(H_50Hz));
text(100, H_100Hz, num2str(H_100Hz));
title('Espectro de frec del Filtro')
ylabel('Amp (dB)')
xlabel('frecuencia')