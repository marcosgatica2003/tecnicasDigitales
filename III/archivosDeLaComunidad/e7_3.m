clear all
close all
N=16; %4,8,16,64
m=rand(1,N);

X=mi_fft(m); %llama a la funcion para que devuelva la fft del vector aleatorio m
             %usar mi_fftb para la funcion hecha con dos bucles for
X1=fft(m); %funcion normal de fft

Y=X - X1; %si me da cero es porque son iguales


