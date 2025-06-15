%ft= (fpass+fstop)/2= 0.15 
%ventana rectangular
ft = 0.15;
M = 40; %M=4/0,1 que es el ancho de banda

for n=1:M
  hsinc(n)=ft*sinc(ft*(n-((M-1)/2))); %genero funcion sinc
end

vent1=rectwin(M); 

for i=1:M
    fil1(i) = hsinc(i) * vent1(i); %genero el filtro multiplicando miembro a miembro
end 

K=1000;
H = fft(fil1,K); %respuesta en frecuencia
figure('Name','respuesta al impulso','NumberTitle','off')
stem(fil1);

%Paso a frecuencia digital
Y1 = zeros(K/2,1);
X = zeros(K/2,1);

for i=1 : ((K/2)-1)
    Y1(i,1) = H(i);
end

for i=1 : ((K/2)-1)
    X(i,1) = i/(K/2);
end

%Grafico superposicion de pasabajos y pasa altos
figure('Name','Ventana rectangular','NumberTitle','off')
plot( X, 20*log(abs(Y1)));
ylabel('G (dB)')
xlabel('frecuencia normalizada')

