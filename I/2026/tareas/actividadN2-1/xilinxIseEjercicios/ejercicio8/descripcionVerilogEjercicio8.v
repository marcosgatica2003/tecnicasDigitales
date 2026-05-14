`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:45:07 05/14/2026 
// Design Name: 
// Module Name:    descripcionVerilogEjercicio8 
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

// Ejercicio 8 Actividad 2_1 - Marcos Raul Gatica - Leg. 402006 - 3R2 TD1

module descripcionVerilogEjercicio8(
    input inputA,
    input inputB,
    input inputC,
    input inputD,
    output outputFunction
    );
	 assign outputFunction = (inputA | inputC | inputD) & (inputA | ~inputB | ~inputC) & (~inputA | ~inputB | ~inputD) & (~inputA | inputB | inputC);


endmodule
