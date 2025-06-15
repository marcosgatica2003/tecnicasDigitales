N = 100;
f = 2;
x = (0:N-1)/N;

y1 = 1*sin(2*pi*1*x);
y2 = 0.5*sin(2*pi*3*x);
y3 = 0.25*sin(2*pi*5*x);
y4 = y1 + y2 + y3;
plot (x,y1)
hold all
plot (x,y2)
plot (x,y3)
plot (x,y4)

xlabel('Tiempo')
ylabel('Amplitud')
title('Seno')

legend('Y1','y2','y3','y4')