%*** 7-4 *** Diseño de filtros pasa bajos mediante función sinc con ventana.

% Para diseñar un filtro pasa-bajas invertimos el procedimiento anterior. En lugar de escoger un
% conjunto de coeficientes y analizar su respuesta en frecuencia; primero determinamos su
% respuesta en frecuencia y después obtenemos los coeficientes que nos dan dicha respuesta.
% Los 2 métodos más populares para el diseño de filtro FIR son:
% 1. Método de Diseño por Ventanas.
% 2. Método Óptimo, también llamado Método de diseño de Intercambio de Remez oMétodo
% Parks-McClellan.

% Método de Diseño por Ventanas: En este método también llamado "El método de las series de Fourier" se siguen los siguientes pasos:
% 1. Definir las muestras individuales en el dominio de la frecuencia que representan H(m).
% 2. Aplicar la Transformada Inversa Discreta de Fourier (IDFT) para obtener la respuesta
% impulsional h(k).
% 3. Aplicar una ventana a la respuesta impulsional para mejorar la respuesta en frecuencia.
% 4. Evaluar la respuesta en frecuencia obtenida para ver si cumple con nuestros
% `requerimientos.

% Desde el punto de vista práctico de implementación por Hardware, mientras menos coeficientes
% se usen, más rápido se obtiene la respuesta y por lo tanto podemos trabajar con frecuencias más
% altas. Sin embargo, mientras más coeficientes usemos, la Respuesta en Frecuencia de nuestro
% filtro se parece más a la ideal.


%*** 7-4-1 *** Diseñar un filtro pasa bajos con frecuencia de corte en 3KHz y BT de 500Hz. Considerar una
% frecuencia de muestreo de 44.1KHz. Utilizar las siguientes ventanas Blackman (blackman), Kaiser (kaiser) ,Chebyshev (chebwin)

%Los pasos para diseñar un filtro pasa bajos son:

%1-Definir el número de taps. Este número va a depender de la banda de transición esperada y de la
%ventana utilizada. Una aproximación genérica que se puede utilizar independiente de la ventana es M=8/BT
% Donde M es la cantidad de taps y BT la banda de transición deseada del filtro expresado en
% frecuencia digital ( De 0 a 1)

BT=500;
fs=44100;
Fc=3000;

bt=BT*2/fs;         %banda de transicion en frecuencia digital
fc=Fc*2/fs;         %frecuancia de corte en frecuencia digital

K=500;              %numeros de muestras
x=(0:K/2-1)*fs/K;   %frecuencia digital

M=floor(8/bt);      %floor redondea el resultado de 8/bt a entero mas cercano

%2-Cálculo de la función sinc: La función sinc se calculará según la siguiente ecuación
% s[n]=sinc(n*fc) donde -(M-1)/2<n<(M-1)/2 si M es par y -M/2+1<n<M/2 si M
% es impar. Donde fc es la frecuencia de corte digital del filtro.

if (-1)^(M)==1      %M par
   N1=-M/2 +1;
   N2=M/2;
else                %M impar
    N1=-(M-1)/2;
    N2=(M-1)/2;
end

s=zeros((-N1+N2+1),1);
for n=(1:(-N1+N2+1))
    s(n)=sinc((n+N1)*fc);
end

%graficamos la funcion sync
figure;
stem(s);
title('Funcion sync');

% 2-Calculo de la ventana w[n]. Esto depende de la ventana en particular a usar y en general se
% encuentran disponibles como funciones en matlab.

b=blackman(-N1+N2+1); %retorna los coeficientes de la ventana blackman
k=kaiser(-N1+N2+1);   %retorna los coeficientes de la ventana kaiser
c=chebwin(-N1+N2+1);  %retorna los coeficientes de la ventana chebwin

% 3-Multiplicar punto a punto los elementos de la ventana w[n] por los elementos de la función sinc s[n]

hblackman=zeros((-N1+N2+1),1); 
hkaiser=zeros((-N1+N2+1),1); 
hChebyshev=zeros((-N1+N2+1),1); 
for n=(1:(-N1+N2+1))
    hblackman(n)=s(n)*b(n);
    hkaiser(n)=s(n)*k(n);
    hChebyshev(n)=s(n)*c(n);
end

% *** 7-4-2 *** Graficar la respuesta en frecuencia de los 3 filtros y determinar frecuencia de corte, atenuación de
% banda de stop y ripple en la banda de paso.

Hb=fft(hblackman,K);
Hk=fft(hkaiser,K);
Hc=fft(hChebyshev,K);

Hbdb=mag2db(abs(Hb(1:K/2)));
Hkdb=mag2db(abs(Hk(1:K/2)));
Hcdb=mag2db(abs(Hc(1:K/2)));

%----- Frecuencia de corte -----

%posicion de fc para cada filtro
fb_pos=find(Hbdb(1:(K/2))<=(max(Hbdb)-3));
fk_pos=find(Hkdb(1:(K/2))<=(max(Hkdb)-3));
fc_pos=find(Hcdb(1:(K/2))<=(max(Hcdb)-3));

f_b=x(fb_pos(1));
f_k=x(fk_pos(1));
f_c=x(fc_pos(1));

%----- Riple -----

%posicion del maximo para cada filtro
hbmax=find(Hbdb==max(Hbdb));    
hkmax=find(Hkdb==max(Hkdb));
hcmax=find(Hcdb==max(Hcdb));

%minimo de la banda de paso
mb=min(Hbdb(1:hbmax));  
mk=min(Hkdb(1:hkmax));
mc=min(Hcdb(1:hcmax));

%calculo del ripple
rb=max(Hbdb)-mb;        
rk=max(Hkdb)-mk;
rc=max(Hcdb)-mc;

%----- Atenuacion banda de stop o de rechazo -----

%maximo de la banda de stop
%se usa el elemento '10' para salir de la banda de transición.
Mb=max(Hbdb(fb_pos(10):K/2));    
Mk=max(Hkdb(fk_pos(10):K/2));    
Mc=max(Hcdb(fc_pos(10):K/2));

%atenuacion
ab=max(Hbdb)-Mb;    
ak=max(Hkdb)-Mk;
ac=max(Hcdb)-Mc;

figure;
plot(x,Hbdb,x,Hkdb,x,Hcdb);
legend(strcat('Filtro con ventana Blackman: fc=',num2str(f_b),',ripple=',num2str(rb),',at.=',num2str(ab)),strcat('Filtro con ventana Kaiser: fc=',num2str(f_k),',ripple=',num2str(rk),',at.=',num2str(ak)),strcat('Filtro con ventana Chebyshev: fc=',num2str(f_c),',ripple=',num2str(rc),',at.=',num2str(ac)));

% 7-4-3 Calcular un filtro pasa banda de 50 Hz, con BT de 1Hz y frecuencia de muestreo de 1KHz
% utilizando la ventana que provea el roll off mas pequeño. Graficar respuesta en frecuencia del
% filtro.

%Hay que diseñar un filtro pasa bajos y otro pasa altos para luego
%convolucionar sus muestras y asi obtener el filtro pasa banda buscado.

BT=1;
fs=1000;
Fc1=50;
Fc2=50;

bt=2*BT/fs;
fc1=Fc1*2/fs;
fc2=Fc2*2/fs;
K=1500;
x1=(0:K/2-1)*fs/K;

M=floor(8/bt); %calculo los taps del filtro

if rem(M,2)==0          %M es par
       N1=(-M/2)+1;
       N2=(M/2);
else                    %M es impar
        N1=-((M-1)/2);
        N2=(M-1)/2;
end

cheb=chebwin(-N1+N2+1); %ventana con menor roll off

%calculamos un filtro PB
hpb1=zeros((-N1+N2+1),1);
for i=(1:(-N1+N2+1))
    hpb1(i)=sinc((i+N1)*fc1)*cheb(i);
end

%calculamos un filtro PA. Primero calculamos hpb2 y luego con el método de inversión de espectro pasamos hpb2 a PA
hpb2=zeros((-N1+N2+1),1);
for i=(1:(-N1+N2+1))
    hpb2(i)=sinc((i+N1)*fc1)*cheb(i);
end

del=zeros(length(hpb2),1); 
del(5)=1;                    %retardo de 5 muestras 
hpa=del-hpb2;                

%creo el filtro pasa banda (reversión de espectro)
pasa_banda=conv(hpb1,hpa);
PASA_BANDA=fft(pasa_banda,K);
PASA_BANDA_db=mag2db(abs(PASA_BANDA(1:K/2)/PASA_BANDA(1)));

%graficamos
figure;
plot(x1,PASA_BANDA_db);
legend('Filtro pasa banda');
