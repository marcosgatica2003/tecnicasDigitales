% close all
L=1e5;          % Longitud de la simulación
N=31;           % Tamaño del filtro de ecualización
mu=1e-4;        % Velocidad de adaptación
sigma=0.01      % Ruido

% Inicialización de vectores
sr=zeros(1,N);
h_s=zeros(1,N);
h_s((N-1)/2)=4; %filtro pasa todo
x_s=zeros(1,L);
d=zeros(1,L);
e=zeros(1,L);

% Generación de símbolos aleatorios
x=(rand(1,L)>0.5)*2-1;

% Canal
h=[1 0.7 0.6 0.35 0.1 0.05 0.01];

% Filtrado de los símbolos por el canal
y=filter(h,1,x);

yo=y+randn(1,L)*sigma;

% Gráfica de respuesta en frecuencia del canal y el ecualizador
NFFT=128;
CH=fft(h,NFFT);
FC=fft(h_s,NFFT);
subplot(2,1,1)
h1=plot((0:NFFT/2-1)/NFFT*pi,20*log10(abs(FC(1:NFFT/2))));
set(h1,'linewidth',2)
hold all
h=plot((0:NFFT/2-1)/NFFT*pi,20*log10(abs(CH(1:NFFT/2))));
set(h,'linewidth',2)
xlabel('Frecuencia Normalizada','FontSize',20)
ylabel('Magnitud [dB]','FontSize',20)
h=legend('Respuesta del canal','Respuesta del filtro adaptivo')
set(h,'Fontsize',15)
axis tight
ylim([-10,30])
% Gr�fica de los s�mbolos recibidos
subplot(2,1,2)
h2=plot(yo(1:500),'.');
axis tight
ylim([-3,3])
xlim([0,499])
xlabel('Muestras','FontSize',20)
ylabel('Símbolos','FontSize',20)


%Bucle de procesamiento del receptor
for n=1:L

% Registro de desplazamiento
sr=[yo(n) sr(1:end-1)];

% Insertar filtrado de muestras con h_s (^h o h sombrero) para obtener x_s[n] (^x o x sombrero)
% ->
x_s(n)=sr*(h_s)';

% Señal de referencia obtenida a partir de x_s 
d(n)=(x_s(n)>0)*2-1;

% Señal de error
e(n)=x_s(n)-d(n);

% Insertar adaptacion de coeficientes para obtener los coeficientes actualizados de h_s
% ->

h_s=h_s-mu* e(n)* sr;
% Actualización de gráficos
if (mod(n,1000)==0)

subplot(2,1,1);
FC=fft(h_s,NFFT);
delete(h1);
h1=plot((0:NFFT/2-1)/NFFT*pi,20*log10(abs(FC(1:NFFT/2))),'b');
set(h1,'linewidth',2);
subplot(2,1,2);
ylim([-3,3])
h2=plot(x_s(n-499:n),'.');
drawnow

end
end
