[x, Fs, nbits] = wavread('numeros.wav');

h_d1 = [1,-1];
h_d2 = [1,-2,1];
h_d3 = [1,-3,3,-1];

d1_x = conv(h_d1,x);
wavwrite(d1_x,Fs,nbits,'primera_derivada.wav');
%sound(d1_x, Fs, nbits)

d2_x = conv(h_d2,x);
wavwrite(d2_x,Fs,nbits,'segunda_derivada.wav');
%sound(d2_x, Fs, nbits)

d3_x = conv(h_d3,x);
wavwrite(d3_x,Fs,nbits,'tercera_derivada.wav');
sound(d3_x, Fs, nbits)

figure('Name','Salidas','NumberTitle','off')
hold all
plot(d3_x);
plot(d2_x);
plot(d1_x);
legend('d3_x','d2_x','d1_x')
ylabel('Amplitud')
xlabel('Tiempo')

%Al realizar la derivada se escucha y se observa en el plot, como se
%incrementa el ruido. Ademas se escucha que la amplitud disminuye

