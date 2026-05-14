`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:33:29 05/14/2026 
// Design Name: 
// Module Name:    descripcionVerilogEjercicio7 
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
// Ejercicio 7 Actividad 2_1 - Marcos Raul Gatica - Leg. 402006 - 3R2 TD1

module descripcionVerilogEjercicio7(
    input inputA,
    input inputB,
    input inputC,
    input inputD,
    output outputFunction
    );
	 assign outputFunction = ~inputD | inputA & (~inputB);


endmodule
