clear all;
close all;

N=8;
m=[0,1,2,3,4,5,6,7]; %muestras
x=[0,(-i*pi)/4,(-i*pi)/2,(-i*pi*3)/4]; %vector de indice del exponencial de los factores de giro (son los cuatro primeros)
Q=zeros(1,2);
F=exp(x); %hace un vector con los factores de giro

X = bitrevorder(m); %separa par e impar
A=fft(X);

Q=mi_butterfly (X(1),X(2),F(1));
