%****** 5.2 ****** Bucles FOR, condicionales y creaci�n de arreglos

% ****** 5.2.1 ****** Hacer click en File ? New ? M-File, para crear un nuevo programa.
% ****** 5.2.2 ****** Crear un bucle FOR de 10 copiando las siguientes l�neas y luego ejecutar el c�digo

% Crea arreglo de 1 fila y 100 columnas
y=zeros(100,1);

for n=0:99                 % Para n que va de 0 a 99
    if n<50
        y(n+1)=n/50;       % Se guarda n/50 en la posici�n n+1
    else
        y(n+1)=(100-n)/50; % Se guarda (100n)/50 en pos. n +1
    end
end

%graficamos
stem(y);

