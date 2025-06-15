fc=50;                                                                      %Frec de Corte
fs=256;                                                                     %Frec de Sample
N=3;                                                                        %Orden de Filtro
Wn=fc/(fs/2);                                                               %Frec Normalizada
Ts=1/fs;                                                                    %Periodo de Muestreo
Nro_pulse_4s = 4/Ts;                                                        %Nro de pulso para generada impulso de 4seg
impulse = zeros(Nro_pulse_4s,1);                                            %Impulso de 4 segundos  
impulse(1) = 1;
%--------------------------------------------------------------------------
%    FILTRO BUTTER
%--------------------------------------------------------------------------
[B,A] = butter(N,Wn,'high');                                                %Obtencion de los coeficientes del filtro
resp_impulse = filter(B,A,impulse);                                         %Respuesta del filtro
fft_resp_impulse = fft(resp_impulse,1024);                                  %Respuesta en frecuencia
fft_resp_impulse_module = abs(fft_resp_impulse);                            %Obtencion del modulo de la fft
fft_Butter = 20*log(fft_resp_impulse_module);                               %Modulo de la fft expresada en base logaritmica
%    FILTRO BUTTER DE DOS ETAPAS
resp_impulse = filter(B,A,resp_impulse);         
fft_Butter_2Et = 20*log(abs(fft(resp_impulse,1024)));          
%--------------------------------------------------------------------------
%    FILTRO CHEBY1
%--------------------------------------------------------------------------
R = 1;                                                                      %R = decibels of peak-to-peak ripple in the passband
[B,A] = cheby1(N,R,Wn,'high');                 
resp_impulse = filter(B,A,impulse);          
fft_Cheby1 = 20*log(abs(fft(resp_impulse,1024)));
%    FILTRO CHEBY1 DE DOS ETAPAS
resp_impulse = filter(B,A,resp_impulse);         
fft_Cheby1_2Et = 20*log(abs(fft(resp_impulse,1024)));  
%--------------------------------------------------------------------------
%    FILTRO CHEBY2
%--------------------------------------------------------------------------
R = 20;                                                                     %R = decibels down ripple of the stopband 
[B,A] = cheby2(N,R,Wn,'high');                
resp_impulse = filter(B,A,impulse);         
fft_Cheby2 = 20*log(abs(fft(resp_impulse,1024)));  
%    FILTRO CHEBY2 DE DOS ETAPAS
resp_impulse = filter(B,A,resp_impulse);         
fft_Cheby2_2Et = 20*log(abs(fft(resp_impulse,1024))); 
%    FILTRO CHEBY2 DE TRES ETAPAS
resp_impulse = filter(B,A,resp_impulse);         
fft_Cheby2_3Et = 20*log(abs(fft(resp_impulse,1024))); 
%--------------------------------------------------------------------------
%    FILTRO ELLIP
%--------------------------------------------------------------------------
Rp = 1;                                                                     %Rp = decibels of peak-to-peak ripple and
Rs = 20;                                                                    %a minimum stopband attenuation of Rs decibels.
[B,A] = ELLIP(N,Rp,Rs,Wn,'high');                 
resp_impulse = filter(B,A,impulse);         
fft_Ellip = 20*log(abs(fft(resp_impulse,1024)));
%    FILTRO ELLIP DE DOS ETAPAS
resp_impulse = filter(B,A,resp_impulse);         
fft_Ellip_2Et = 20*log(abs(fft(resp_impulse,1024))); 
%    FILTRO ELLIP DE TRES ETAPAS
resp_impulse = filter(B,A,resp_impulse);         
fft_Ellip_3Et = 20*log(abs(fft(resp_impulse,1024)));
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
ejeX = 0:(Nro_pulse_4s/2)-1;                                                %Eje X normalizado (de 0 a 511)
ejeX = ejeX*(fs/2)/(Nro_pulse_4s/2);                                        %Eje X en Hz (de 1 a fs)
hold
plot(ejeX , fft_Butter(1:512),'b');
plot(ejeX , fft_Butter_2Et(1:512),'b');   
plot(ejeX , fft_Cheby1(1:512),'r');
plot(ejeX , fft_Cheby1_2Et(1:512),'r');
plot(ejeX , fft_Cheby2(1:512),'g');
plot(ejeX , fft_Cheby2_2Et(1:512),'g');
plot(ejeX , fft_Cheby2_3Et(1:512),'g');
plot(ejeX , fft_Ellip(1:512),'m');
plot(ejeX , fft_Ellip_2Et(1:512),'m');
plot(ejeX , fft_Ellip_3Et(1:512),'m');
%--------------------------------------------------------------------------
%FILTRO BUTTER  -62 dB   en 20Hz (1 Etapa)
%FILTRO BUTTER  -124dB   en 20Hz (2 Etapas)

%FILTRO CHEBY1  -74 dB   en 20Hz (1 Etapa)
%FILTRO CHEBY1  -148 dB  en 20Hz (2 Etapas)

%FILTRO CHEBY2  -48 dB   en 20Hz (1 Etapa)
%FILTRO CHEBY2  -97 dB   en 20Hz (2 Etapas)
%FILTRO CHEBY2  -145 dB  en 20Hz (3 Etapas)

%FILTRO ELLIP   -46 dB   en 20Hz (1 Etapa)
%FILTRO ELLIP   -95 dB   en 20Hz (2 Etapas)
%FILTRO ELLIP   -142 dB  en 20Hz (3 Etapas)
