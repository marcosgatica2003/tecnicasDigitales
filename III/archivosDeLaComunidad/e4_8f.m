clear all
close all
clc

%8.1

fs=256;   %frecuencia de muestreo
K=2+fs;   
f1=50;    %Frecuencia en Hz
F1=f1/(fs/2);   %Frecuencia digital
         
x=(0:K/2-1)*fs/K;  

[B,A]=butter(3,F1,'high');  %orden de filtro ,fc, tipo de filtro

%8.2
t=4*fs;         
impulso=zeros(1,t);     
impulso(1)=1;   
sfil=filter(B,A,impulso);   
SFIL=fft(sfil,K); 

for i=1 : ((K/2)-1)
    y(i,1) = SFIL(i);
    x(i,1) = i/(K/2);
end

figure(1)
plot( x*(fs/2), 20*log((abs(y))));
title('Filtro con BUTTER');
ylabel('G (dB)')
xlabel('frecuencia Hz')

%8.3 %8.4
frec=find(x>=(20/(fs/2)));   %20Hz
db=abs(20*log(abs(y(frec(1)))));    %nivel dB
c=1;                       

 figure(2)
 title('Etapas para llegar a la atenuación');
while (db <= 120)
    
    sfil=filter(B,A,sfil);                   
    SFIL=fft(sfil,K);                 %filtrado para obtener atenuacion        
    y=20*log10(abs(SFIL(1:K/2)));    
    frec=find(x>=(20/(fs/2)));
    db= abs(y(frec(1)));
    c= c + 1;
    hold all
    plot(x,y);
end

%8.5
[B,A]=cheby1(3,1,F1,'high');
sfil=filter(B,A,impulso);  
SFIL=fft(sfil,K);
yy=20*log10(abs(SFIL(1:K/2)));

figure(3)
plot( x,yy);
title('Filtro con CHEVYSHEV1');
ylabel('G (dB)')
xlabel('frecuencia Hz')
hold all

frec=find(x>=(20/(fs/2)));   %20Hz
db=abs(yy(frec(1)));    %nivel dB
c=1;                       

 figure(4)
 title('Etapas con CHEVISHEV1');
while (db <= 120)
    
    sfil=filter(B,A,sfil);                   
    SFIL=fft(sfil,K);                 %filtrado para obtener atenuacion        
    yy=20*log10(abs(SFIL(1:K/2)));    
    frec=find(x>=(20/(fs/2)));
    db= abs(yy(frec(1)));
    c= c + 1;
    hold all
    plot(x,yy);
end


[B,A]=cheby2(3,40,F1,'high');  
sfil=filter(B,A,impulso);     
SFIL=fft(sfil,K);       
y1=20*log10(abs(SFIL(1:K/2)));

figure(5);
 plot(x,y1);
 title('Filtro CHEVISHEV2');
ylabel('G (dB)')
xlabel('frecuencia Hz')
hold all

frec=find(x>=20/(fs/2));
db=abs(y1(frec(1)));
c=1;       

figure(6)
 title('Etapas con CHEVISHEV2');

while (db <= 120)
    sfil=filter(B,A,sfil);    
    SFIL=fft(sfil,K);      
    y1=20*log10(abs(SFIL(1:K/2)));
    frec=find(x>=20/(fs/2));
    db= abs(y1(frec(1)));
    c= c + 1;
    hold all;
    plot(x,y1);
end


[B,A]=ellip(3,1,180,F1,'high');  
sfil=filter(B,A,impulso);     
SFIL=fft(sfil,K);       
y2=20*log10(abs(SFIL(1:K/2)));
figure(7);
   plot(x,y2);
 title('Filtro ELLIP');
ylabel('G (dB)')
xlabel('frecuencia Hz')
hold all


frec=find(x>=20/(fs/2));
db= abs(y2(frec(1)));
c=1;  

figure(8)
 title('Etapas con ELLIP');
while (db <= 120)
    sfil=filter(B,A,sfil);    
    SFIL=fft(sfil,K);       
    y2=20*log10(abs(SFIL(1:K/2)));
    frec=find(x>=20/(fs/2));
    db= abs(y2(frec(1)));
    c= c + 1;
    hold all;
    plot(x,y2);
end
