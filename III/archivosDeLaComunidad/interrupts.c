
#if defined(__XC16__)
    #include <xc.h>
#elif defined(__C30__)
    #if defined(__dsPIC33E__)
    	#include <p33Exxxx.h>
    #elif defined(__dsPIC33F__)
    	#include <p33Fxxxx.h>
    #endif
#endif

#include <stdint.h>       
#include <dsp.h>  
#include <stdbool.h>       

extern FIRStruct filtroFIR;  
/*Buffer del ADC1, con las muestras sin filtrar*/
extern unsigned int RightBufferA[32]__attribute__((space(dma)));
extern unsigned int RightBufferB[32]__attribute__((space(dma)));
/*Bufer donde se almacena las muestras filtradas*/
extern unsigned int LeftBufferA[32]__attribute__((space(dma)));
extern unsigned int LeftBufferB[32]__attribute__((space(dma)));

extern fractional taps[399]__attribute__((space(xmemory), aligned(1024)));
extern fractional delay[399]__attribute__((space(ymemory), far, aligned(1024)));

/*Interrupciones del DMA*/
//Interrupcion del timer
//void __attribute__((__interrupt__, no_auto_psv)) _T5Interrupt(void)
//{IFS1bits.T5IF = 0; }

void __attribute__((interrupt, no_auto_psv))_DMA0Interrupt(void){
    /* User Code to update Right Buffer in DMA*/
    IFS0bits.DMA0IF = 0; /* Borro el Flag de interrupción del canal 0 del DMA */
    
    return;  
}

void __attribute__((interrupt, no_auto_psv))_DMA1Interrupt(void){
    /* User Code to update Left Buffer in DMA */
    IFS0bits.DMA1IF = 0; /* Borro el Flag de interrupción del canal 1 del DMA */
    return;
}

//Interrupciones del DMA DMA para ADC
void __attribute__((interrupt, no_auto_psv))_DMA2Interrupt(void)  //DMA asignado al ADC
{
IFS1bits.DMA2IF = 0; 

if(DMACS1bits.PPST0 == 1) /*Estoy sobre el B*/
    {
        FIR(32, (fractional*)LeftBufferA, (fractional*)RightBufferA, &filtroFIR);   /*Aplico el filtro a A*/ 
        //cantdad de muestras, vector destino, vector origen, puntero a la estructura
    }
else//(DMACS1bits.PPST0 == 0)  /*Estoy sobre el A*/
    {
        FIR(32, (fractional*)LeftBufferB, (fractional*)RightBufferB, &filtroFIR);   /*Aplico el filtro a B*/
    } 
}




