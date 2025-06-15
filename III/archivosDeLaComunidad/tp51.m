N=100; %Total de muestras
f1=1; %Frecuencia 1
f2=3; %Frecuencia 2
f3=5; %Frecuencia 3
x=(0:N-1)/N; %Vector de tiempo
y1=sin(2*pi*f1*x); %Vector de salida Senoidal 1
y2=0.5*sin(2*pi*f2*x); %Vector de salida Senoidal 2
y3=0.25*sin(2*pi*f3*x); %Vector de salida Senoidal 3
y4=y1+y2+y3;
figure ();
plot(x,y1) %Gráfica del vector de salida
legend ('Senoidal f=1');
xlabel('Tiempo');
ylabel('Voltaje');
title('Senoidal 1');
figure();
plot(x,y2) %Gráfica del vector de salida
legend ('Senoidal f=3');
xlabel('Tiempo');
ylabel('Voltaje');
title('Senoidal 2');
figure();
plot(x,y3) %Gráfica del vector de salida
legend ('Senoidal f=5');
xlabel('Tiempo');
ylabel('Voltaje');
title('Senoidal 3');
figure();
plot(x,y1) %Gráfica del vector de salida
hold all;
plot(x,y2) %Gráfica del vector de salida
plot(x,y3) %Gráfica del vector de salida
legend ('Senoidal f=1', 'Senoidal f=3', 'Senoidal f=5');
xlabel('Tiempo');
ylabel('Voltaje');
title('Senoidales');
figure();
plot(x,y4) %Gráfica del vector de salida
legend ('Suma de las Senoidales');
xlabel('Tiempo');
ylabel('Voltaje');
title('Suma de las senoidales');