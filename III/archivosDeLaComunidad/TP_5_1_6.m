% ***** 5.1.6 ***** Graficar las 3 funciones senoidales en un mismo gráfico. Para lograr esto habilitar la superposición
% mediante el comando hold all, luego del primer comando plot.

N=100;
x=(0:N-1)/N;
f1=1;
f2=3;
f3=5;
y1=sin(2*pi*f1*x);
y2=0.5 * sin(2*pi*f2*x);
y3=0.25* sin(2*pi*f3*x);
figure;
plot (x,y1);
hold all;
plot (x,y2);
plot (x,y3);

xlabel('Segundos');
ylabel('Voltaje');
title ('Las tres señales en el mismo grafico');