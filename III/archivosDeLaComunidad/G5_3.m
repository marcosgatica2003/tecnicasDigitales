N = 100;
K = 200;
f = 2;
x = (0:N-1)/N;

y1 = zeros(N,K);
y2 = zeros(N,K);
y3 = zeros(N,K);

y1_0 = zeros(N,1);
y2_0 = zeros(N,1);
y3_0 = zeros(N,1);

for m = 1:K
    for n = 0:N-1
        if rem(m,2) == 1
            y1(n+1,m) = (8/(m*m*pi))*(-1)^((m-1)/2)*sin((2*m*f*pi*n)/N);
            y2(n+1,m) = (4/(m*pi))*sin((2*m*f*pi*n)/N);
        else
            y1(n+1,m) = 0;
            y2(n+1,m) = 0;
        end
        y3(n+1,m) = (1/(m*pi))*sin((2*m*f*pi*n)/N);
    end
end

for n = 0:N-1
    for m = 1:K
        y1_0(n+1) = y1(n+1,m) + y1_0(n+1);
        y2_0(n+1) = y2(n+1,m) + y2_0(n+1);
        y3_0(n+1) = y3(n+1,m) + y3_0(n+1);
    end
end

plot (x,y1_0)
figure
plot (x,y2_0)
figure
plot (x,y3_0)



