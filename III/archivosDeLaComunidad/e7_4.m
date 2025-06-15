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
L=200000;



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
    Ma(k,:)=x1(((k-1)*L+1):k*L);%Ma es un vector cuyas filas es el numero total de bloques a procesar y columnas contienen la porcion de datos a procesar
                                % (k-1)*L+1 me posiciona en el primer
                                % elemento del bloque que quiero copiar en
                                % Ma y va hasta k*L que me da el ultimo
                                % elemento
    Mb(k,:)=x2(((k-1)*L+1):k*L);
    if k==1
        Ma1(k,:)=[zeros(1,M-1) Ma(k,:)];
        Mb1(k,:)=[zeros(1,M-1) Mb(k,:)];
    else 
        Ma1(k,:)=[Ma(k-1,(L-M+2):L) Ma(k,:)];
        Mb1(k,:)=[Mb(k-1,(L-M+2):L) Mb(k,:)];
    end
     Ma2(k,:)=ifft(fft(Ma1(k,:)).*fft(h1));
     Mb2(k,:)=ifft(fft(Mb1(k,:)).*fft(h2));
end
Ma3=Ma2(:,M:(L+M-1));
Mb3=Mb2(:,M:(L+M-1));
y1=Ma3';
y2=Mb3';
ya=y1(:)';
yb=y2(:)';
y(:,1)=ya;
y(:,2)=yb;
toc
 sound(y,Fs); 
 
 