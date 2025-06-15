#include <DueTimer.h>

   int n=0;
   int guardar=0;
   int i=0;
   int j=0;
   float promedio=0;

   
volatile unsigned long vector=0;

//  variables que cambiarán de valor.
int estadoLed = LOW;   // ledState se usará para establecer el estado del LED

long previoMillis = 0;   // almacenará la última vez que el estado del LED


long intervalo = 500;   // intervalo del parpadeo (en milisegundos)
                        // la siguiente variable es del tipo long por que el tiempo medido en
                       
 void setup(void) 
     {
          pinMode(53,INPUT);
          pinMode(50,INPUT);
          pinMode(47,INPUT);
          pinMode(52,OUTPUT);
          pinMode(13, OUTPUT);
    
          Timer3.attachInterrupt (interrupcion) .setFrequency (100) .start (); 
          Serial.begin(9600);
     
      }      


void interrupcion()
   {  
       vector = analogRead(A5);    
   }


void loop(void)
    {   
      unsigned long contadorMillis = millis();    // Se toma el tiempo actual

      // se comprueba si el tiempo actual menos el tiempo en que el LED cambió
      // de estado por última vez es mayor que el intervalo
      if (contadorMillis - previoMillis > intervalo)
            { 
                  // Si se cumple la condición se guarda el nuevo tiempo
                  // en el que el LED cambia de estado
                  previoMillis = contadorMillis;
        
                  // Y ahora cambiamos de estado el LED, si está encendido a
                  // apagado o viceversa.
              if (estadoLed== LOW)
                  estadoLed = HIGH;
              else
                  estadoLed = LOW;
        
                // Hacemos que el contenido de la variable llegue al LED
                digitalWrite(13, estadoLed);
            }
              

     unsigned long muestras;      // Haremos copia de interrupcion
     noInterrupts();
     // Suspende las interrupciones
     muestras=vector;
     interrupts();              // Autoriza las interrupciones               

      
      
      int subir = digitalRead(53);
      int bajar = digitalRead(50);
      int mostrar=digitalRead(47);
      
      if(subir==HIGH)
        {  if(n<100)
              {n=n+1;}
        }
    
       if(bajar==HIGH)
        {  if(n>0)
              {n=n-1;}
        }
   
    int voltaje = ( muestras * 100 / 1023);

   if(voltaje==n  || voltaje==(n-1)   ||  voltaje==(n+1))
       {  digitalWrite(52, HIGH); 
       } 
     else 
      {  digitalWrite(52, LOW); 
      } 

 
    
    
    
    if(mostrar==HIGH) 
       {guardar=voltaje;}
         
            Serial.print("Valor Instantanero: ");                                   Serial.print("     Valor Guardado:");                                                      Serial.println("     Valor de Comparacion :");                                                            
            Serial.print("\t");Serial.print (voltaje);Serial.print("\t");           Serial.print("\t");Serial.print("\t");  Serial.print (guardar);Serial.print("\t");         Serial.print("\t");  Serial.print("\t");   Serial.print (n); Serial.println("\t");          

     
             
     delay(200) ;
         
    }
