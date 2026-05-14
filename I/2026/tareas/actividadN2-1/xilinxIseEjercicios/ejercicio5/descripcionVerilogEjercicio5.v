`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:01:36 05/14/2026 
// Design Name: 
// Module Name:    descripcionVerilogEjercicio5 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
// Ejercicio 5 Actividad 2_1 - Marcos Raul Gatica - Leg. 402006 - 3R2 TD1

module descripcionVerilogEjercicio5(
    input inputA,
    input inputB,
    input inputC,
    input inputD,
    output outputFunction
    );
	 assign outputFunction = inputC & (~inputA | inputB | inputD) | inputA & inputB & inputD;

endmodule
