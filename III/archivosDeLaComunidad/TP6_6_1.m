%----- 6-1 ----- Convolucion muestra a muestra mediante bucle FOR

% Crear un programa que permita realizar la convolución entres una señal de x longitud L con un
% kernel h de longitud N utilizando un bucle FOR, de acuerdo a la ecuación de la convolución y
% donde

%logitud de las señales
L=10; %señales
N=10; %kernel 

x=zeros(1,L); 
h=zeros(1,N);

%inicializamos las señales segun el enunciado
for n=1:N
    h(n) = 1;
end

for n=1:L
    x(n) = exp(-(n-1)/2);
end

%metodo con funcion conv
w=conv(x,h);

%graficamos
hold all;
stem(w);
title('Metodo con funcion conv');

%inicializamos a cero 'y' (resultado de la conv.) y el registro de
%desplazamiento
y=zeros(1,L+N-1);
sr = zeros(1,N);  

x = [x zeros(1,N)];

%metodo con for
for n=1:L+N-1 
    sr = [x(n) sr(1:N-1)];  %actualizo el sr, concatenando el elemento actual de la entrada
    for i=1:N
       y(n)= y(n) + sr(i)*h(i); %aca se produce la sumatoria.
    end
     
end

%graficamos
figure;
stem(y);
title('Metodo con dos for');

%inicializamos a cero nuevamente para volver a graficar
y=zeros(1,L+N-1); 
sr = zeros(1,N);

%metodo matricial
for n=1:L+N-1 
    sr = [x(n) sr(1:N-1)];
    y(n)=sr*h'; 
end

%graficamos
figure;
stem(y);
title('Metodo Matricial');

figure;
stem(x);
title('Señal de entrada');
figure;
stem(h);
title('Kernel del filtro');


