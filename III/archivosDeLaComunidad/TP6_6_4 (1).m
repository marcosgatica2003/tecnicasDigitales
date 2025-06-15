%----- 6-4 ----- Filtro Diferenciador

%*** 6-4-1 ***Obtener los kernel de los filtros a partir de las ecuaciones mostradas y filtrar la señal del punto
%6.2.1 con los 3 filtros resultantes. Grabar la salida para cada uno e identificar de manera cualitativa
%escuchando la señal resultante el efecto del filtro sobre el espectro de frecuencias de la señal.
%Indicar las observaciones con comentarios en el código del script.

[r,Fs,nbit]=wavread('numeros.wav'); %leemos el archivo de audio y obtenemos r,Fs,nbit

a=size(r);              %obtenemos el tamaño del vector r
x1=zeros(1,a(1));   %creamos un vector x1 del mismo tamaño que r con ceros
x2=zeros(1,a(1));   %creamos un vector x2 del mismo tamaño que r con ceros
x3=zeros(1,a(1));   %creamos un vector x3 del mismo tamaño que r con ceros

%---------- derivada primera x'[n]=x[n]-x[n+1] ----------

for n=2:(a(1))
    x1(n)=r(n)-r(n-1);
end

%generacion archivo nuevo
wavwrite(x1,Fs,nbit,'6_4_1_Derivada1.wav');

%---------- derivada segunda x''[n]=x'[n]-x'[n-1] ----------

clear n;
for n=2:(a(1))
    x2(n)=x1(n)-x1(n-1);
end

%generacion archivo nuevo
wavwrite(x2,Fs,nbit,'6_4_1_Derivada2.wav');

%---------- derivada tercera x'''[n]=x''[n]-x''[n-1] ----------

clear n;
for n=2:(a(1))
    x3(n)=x2(n)-x2(n-1);
end
%generacion archivo nuevo
wavwrite(x3,Fs,nbit,'6_4_1_Derivada3.wav');

%A medida que se incrementa el orden de derivación se escuha que la señal va perdiendo graves, la derivacion 
%actua como un filtro pasa altos

%----------------------------------------------------------------------------------------------------

%---------- Otra forma de hacerlo ----------

%Kernel para los 3 filtros 

h1=zeros(1,2); %creamos vector de longitud 2 con ceros
h1(1)=1;
h1(2)=-1;

h2=zeros(1,3); %creamos vector de longitud 3 con ceros
h2(1)=1;
h2(2)=-2;
h2(3)=1;

h3=zeros(1,4); %creamos vector de longitud 4 con ceros
h3(1)=1;
h3(2)=-3;
h3(3)=3;
h3(4)=-1;

%---------- Hacemos la convolucion para los tres casos ---------
y1=conv(r,h1); %dericada primera
y2=conv(r,h2); %dericada segunda
y3=conv(r,h3); %dericada tercera

%generacion de los archivos de audio
wavwrite(y1,Fs,nbit,'6_4_1_Derivada1_conv.wav');
wavwrite(y2,Fs,nbit,'6_4_1_Derivada2_conv.wav');
wavwrite(y3,Fs,nbit,'6_4_1_Derivada3_conv.wav');

%Abre Filter Visualization Tool, aca podremos ver la respuesta en frecuencia del filtro.
fvtool(h1,1);
fvtool(h2,1); 
fvtool(h3,1);






