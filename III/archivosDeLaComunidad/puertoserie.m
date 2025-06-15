%fclose(dspic)
dspic = serial('COM3');
fopen(dspic)
%fprintf(s,'IDN*?')
A = fread(dspic,37)  %La cadena generada tiene 34 elementos. (0xAA, real[0], ..... , 0x55)
fclose(dspic)

