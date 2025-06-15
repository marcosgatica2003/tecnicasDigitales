%*** 7-1 *** Representación de la respuesta en frecuencia de un filtro FIR pasa-bajos. 

%*** 7-1-1 *** Cargar el archivo filtro.dat en un variable h, utilizando la función load.

h=load('filtro.dat');  %leemos los coeficientes del filtro, respuesta al impulso o kernel

%*** 7-1-2 *** Graficar la respuesta al impulso de filtro mediante la función stem

figure
stem(h);
title('Kernel del filtro');
%fvtool(h);

%*** 7-1-3 *** Obtener la DFT de la respuesta al impulso mediante H = fft(h,K); donde K es la cantidad
%de frecuencias a calcular, para este caso usar K=100. Tener en cuenta que K siempre debe ser
%mayor al tamaño del filtro.

K=100;
H=fft(h,K); 

%*** 7-1-4 *** Graficar la respuesta en frecuencia del filtro, calculando el valor absoluto de H mediante la
%función abs y conviertiendolo a dB. Expresar el eje x en frecuencia digital, de 0 a casi 1.

Habs=abs(H(1:K/2)); %sacamos el valor absoluto de H. k/2 equivale solo frecuencias positivas
Hdb=20*log(Habs);   %pasamos a db H
x=(0:(K/2-1))*2/K;  %frecuencia digital. Va desde 0 hasta  0.98. x= 0, 1*2/k, 2*2/k, 3*2/k,..., 49*2/k
                    %para pasar de frec. digital a real multiplicamos por Fs
                         
%*** 7-1-5 ***Incorporar en el título del gráfico anterior los siguientes valores: Ripple en la banda de paso, Ganancia en continua, 
%Atenuación en la banda de rechazo y Frecuencia de corte

%Ripple
maxPaso=max(Hdb);              %encontramos el maximo valor, este va a estar en la banda de paso
posicion=find(Hdb==maxPaso);   %encontramos la posición del valor maximo
minimo= min(Hdb(1:posicion));  %Valor minimo antes de llegar al maximo
ripple= maxPaso-minimo;        %ripple de la banda de paso, si tomamos el min. Despues de 'posicion' va a ser 0 por estar en la banda de rechazo

%Atenuacion en la banda de rechazo
posicion= find(Hdb<=-15);            %podemos considerar la bada de rechazo a partir de -15db
maxStop= max(Hdb(posicion(1):K/2));  %maximo de la banda  de stop
at= maxPaso - maxStop;               %atenuacion de la banda de stop

%Frecuencia de corte
posicion=find(Hdb<=(maxPaso-3));     %posicion de la frecuencia de corte
fc= x(posicion(1));                  %frecuencia de corte

%Ganancia en continua
cc=Hdb(1);

%Graficamos

figure
plot(x,Hdb);
title({strcat('Ripple en la banda de paso=', num2str(ripple)), strcat('Ganancia en continua=', num2str(cc)), 
    strcat('Atenuación en la banda de rechazo =', num2str(at)), strcat('Frecuencia de corte=', num2str(fc))});

% *** 7-1-6 *** Generar una señal senoidal s de frecuencia digital 0.1. Filtrar la señal con el filtro h utilizando la
% función filter(h,1,s). El resultado es exactamente igual a de la función conv, con la
% excepción de las últimas muestras que en la función filter son eliminadas para mantener la
% cantidad de muestras original. Graficar entrada y salida en el mismo gráfico, indicando en el título
% amplitud de la señal de salida y el retardo en muestras entre la señal de entrada y la filtrada.

% generamos la señal
s=zeros(K,1);
for i=1:K
    s(i)=sin(pi*0.1*(i));
end

% aplicamos el filtro a la señal
salida=filter(h,1,s);

% obtenemos la amplitud maxima para la entrada y salida
maxSalida=max(salida);   
maxEntrada=max(s);

%buscamos la posicion en muestras de los puntos maximos de entrada y salida
posicionSalida=find(salida==maxSalida); 
posicionEntrada=find(s==maxEntrada);

%calculamos el retraso en muestras con la diferencia del primer maximo
retraso=posicionSalida(1) - posicionEntrada(1); 

%graficamos
figure
plot(x,s(1:K/2),x,salida(1:K/2));
legend('Entrada','Salida');
title({strcat('maxima amplitud de entrada=',num2str(abs(maxEntrada))),strcat('maxima amplitud de salida=',num2str(maxSalida)),strcat('retraso en muestras=', num2str(retraso))})

% *** 7-1-7 *** Normalice la ganancia en continua del filtro (Para mantener la amplitud de salida igual a la entrada)
% dividiendo h[n] por el valor obtenido en el punto 7.1.5 y vuelva a graficar la respuesta en
% frecuencia.


%normalizo la respuesta del filtro y graficamos su respuesta en frecuencia
%nuevamente

hn=h/abs(H(1));   %H(1) es la ganancia en continua del filtro
Hn=fft(hn,K);
Habsn=abs(Hn(1:K/2));
Hdbn=20*log(Habsn);

figure;
plot(x,Hdbn);
legend('Normalizacion de respuesta del filtro');

%Aplicamos el filtro normalizado a la señal s y graficamos
salidaNormalizada=filter(hn,1,s);
figure;
plot(x,salidaNormalizada(1:K/2));
legend('salida normalizada');







