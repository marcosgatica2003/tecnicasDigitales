L = 10;                 %Longitud de señal de entrada
N = 10;                 %Longitud del kernel
x = zeros(1,L);         %Señal de entrada
h = ones(1,N);          %Kernel
y = zeros(1,L+N-1);     %Señal de salida
delay = zeros(1,N);     %Registro de desplazamiento

for n = 1:L
    x(1,n) = exp(-n/2);                 %Asignacion de valores a x
end
x = [x zeros(1,N)];                     %Concatenación (extension del vector)

for n = 1:N+L-1
    delay = [x(1,n) delay(1:N-1)];     %Actualizacion del reg de despl
   for i = 1:N
     y(1,n) = y(1,n) + delay(1,i) * h(1,i);     %Convolucion de señal desplazada con kernel
   end
end

a =conv(x,h);    %Vertor para Comprobacion
 
figure('Name','Salida del filtro','NumberTitle','off')
hold all
plot(y);
plot(a);
legend('Con for','Con conv')
ylabel('Amplitud')
xlabel('Tiempo')