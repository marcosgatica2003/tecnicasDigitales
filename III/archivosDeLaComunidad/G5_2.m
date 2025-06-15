N = 100;
K = 100;
y = zeros(N,K);
for m = 0:K
    for n = 0:N
        if n < (N/2)
            y(n+1,m+1)=m*(n/(N/2));
        else
            y(n+1,m+1)=m*((N-n)/(N/2));
        end
    end
end
stem(y);
