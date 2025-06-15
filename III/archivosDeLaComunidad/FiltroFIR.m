% heb = Num;
% save('FiltroFIR.dat', 'heb');
% Fs = 39062;
% fvtool (heb);

BT=300;
fs=39062;
Fc=3000;

bt=BT*2/fs;         %banda de transicion en frecuencia digital
fc=Fc*2/fs;         %frecuancia de corte en frecuencia digital

K=500;              %numeros de muestras
x=(0:K/2-1)*fs/K;   %frecuencia normal.

M=floor(8/bt);      %floor redondea el resultado de 8/bt a entero mas cercano

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

c=chebwin(-N1+N2+1);
hpb=zeros((-N1+N2+1),1); 

for n=(1:(-N1+N2+1))
    hpb(n)=s(n)*c(n);
end

Hpb = fft(hpb,K);

hpb_n = hpb/abs(Hpb(1))

del=zeros(size(hpb));
del(40)=1;

hpa = del-hpb;

Hpb = fft(hpb,K);
Hpa = fft(hpa,K);

Hpb_db = mag2db(abs(Hpb(1:K/2)));
Hpa_db = mag2db(abs(Hpa(1:K/2)));
figure;
plot(x,Hpb_db);
figure;
plot(x,Hpa_db);

