%*** 7-3 *** Obtención de filtros pasa banda y rechaza banda a partir de filtros pasa altos y pasa bajos

%leemos los kernel (respuesta al impulso) de los filtros PB y PA
hpb=load('filtro1.dat');
hpa=load('filtro2.dat');

%*** 7-3-1 *** Se puede obtener un filtro pasa banda utilizando un filtro pasa altos en serie con un pasa bajos.
%Es importante que la frecuencia de corte del filtro pasa bajos se mayor a la frecuencia de corte del
%pasa altos para que se solapen los espectros y existe una respuesta pasa banda.
%La obtención del kernel final se realiza convolucionando los kernels de los dos filtros.

hpbanda=conv(hpb,hpa);       
K=300; 
x=(0:K/2-1)*2/K;             %frecuencia digital.

%Graficamos la respuesta del filtro PBanda
stem(hpbanda);
title('Respuesta al impulso filtro pasa banda');

%*** 7-3-2 *** Graficar la respuesta en frecuencia. Superponer las respuestas de los filtros originales e identificar
% la frecuencia de corte 1 y 2.

%caculamos la respuesta en frecuencia
Hpb=fft(hpb,K);
Hpa=fft(hpa,K);
HPBANDA=fft(hpbanda,K);

Hpbdb=mag2db(abs(Hpb(1:K/2)));
Hpadb=mag2db(abs(Hpa(1:K/2)));
HPABANDAdb=mag2db(abs(HPBANDA(1:K/2)));

%buscamos las frecuencias de corte
f1Posicion=find(Hpadb>=-3);  %buscamos la posicion dentro de Hpadb donde la amplitud cae 3dB
f2Posicion=find(Hpbdb<=-3);  %buscamos la posicion dentro de Hpbdb donde la amplitud cae 3dB
f1=x(f1Posicion(1));         %buscamos el vaor correcpondiente a la frecuancia digital para f1
f2=x(f2Posicion(1));         %buscamos el vaor correcpondiente a la frecuancia digital para f2

%graficamos
figure
plot(x,Hpbdb,x,Hpadb,x,HPABANDAdb);
legend('Filtro pasa bajos','Filtro pasa altos', 'Filtro pasa banda')
title({strcat('fc1=',num2str(f1)),strcat('fc2=',num2str(f2))})

%*** 7-3-3 *** Obtener un filtro rechaza banda combinando el filtro1.dat y un filtro pasa altos obtenido mediante
% la reversión de este mismo filtro. y[n]=hpb[n]+hpa[n]

%leemos el kernel (respuesta al impulso) del PB
hpb=load('filtro1.dat');

%revertimos el kernel anterior para obtener un kernel PA
hpa=zeros(length(hpb),1);
for n=1:length(hpb)
   hpa(n)=(-1)^(n)*hpb(n);
end

%Obtenemos el kernel del filtro elimina banda
heb=hpa+hpb;      

K=300;
x=(0:K/2-1)*2/K;  %frecuencia digital.

figure;
stem(heb);
title('Respuesta al impulso del filtro elimina banda');

% *** 7-3-4 *** Graficar la respuesta en frecuencia. Superponer las respuestas de los filtros originales e identificar
% la frecuencia de corte 1 y 2.

%caculamos la respuesta en frecuencia del filtro
Hpb=fft(hpb,K);
Hpa=fft(hpa,K);
Heb=fft(heb,K);

Hpbdb=mag2db(abs(Hpb(1:K/2)));
Hpadb=mag2db(abs(Hpa(1:K/2)));
Hebdb=mag2db(abs(Heb(1:K/2)));

%buscamos las frecuencias de corte
f1Posicion=find(Hpbdb<=-3); 
f2Posicion=find(Hpadb>=-3);
f1=x(f1Posicion(1));
f2=x(f2Posicion(1));

%graficamos
figure;
plot(x,Hpbdb,x,Hpadb,x,Hebdb);
legend('Filtro pasa bajos','Filtro pasa altos', 'Filtro elimina banda');
title({strcat('fc1=',num2str(f1)),strcat('fc2=',num2str(f2))});








