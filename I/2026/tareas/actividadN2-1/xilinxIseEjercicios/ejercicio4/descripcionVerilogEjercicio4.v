`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:50:59 05/14/2026 
// Design Name: 
// Module Name:    descripcionVerilogEjercicio4 
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
// Ejercicio 4 Actividad 2_1 - Marcos Raul Gatica - Leg. 402006 - 3R2 TD1

module descripcionVerilogEjercicio4(
    input inputX,
    input inputY,
    input inputZ,
    output outputFunction
    );
	 assign outputFunction = inputX | inputY & inputZ;

endmodule
