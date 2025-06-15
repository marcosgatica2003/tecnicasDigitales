clear all;
close all;

[filtro,Fs]=audioread('s1_r1_b_cd.wav');
[audio,Fs1]=audioread('lamona.wav');
tic
x=audio;
h=filtro;
ha(1,:)=h(:,1);
hb(1,:)=h(:,2);
xa(1,:)=x(:,1);
xb(1,:)=x(:,2);
L=500000;

M=length(h);
lx=length(x);

r=rem(lx,L); %saca el resto entre la longitud de todas las muestras y la seccion L de ellas que voy a tomar en cada bloque
x1=[xa zeros(1,L-r)]; %completa con ceros para que entren todos los bloques y el resto sea cero
x2=[xb zeros(1,L-r)];
nr1=(length(x1))/L;
nr2=(length(x2))/L;


h1=[ha zeros(1,L-1)];
h2=[hb zeros(1,L-1)];
for k=1:nr1
    Ma(k,:)=x1(((k-1)*L+1):k*L); %Ma es un vector cuyas filas es el numero total de bloques a procesar y columnas contienen la porcion de datos a procesar
                                % (k-1)*L+1 me posiciona en el primer
                                % elemento del bloque que quiero copiar en
                                % Ma y va hasta k*L que me da el ultimo
                                % elemento
    Mb(k,:)=x2(((k-1)*L+1):k*L);
   
        Ma1(k,:)=[Ma(k,:) zeros(1,M-1) ]; %agrego al final de cada bloque M-1 ceros para permitir la expansion durante la convolucion
        Mb1(k,:)=[Mb(k,:) zeros(1,M-1) ];
    
     Ma2(k,:)=ifft(fft(Ma1(k,:)).*fft(h1)); %hago la transformada punto a punto inversa de la transformada de la matriz anterior (obtengo y1[n])
     Mb2(k,:)=ifft(fft(Mb1(k,:)).*fft(h2));
     
     Ma3(k,:)=[zeros(1,(k-1)*L) Ma2(k,:) zeros(1,(nr1-k)*L)];
     Mb3(k,:)=[zeros(1,(k-1)*L) Mb2(k,:) zeros(1,(nr2-k)*L)];
     
end

ya=sum(Ma3);
yb=sum(Mb3);

y(:,1)=ya;
y(:,2)=yb;

sound(y,Fs);



