% ****** 5.1.7 ****** Sumar las tres señales con el operador + y graficar la suma en el mismo gráfico del punto anterior.
% ****** 5.1.8 ****** Utilizar el comando legend para agregar nombres a cada señal en la gráfica.

N=100;
x=(0:N-1)/N;
f1=1;
f2=3;
f3=5;
y1=sin(2*pi*f1*x);
y2=0.5 * sin(2*pi*f2*x);
y3=0.25* sin(2*pi*f3*x);
y4=y1+y2+y3;
figure;
plot (x,y1);
hold all;
plot (x,y2);
plot (x,y3);
plot (x,y4);

xlabel('Segundos');
ylabel('Voltaje');
title ('Grafico de las señales y1, y2, y3 y la suma de estas y4');

legend('y1','y2','y3','y1+y2+y3')