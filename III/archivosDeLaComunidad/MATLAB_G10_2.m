%------------------------------------------------------------------
%------------------ Datos generales -------------------------------
N = 2;
fs = 39062;
Ts=1/fs;                         %Periodo de Muestreo
Nro_pulse_4s = 4/Ts;             %Nro de pulso para generada impulso de 4seg
impulse = zeros(Nro_pulse_4s,1); %Impulso de 4 segundos  
impulse(1) = 1;

%-----------------------------------------------------------------
%------------------ Filtro pasabajos 500Hz -----------------------
fc = 500;
fd = 2*(fc/fs);
Ripple_BP = 0.1;
[B1,A1] = cheby1(N,Ripple_BP,fd,'low'); 
resp_pb = filter(B1,A1,impulse); 
resp_pb = filter(B1,A1,resp_pb);  
resp_pb = filter(B1,A1,resp_pb);  
resp_pb = filter(B1,A1,resp_pb);
fft_pb = 20*log(abs(fft(resp_pb,4096)));  
    %--------------------------------------------------------------
    %-------------- Coeficientes ----------------------------------
    disp('Pasabajos B0,B1,-A1,B2,-A2,-A3')
    x = fi(B1(1),1,16,15);      s = ['0x' x.hex];  disp(s)
    x = fi(B1(2),1,16,15);      s = [',0x' x.hex]; disp(s) 
    x = fi(A1(1)*(-1),1,16,15); s = [',0x' x.hex]; disp(s) 
    x = fi(B1(3)*(-1),1,16,15); s = [',0x' x.hex]; disp(s)
    x = fi(A1(2)*(-1),1,16,15); s = [',0x' x.hex]; disp(s)
    x = fi(A1(3)*(-1),1,16,15); s = [',0x' x.hex]; disp(s) 


%-----------------------------------------------------------------
%------------------ Filtro pasaaltos 3KHz -----------------------
fc = 3000;
fd = 2*(fc/fs);
Ripple_BP = 0.1;
[B2,A2] = cheby1(N,Ripple_BP,fd,'high');
resp_pa = filter(B2,A2,impulse);
resp_pa = filter(B2,A2,resp_pa);  
resp_pa = filter(B2,A2,resp_pa);  
resp_pa = filter(B2,A2,resp_pa);  
fft_pa = 20*log(abs(fft(resp_pa,4096)));
    %--------------------------------------------------------------
    %-------------- Coeficientes ----------------------------------
    disp('Pasaaltos B0,B1,-A1,B2,-A2,-A3')
    x = fi(B2(1),1,16,15);      s = ['0x' x.hex];  disp(s)
    x = fi(B2(2),1,16,15);      s = [',0x' x.hex]; disp(s) 
    x = fi(A2(1)*(-1),1,16,15); s = [',0x' x.hex]; disp(s) 
    x = fi(B2(3)*(-1),1,16,15); s = [',0x' x.hex]; disp(s)
    x = fi(A2(2)*(-1),1,16,15); s = [',0x' x.hex]; disp(s)
    x = fi(A2(3)*(-1),1,16,15); s = [',0x' x.hex]; disp(s)

%-----------------------------------------------------------------
%------------------ Filtro pasabanda -----------------------------

%------------- Pasabajos ------------------
fc = 3000;
fd = 2*(fc/fs);
Ripple_BP = 0.1;
[B3,A3] = cheby1(N,Ripple_BP,fd,'low'); 
resp_pb = filter(B3,A3,impulse);
resp_pb = filter(B3,A3,resp_pb);  
resp_pb = filter(B3,A3,resp_pb);  
resp_pb = filter(B3,A3,resp_pb);
    %--------------------------------------------------------------
    %-------------- Coeficientes ----------------------------------
    disp('Pasabajos de pasabanda B0,B1,-A1,B2,-A2,-A3')
    x = fi(B3(1),1,16,15);      s = ['0x' x.hex];  disp(s)
    x = fi(B3(2),1,16,15);      s = [',0x' x.hex]; disp(s) 
    x = fi(A3(1)*(-1),1,16,15); s = [',0x' x.hex]; disp(s) 
    x = fi(B3(3)*(-1),1,16,15); s = [',0x' x.hex]; disp(s)
    x = fi(A3(2)*(-1),1,16,15); s = [',0x' x.hex]; disp(s)
    x = fi(A3(3)*(-1),1,16,15); s = [',0x' x.hex]; disp(s)
    
%------------- Pasa altos ---------------------
fc = 500;
fd = 2*(fc/fs);
[B4,A4] = cheby1(N,Ripple_BP,fd,'high');
resp_pbanda = filter(B4,A4,resp_pb);
resp_pbanda = filter(B4,A4,resp_pbanda);
resp_pbanda = filter(B4,A4,resp_pbanda);
resp_pbanda = filter(B4,A4,resp_pbanda);
fft_pbanda = 20*log(abs(fft(resp_pbanda,4096)));
    %--------------------------------------------------------------
    %-------------- Coeficientes ----------------------------------
    disp('Pasaaltos de psabanda B0,B1,-A1,B2,-A2,-A3')
    x = fi(B4(1),1,16,15);      s = ['0x' x.hex];  disp(s)
    x = fi(B4(2),1,16,15);      s = [',0x' x.hex]; disp(s) 
    x = fi(A4(1)*(-1),1,16,15); s = [',0x' x.hex]; disp(s) 
    x = fi(B4(3)*(-1),1,16,15); s = [',0x' x.hex]; disp(s)
    x = fi(A4(2)*(-1),1,16,15); s = [',0x' x.hex]; disp(s)
    x = fi(A4(3)*(-1),1,16,15); s = [',0x' x.hex]; disp(s)
 


ejeX = zeros(2048);                                                
for i=1:2048
    ejeX(i) = (i-1)*(fs/4095);
end
figure
plot(ejeX,fft_pb(1:2048));  
figure
plot(ejeX,fft_pa(1:2048));
figure
plot(ejeX,fft_pbanda(1:2048));











