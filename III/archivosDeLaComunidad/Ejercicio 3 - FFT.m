%------------Mi FFT-----------------------
clear all;
clc;

%h=[0, 4, 4i, 4, 0, 4, -4i, 4];
h =randi(100,16,1);

H=mi_fft(h)
Q=fft(h)