clc;
clear all;


[filtro,Fs]=audioread('s1_r1_b_cd.wav');
[audio,Fs1]=audioread('lamona.wav');

xa=audio;
ha=filtro;
h(1,:)=ha(:,1);

x(1,:)=xa(:,1);

L=30;

% Code to perform Convolution using Overlap Save Method
M=length(h); %longitud de la respuesta al impulso
lx=length(x); %longitud de la señal
r=rem(lx,L); %calcula cuantos ceros debo agregar para tomar todas las muestras en bloques del mismo tamaño
x1=[x zeros(1,L-r)];
nr=(length(x1))/L;
h1=[h zeros(1,L-1)];
inicio=1;
for k=1:nr
    
    Ma(k,:)=x1((inicio):k*L) %toma una porcion de x
    if k==1
        Ma1(k,:)=[zeros(1,M-1) Ma(k,:)]; %primer bloque
    else 
        Ma1(k,:)=[Ma1(1,(L-M+1):(L-1)) Ma(k,:)];        
    end
    
     Ma2(k,:)=ifft(fft(Ma1(k,:)).*fft(h1));
     inicio=((k*L)+1);
end
Ma3=Ma2(:,M:(L+M-1));
y1=Ma3';
y=y1(:)'

