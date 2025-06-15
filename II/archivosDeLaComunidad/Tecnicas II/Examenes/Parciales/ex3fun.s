.text
.arm
.global _start
_start:
       b reset
       b loop
       b loop
       b loop
       b loop
       nop
       b loop
       b loop

/* ==============================
*  TEST CODE
arm-elf-eabi-as -mcpu=arm7tdmi -g ex3fun.s -o ex3fun.o
arm-elf-eabi-ld -Ttext=0 -g ex3fun.o -o ex3fun.elf 

arm-elf-eabi-gdb --tui

target sim
file ex3fun.elf
load 
*  ==============================
*/
 reset:
         mov r1,#0
         mov r2,#VECT
 	
 
 otro: 	ldrb r3,[r2]
	b Func
/* 	
	cmp r3,#0 		
 	beq salir		
 	cmp r3,#'a'		
 	subhs r3,r3,#('a'-'A') 
 	strb r3,[r2]
 	add r2,r2,#1        
*/

cont2: 	b otro

Func:	cmp r3,#0 		
 	beq salir		
 	cmp r3,#'a'		
 	subhs r3,r3,#('a'-'A') 
 	strb r3,[r2]
 	add r2,r2,#1
	b cont2



 salir:
 
 loop:   b loop
 
 /* ==============================
 *  CONTANTES
 *  ==============================
 */
 VECT:	.asciz "hoLa mundo"
         .balign 4

         .end

