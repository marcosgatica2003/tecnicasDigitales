`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:23:58 05/14/2026 
// Design Name: 
// Module Name:    descripcionVerilogEjercicio2 
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
// Ejercicio 2 Actividad 2_1 - Marcos Raul Gatica - Leg. 402006 - 3R2 TD1

module descripcionVerilogEjercicio2(
    input inputX,
    input inputY,
    input inputZ,
    output outputFunction
    );
	 assign outputFunction = inputZ | inputY;

endmodule
