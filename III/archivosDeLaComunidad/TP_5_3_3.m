% ****** 5.3.3 ****** Modificar las ecuaciones para introducir un parámetro de frecuencia y volver a graficar el punto
% 5.3.2 para f=2;

N = 100;
K = 50;
f = 2;
Y1 = zeros(N,K);
Y2 = zeros(N,K);
Y3 = zeros(N,K);
x=(0:N-1)/N;

Ytotal1 = zeros(N,1);
Ytotal2 = zeros(N,1);
Ytotal3 = zeros(N,1);

for k=1:K;
  for n=1:N;
    if (-1)^k < 1
      Y1(n,k)= 8*(-1)^((k-1)/2)/(pi*k^2)*sin(2*k*pi*f*n/N);
      Y2(n,k)= (4/pi)*(1/k)*sin(2*k*pi*f*n/N);
    end
    Y3(n,k)= (-1/pi)*(1/k)*sin(2*k*pi*f*n/N);
  end
end

for k=1:K;
  for n=1:N;
    Ytotal1(n,1) = Ytotal1(n,1) + Y1(n,k);
    Ytotal2(n,1) = Ytotal2(n,1) + Y2(n,k);
    Ytotal3(n,1) = Ytotal3(n,1) + Y3(n,k);
      end
end

hold all;
plot(Ytotal1);
plot(Ytotal2);
plot(Ytotal3);      