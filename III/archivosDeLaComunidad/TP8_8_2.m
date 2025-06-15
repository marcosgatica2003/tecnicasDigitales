%*** 8-2  *** Respuesta al impulso de un filtro IIR y filtros en cascada

%*** 8-2-2 ***  Utilizando la función butter, obtener los coeficientes de un filtro IIR pasa-altos, de orden 3, con
%frecuencia de corte en 50Hz.

%La función butter diseña filtros Butterwoth pasa-bajas, pasa-altas, pasa-bandas y rechaza bandas tanto en forma digital como analógica.
%Este filtro se caracteriza por una respuesta plana en la banda de transición.


Fs=256;            %Frecuencia de muestreo
Fc=50;             %Frecuencia de corte en Hz
fc=Fc*2/Fs;        %Frecuencia de corte digital
K=2000;            %Numero de muestras
x=(0:K/2-1)*Fs/K;  %Eje de frecuencias digitales


[B,A]=butter(3,fc,'high');  %orden,frec corte, tipo


%*** 8.2.2 *** Generar una función impulso con longitud total de 4 segundos y obtener la respuesta del filtro
%mediante la función filter. Convertir la respuesta a frecuencia y graficar la respuesta del filtro.


%creamos función impulso de longitud de 4 seg
L=4*Fs;         
i=zeros(1,L);     
i(1)=1;        
%i(L)=1;       

%aplico el filtro a la señal
h_pa=filter(B,A,i);   

%pasamos al dominio de la frecuencia
H_pa=fft(h_pa,K);      
y_pa=20*log10(abs(H_pa(1:K/2)));


%graficamos
figure(1);
    plot(x,y_pa);
    title('Respuesta en frecuencia del pasa altos Butter');
    xlabel('Frecuencia');
    ylabel('Amplitud [dB]');
    grid;
    hold all;

%*** 8.2.3 *** Determinar la cantidad de etapas mínimas necesarias para obtener una atenuación mayor o igual a
%120dB a 20Hz..

%*** 8.2.4 *** Tomar la respuesta al impulso del punto 8.2.2 y filtrarlo sucesivamente hasta completar la cantidad
%de etapas del punto 8.2.3. Graficar en cada iteración la respuesta en frecuencia.

x_20=find(x>=20);                  %buscamos la posicion de la frecuancia de de 20hz 
atenuacion= abs(y_pa(x_20(1)));    %obtenemos la atenuacion en la posicion guardada anteriormente
cont=1;                            %contador para llevar el numero de etapas

while (atenuacion <= 120)
    %aplico el filtro a la señal impulso asi obtengo la respuesta el impulso...
    h_pa=filter(B,A,h_pa);                    
    %lo paso al dominio de la frecuencia
    H_pa=fft(h_pa,K);                         
    y_pa=mag2db(abs(H_pa(1:K/2)));
    %buscamos la posicion de la frecuancia de de 20hz 
    x_20=find(x>=20);
    %obtenemos la atenuacion en la posicion guardada anteriormente
    atenuacion= abs(y_pa(x_20(1)));
    %incrementamos el contador
    cont= cont + 1;
    hold all;
    plot(x,y_pa);
end
legend(strcat('Etapas necesarias para lograr una atenuacion de 120dB con butter=',num2str(cont))); 

%*** 8.2.5 *** Repetir los puntos 8.2.1 a 8.2.4 para filtros de chebyshev de tipo 1 y 2 y filtro elíptico, generados
%mediante las funciones cheby1, cheby2 y ellip. El ripple en banda de paso máximo en todos
%los casos será de 1 dB y el ripple en banda de stop queda a consideración del alumno.

% ---------------- Cheby 1 ----------------

%[b,a] = cheby1(n,Rp,Wp,ftype) designs a lowpass, highpass, bandpass, or bandstop Chebyshev Type I filter, depending on the value of ftype and the number of elements of Wp. 
%The resulting bandpass and bandstop designs are of order 2n.
%n — Filter order
%Rp — Peak-to-peak passband ripple
%Wp — Passband edge frequency
%ftype — Filter type

[B,A]=cheby1(3,1,fc,'high');  %orden, ripple, frec corte, tipo

%aplico el filtro a la señal impulso asi obtengo la respuesta el impulso
h_pa=filter(B,A,i);  

%lo paso al dominio de la frecuencia
H_pa=fft(h_pa,K);       
y_pa=mag2db(abs(H_pa(1:K/2)));

%graficamos
figure(2);
    plot(x,y_pa);
    title('Respuesta en frecuencia del pasa altos Cheby1');
    xlabel('Frecuencia');
    ylabel('Amplitud [dB]');
    grid;
    hold all;

%Determinación de las etapas necesarias para atenuacion de -120 dB en 20Hz
x_20=find(x>=20);
atenuacion= abs(y_pa(x_20(1)));
cont=1;          %contador para llevar el numero de etapas

while (atenuacion <= 120) 
    h_pa=filter(B,A,h_pa); 
    H_pa=fft(h_pa,K);
    y_pa=mag2db(abs(H_pa(1:K/2)));
    x_20=find(x>=20);
    atenuacion= abs(y_pa(x_20(1)));
    cont= cont + 1;
    hold all;
    plot(x,y_pa);
end
legend(strcat('Etapas necesarias para lograr una atenuacion de 120dB con Cheby 1=',num2str(cont)));


% ---------------- Cheby 2 ----------------

%cheby2(n,Rs,Ws,ftype) designs a lowpass, highpass, bandpass, or bandstop Chebyshev Type II filter, depending on the value of ftype and the number of elements of Ws. 
%The resulting bandpass and bandstop designs are of order 2n.
%n — Filter order
%Rs — Stopband attenuation
%Ws — Stopband edge frequency
%ftype — Filter type

[B,A]=cheby2(3,40,fc,'high');  

h_pa=filter(B,A,i);     
H_pa=fft(h_pa,K);       
y_pa=mag2db(abs(H_pa(1:K/2)));
figure(3);
    plot(x,y_pa);
    title('Respuesta en frecuencia del pasa altos - Cheby2');
    xlabel('Frecuencia');
    ylabel('Amplitud [dB]');
    grid;
    hold all;

%Determinación de las etapas necesarias para atenuacion de -120 dB en 20Hz
x_20=find(x>=20);
atenuacion= abs(y_pa(x_20(1)));
cont=1;          

while (atenuacion <= 120)
    h_pa=filter(B,A,h_pa);    
    H_pa=fft(h_pa,K);      
    y_pa=20*log10(abs(H_pa(1:K/2)));
    x_20=find(x>=20);
    atenuacion= abs(y_pa(x_20(1)));
    cont= cont + 1;
    hold all;
    plot(x,y_pa);
end
legend(strcat('Etapas necesarias para lograr una atenuacion de 120dB con Cheby 2=',num2str(cont)));

%---------------- Ellip ----------------

%[b,a] = ellip(n,Rp,Rs,Wp,ftype) designs a lowpass, highpass, bandpass, or bandstop elliptic filter, depending on the value of ftype and the number of elements of Wp. 
%The resulting bandpass and bandstop designs are of order 2n.
%n — Filter order
%Rp — Peak-to-peak passband ripple
%Rs — Stopband attenuation
%Wp — Passband edge frequency
%ftype — Filter type

[B,A]=ellip(3,1,180,fc,'high');  

h_pa=filter(B,A,i);     
H_pa=fft(h_pa,K);       
y_pa=20*log10(abs(H_pa(1:K/2)));
figure(4);
    plot(x,y_pa);
    title('Respuesta en frecuencia del pasa altos - Ellip');
    xlabel('Frecuencia');
    ylabel('Amplitud [dB]');
    grid;
    hold all;

%Determinación de las etapas necesarias para atenuacion de -120 dB en 20Hz
x_20=find(x>=20);
atenuacion= abs(y_pa(x_20(1)));
cont=1;         

while (atenuacion <= 120)
    h_pa=filter(B,A,h_pa);    
    H_pa=fft(h_pa,K);       
    y_pa=mag2db(abs(H_pa(1:K/2)));
    x_20=find(x>=20);
    atenuacion= abs(y_pa(x_20(1)));
    cont= cont + 1;
    hold all;
    plot(x,y_pa);
end
legend(strcat('Etapas necesarias para lograr una atenuacion de 120dB con Ellip=',num2str(cont)));





