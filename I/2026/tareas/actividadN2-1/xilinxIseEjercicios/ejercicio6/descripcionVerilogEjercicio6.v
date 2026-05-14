`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:15:18 05/14/2026 
// Design Name: 
// Module Name:    descripcionVerilogEjercicio6 
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
// Ejercicio 6 Actividad 2_1 - Marcos Raul Gatica - Leg. 402006 - 3R2 TD1

module descripcionVerilogEjercicio6(
    input inputW,
    input inputX,
    input inputY,
    input inputZ,
    output outputFunction
    );
	 assign outputFunction = inputY | inputW & inputX;


endmodule
