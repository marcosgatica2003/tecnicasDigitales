% ***** 5.1 ****** Generación y gráfica de señales senoidales

% ***** 5.1.1 ***** Hacer click en File ? New ? M-File, para crear un nuevo programa.
% ***** 5.1.2 ***** Crear un nuevo programa, luego copiar, pegar y ejecutar las siguientes líneas.

%Total de muestras 
N=100;     

%Vector de tiempo
x=(0:N-1)/N;   

%Frecuecias
f1=1;          

%Vectores de salida
y1=sin(2*pi*f1*x);   

% ***** 5.1.3 ***** Usando la funciones xlabel, ylabel y title agregar descripción al gráfico. Utilice el comando help
% para obtener descripción y modo de uso de cada comando. Suponga que se toman N muestras por
% segundo y la señal representa un voltaje al momento de indicar unidades.

%graficamos f1
figure;
plot (x,y1);
xlabel('Segundos');
ylabel('Voltaje');
title ('Grafico de y1');

% ***** 5.1.4 ***** Modificar el programa anterior para generar 3 señales senoidales de frecuencia 1, 3 y 5, con
% amplitudes 1, 0.5 y 0.25 respectivamente y almacenarlas en respectivas variables y1, y2 e y3.

f2=3;
f3=5;
y2=0.5 * sin(2*pi*f2*x);
y3=0.25* sin(2*pi*f3*x);

% ***** 5.1.5 ***** Graficar las señales en 3 gráficos distintos. Para ello llamar a la función figure antes de cada
% llamado a la función plot.


figure;
plot (x,y2);
xlabel('Segundos');
ylabel('Voltaje');
title ('Grafico de y2');

figure;
plot (x,y3);
xlabel('Segundos');
ylabel('Voltaje');
title ('Grafico de y3');

