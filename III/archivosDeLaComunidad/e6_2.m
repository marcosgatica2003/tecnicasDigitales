%Guia 6, Ejercicio 2

%PUNTO 2.1 creacion de un IIR chebychev tipo 1 de segundo orden pasa bajos, pasa altos y pasa banda
%con frecuencias de corte 500Hz, 3KHz y [500Hz 3KHz], con ripple en banda de pasa de 0,1dB

fs = 39065.5; %frecuencia de muestreo X(puse 44,1KHz como ejemplo), igual a la utilizada en configuracion del ADC de la Guia 5
f_cb = 500; %frecuencia de corte pasa bajos
f_ca = 3000; %frecuencia de corte pasa altos
N = 2; %orden del filtro
R = 0.1; %ripple del filtro en dB

%formo las frecuencias digitales
f_cbd = f_cb/(fs/2); %frecuencia de corte digital filtro pasa bajos
f_cad = f_ca/(fs/2); %frecuencia de corte digital filtro pasa altos


[b_bajo a_bajo] = cheby1(N, R, f_cbd, 'low'); %se obtienen los coeficientes del filtro pasa bajos con corte a 500Hz
[B_alto A_alto] = cheby1(N, R, f_cad, 'high'); %se obtienen los coeficientes del filtro pasa altos con corte a 3KHz

%fvtool(b_bajo, a_bajo) %se plotean la respuesta del pasa bajos
%fvtool(B_alto, A_alto) %se plotean la respuesta del pasa altos

[b_pb_bajo a_pb_bajo] = cheby1(N, R, f_cad, 'low'); %formo el pasa bajo(parte del pasa banda) con corte a 3KHz
[b_pb_alto a_pb_alto] = cheby1(N, R, f_cbd, 'high'); %formo el pasa alto(parte del pasa banda) con corte a 500Hz

%fvtool(b_pb_bajo, a_pb_bajo) %se plotean la respuesta del pasa bajos(parte del pasa banda)
%fvtool(b_pb_alto, a_pb_alto) %se plotean la respuesta del pasa altos(parte del pasa banda)



%IMPORTANTE!!! en la guia figuran los coeficientes a acomodarlos como: B0, B1, -A1, B2, -A2.
%los terminos "A" y "B" son los obtenidos de las funciones cheby1 previamente utilizadas, por ejemplo: b_bajo y a_bajo,
%cada uno de estos es un vector(o matriz fila), como en MATLAB el primer elemento está en la posición 1(a diferencia de C/C++ que comienza en 0)
%es por ello que a la posición dada como referencia en la guia se le suma uno.
%Así, B0 corresponde a b_bajo(1), -A1 corresponde a -a_bajo(2), etc.(de igual forma para todos los filtros)



%CREACION DE LOS COEFICIENTES CORRESPONDIENTES AL PASA BAJOS Y PASA ALTOS, POR CONSOLA DE MATLAB SE IMPRIMEN LOS VALORES
%acomodo los coeficientes segun el orden que requiere estar en la memoria X
seccion_bajo = [b_bajo(1) b_bajo(2) -a_bajo(2) b_bajo(3) -a_bajo(3)]/2;
seccion_alto = [B_alto(1) B_alto(2) -A_alto(2) B_alto(3) -A_alto(3)]/2;
%paso los coeficientes de ambas secciones a formato S16.15
seccion_bajo_fx = fi(seccion_bajo, 1, 16, 15);
seccion_alto_fx = fi(seccion_alto, 1, 16, 15);



disp('los siguientes coeficientes corresponden al filtro pasa bajos:')
tam = length(seccion_bajo_fx); %
s = zeros(1, tam);
s = [];
for n = 1 : tam
	temp = seccion_bajo_fx(n);
	s = [ s ',0x' temp.hex];
end

disp(s);
disp(s);
disp(s);
disp(s);



disp('los siguientes coeficientes corresponden al filtro pasa altos:')
tam = length(seccion_alto_fx); %
s = zeros(1, tam);
s = [];
for n = 1 : tam
	temp = seccion_alto_fx(n);
	s = [ s ',0x' temp.hex];
end

disp(s);
disp(s);
disp(s);
disp(s);




%CREACION DE LOS COEFICIENTES CORRESPONDIENTES AL PASA BANDA, POR CONSOLA DE MATLAB SE IMPRIMEN LOS VALORES
%acomodo los coeficientes segun el orden que requiere estar en la memoria X
seccion_pb_bajo = [b_pb_bajo(1) b_pb_bajo(2) -a_pb_bajo(2) b_pb_bajo(3) -a_pb_bajo(3)]/2;
seccion_pb_alto = [b_pb_alto(1) b_pb_alto(2) -a_pb_alto(1) b_pb_alto(3) -a_pb_alto(3)]/2;
%paso los coeficientes de ambas secciones a formato S16.15
seccion_pb_bajo_fx = fi(seccion_pb_bajo, 1, 16, 15);
seccion_pb_alto_fx = fi(seccion_pb_alto, 1, 16, 15);


disp('los siguientes coeficientes corresponden al filtro pasa bajos(parte del pasa banda):')
tam = length(seccion_pb_bajo_fx); %
s = zeros(1, tam);
s = [];
for n = 1 : tam
	temp = seccion_pb_bajo_fx(n);
	s = [ s ',0x' temp.hex];
end

disp(s);
disp(s);
disp(s);
disp(s);

disp('los siguientes coeficientes corresponden al filtro pasa altos(parte del pasa banda):')
tam = length(seccion_pb_alto_fx); %
s = zeros(1, tam);
s = [];
for n = 1 : tam
	temp = seccion_pb_alto_fx(n);
	s = [ s ',0x' temp.hex];
end

disp(s);
disp(s);
disp(s);
disp(s);

disp('IMPORTANTE!!! QUITAR LA PRIMERA COMA AL PASARLO AL DSPIC !!!')

