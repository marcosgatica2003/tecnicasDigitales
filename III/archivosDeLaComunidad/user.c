#if defined(__XC16__)
    #include <xc.h>
#elif defined(__C30__)
    #if defined(__dsPIC33E__)
    	#include <p33Exxxx.h>
    #elif defined(__dsPIC33F__)
    	#include <p33Fxxxx.h>
    #endif
#endif

#include <stdint.h>          /* For uint16_t definition                       */
#include <dsp.h>  
#include <stdbool.h>         /* For true/false definition                     */
#include "user.h"            /* variables/params used by user.c               */

extern FIRStruct filtroFIR; 
//extern fractional taps[];
//extern fractional delay[];

extern fractional taps[M]__attribute__((space(xmemory), aligned(256)));
extern fractional delay[M]__attribute__((space(ymemory), far, aligned(256)));
// Variables que tienen almacenadas la seno en memoria del DMA para sacarlas por el right DAC1
extern unsigned int RightBufferA[32]__attribute__((space(dma)));
extern unsigned int RightBufferB[32]__attribute__((space(dma)));

// Variables que almacenan los  valores de salida del ADC1 en memoria DMA
extern unsigned int LeftBufferA[32]__attribute__((space(dma)));
extern unsigned int LeftBufferB[32]__attribute__((space(dma)));

void InitApp(void)
{
     /*Inicialización de la estructura FIRStruct(5)*/
    filtroFIR.numCoeffs = M;  //Número de coeficientes del filtro (M))
    filtroFIR.coeffsBase = &taps[0];  // accede a la primer direccion de memoria
    filtroFIR.coeffsEnd =(int) filtroFIR.coeffsBase + 2*filtroFIR.numCoeffs -1 ;  //&taps[M]-1;;  // accede a la ultima direccion de memoria &taps[398]
    filtroFIR.coeffsPage= 0xFF00;  //Pagina de ubicacion de los coeficientes - Este valor es para la RAM
    filtroFIR.delayBase = &delay[0];   //Dirección inicial del vector de retardos
    filtroFIR.delayEnd =(int) filtroFIR.delayBase + 2*filtroFIR.numCoeffs -1;//&delay[M]-1;//&delay[398]; //(int) filtroFIR.delayBase + 2*filtroFIR.numCoeffs - 1;//  //Dirección final del vector de retardos
    filtroFIR.delay = &delay[0];            //Puntero a la posición actual del vector de retardos
    
    FIRDelayInit(&filtroFIR);   //(6)Inicializa a cero los valores del vector de retardo
  
    /***********Canal DMA 0  ***********/
 /* Periferico asociado al DMA0 el DAC1RDAT (transferencia derecha del DAC1)*/
    DMA0CONbits.AMODE = 0; /* Registro Indirecto con Incremento de Post */
    DMA0CONbits.MODE = 2; /* Modo continuo con ping-pong activado */
    DMA0CONbits.DIR = 1; /* Transferencia de datos Ram a Periféricos */
    DMA0PAD = (volatile unsigned int)& DAC1RDAT; /* Punto DMA a DAC1RDAT */
    DMA0CNT = 31; /* 32 DMA Solicitud */
    DMA0REQ = 78; /* Seleccione DAC1RDAT como origen de solicitud DMA. Tabla 38-1 Pag.15 */
    DMA0STA = __builtin_dmaoffset(LeftBufferA); 
    DMA0STB = __builtin_dmaoffset(LeftBufferB);
    IFS0bits.DMA0IF = 0; /* Clear DMA Interrupt Flag */
    IEC0bits.DMA0IE = 1; /* Set DMA Interrupt Enable Bit */
    DMA0CONbits.CHEN = 1; /* Enable DMA Channel 0 */
    
/***********Canal DMA 1**************/
    /* Periferico asociado al DMA1 el DAC1LDAT (transferenciaerecha izquierda del DAC1)*/
    DMA1CONbits.AMODE = 0; /* Register Indirect with Post Increment */
    DMA1CONbits.MODE = 2; /* Continuous Mode with Ping-Pong Enabled */
    DMA1CONbits.DIR = 1; /* Ram-to-Peripheral Data Transfer */
    DMA1PAD = (volatile unsigned int)&DAC1LDAT; /* Point DMA to DAC1LDAT */
    DMA1CNT = 31; /* 32 DMA Request */
    DMA1REQ = 79; /* Seleccione DAC1LDAT como origen de solicitud DMA. Tabla 38-1 Pag.15 */
    DMA1STA = __builtin_dmaoffset(LeftBufferA); 
    DMA1STB = __builtin_dmaoffset(LeftBufferB);
    
    IFS0bits.DMA1IF = 0; /* Clear DMA Interrupt Flag */
    IEC0bits.DMA1IE = 1; /* Set DMA Interrupt Enable Bit */
    DMA1CONbits.CHEN = 1; /* Enable DMA Channel 1 */
    
/***********Canal DMA 2**************/
    /* Periferico asociado al DMA2 el ADC1 (ADC1BUF0)*/
    DMA2CONbits.AMODE = 0; /* Register Indirect with Post Increment */
    DMA2CONbits.MODE = 2; /* Continuous Mode with Ping-Pong Enabled */
    DMA2CONbits.DIR = 0; /* Transfiere datos de periférico a RAM */
    DMA2PAD = (int)&ADC1BUF0; /*Definido para el ADC1 */
    /* Se toma la dirección del regstro ADC1BUF0*/
    DMA2CNT = 31;  /* 32 DMA Request */
    DMA2REQ = 13; /* Seleccion ADC1 como origen de solicitud DMA, 13=0x0300. Tabla 38-1 Pag.15*/
    DMA2STA = __builtin_dmaoffset(RightBufferA); 
    DMA2STB = __builtin_dmaoffset(RightBufferB);
    IFS1bits.DMA2IF = 0; /* Clear DMA Interrupt Flag */
    IEC1bits.DMA2IE = 1; /* Set DMA Interrupt Enable Bit */
    DMA2CONbits.CHEN = 1; /* Enable DMA Channel 0 */
    
/*----------------------------------------------------------*/

    /*Configuración del ADC - http://ww1.microchip.com/downloads/en/DeviceDoc/70183D.pdf*/
    AD1CON1bits.FORM = 11;   // Data Output Format: Signed Fraction (Q15 format)
    AD1CON1bits.SSRC = 100;   // CONF P/ TIMER 5
    AD1CON1bits.ASAM = 1;   // MUESTREO AUTOMATICO
    AD1CON1bits.AD12B = 1;  // 12-bit ADC operation
    AD1CON2bits.VCFG = 4;   //pone a Vdd y Vss como referencias (VCFG=1xx)
    AD1CON2bits.CHPS = 0;   // Converts channels CH0/CH1
    AD1CON3bits.ADRC = 0;   // ADC Clock is derived from Systems Clock
    AD1CON3bits.ADCS = 00001001;   // ADC Conversion Clock TAD = TCY * (ADCS + 1) (10)
    AD1CON1bits.ADDMABM = 1;    // DMA buffers are built in conversion order mode
    AD1CON2bits.SMPI = 0000 ;      // SMPI must be 0000() una sola muestra por incremento)
    //AD1CHS0/AD1CHS123: Analog-to-Digital Input Select Register
    AD1CHS0bits.CH0SA = 0;  // MUXA +ve input selection (AIN0) for CH0
    AD1CHS0bits.CH0NA = 0;  // MUXA -ve input selection (VREF-) for CH0
    //AD1PCFGH/AD1PCFGL: Port Configuration Register
    AD1PCFGL = 0xFFFF;      //COMO ES SECUENCIAL CONFIGURA EL An0 abajo
    AD1PCFGLbits.PCFG0 = 0; // AN0 as Analog Input
    IFS0bits.AD1IF = 0;     // Clear the Analog-to-Digital interrupt flag bit
    IEC0bits.AD1IE = 0;     // Do Not Enable Analog-to-Digital interrupt
    AD1CON1bits.ADON = 1;   // Turn on the ADC
/*-------------------------------------------------------------------------*/
    /*Configuracion Timer 5 - SINCRONO*/  
    T5CONbits.TON = 0;      // Disable Timer
    T5CONbits.TCS = 0;      // Select external clock source
    T5CONbits.TGATE = 0;    // Enable Synchronization
    T5CONbits.TCKPS = 0b00; // Select 1:1 Prescaler
    TMR5 = 0x00;            // Clear timer register
    PR5 = 0x03FF;           // Load the period value
    IPC7bits.T5IP = 0x01;   // Set Timer1 Interrupt Priority Level
    IFS1bits.T5IF = 0;      // Clear Timer1 Interrupt Flag
    IEC1bits.T5IE = 0;      // Enable Timer1 interrupt
    T5CONbits.TON = 1;      // Start Timer
/*--------------------------------------------------------*/   
    /* configuracion del DAC1. Uso el canal derecho para el seno que genero
     * usando DMA y el canal izquierdo para generar la señal a partir de los 
     * datos guardados en la DRAM por el ADC */
    DAC1STATbits.ROEN = 1;      /* Right Channel DAC Output Enabled */
    DAC1STATbits.LOEN = 1;      /* Left Channel DAC Output Enabled */
    DAC1STATbits.RITYPE = 1;    /* Right Channel Interrupt if FIFO is Empty */
    DAC1STATbits.LITYPE = 1;    /* Left Channel Interrupt if FIFO is Empty */
    DAC1CONbits.AMPON = 0;      /* Amplifier is Disabled During Sleep/Idle Modes */
    DAC1CONbits.DACFDIV = 3;    /* Divide Clock by 1 (Assumes Clock is 25.6MHz) - Esto lo modifique*/
    DAC1CONbits.FORM = 1;       // formato de datos signado
    DAC1CONbits.DACEN = 1;      /* DAC1 Module Enabled */
    //DAC1DFLT = 0x0000;          /* Cuando FIFO vacia registro en cero */
    
    
  }  




