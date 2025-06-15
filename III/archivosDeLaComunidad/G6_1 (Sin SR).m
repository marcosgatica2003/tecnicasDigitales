L = 50;
N = 60;

x = zeros(L,1);
h = ones(N,1);
y = zeros(N+L-1,1);

for n=1:L
    x(n,1)=exp(-n/2);
end


for n=1: L
    for i=1:N
        y(n+i-1,1)=y(n+i-1,1)+x(n,1)*h(i,1);
    end
end

figure
plot(y);

hold all
figure
plot(conv(x,h));