`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:14:27 05/14/2026
// Design Name:   descripcionVerilogEjercicio2
// Module Name:   /home/xilinx/proyectos/ejercicio2/verilogTestFixtureEjercicio2.v
// Project Name:  ejercicio2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: descripcionVerilogEjercicio2
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module verilogTestFixtureEjercicio2;

	// Inputs
	reg inputX;
	reg inputY;
	reg inputZ;

	// Outputs
	wire outputFunction;

	// Instantiate the Unit Under Test (UUT)
	descripcionVerilogEjercicio2 uut (
		.inputX(inputX), 
		.inputY(inputY), 
		.inputZ(inputZ), 
		.outputFunction(outputFunction)
	);

	initial begin
		// Initialize Inputs
		inputX = 0;
		inputY = 0;
		inputZ = 0;

		// Wait 100 ns for global reset to finish
		#100;
      inputX = 0; inputY = 0; inputZ= 1;
		#100;
		inputX = 0; inputY = 1; inputZ= 0;
		#100;
		inputX = 0; inputY = 1; inputZ= 1;
		#100;
		inputX = 1; inputY = 0; inputZ= 0;
		#100;
		inputX = 1; inputY = 0; inputZ= 1;
		#100;
		inputX = 1; inputY = 1; inputZ= 0;
		#100;
		inputX = 1; inputY = 1; inputZ= 1;
		// Add stimulus here

	end
      
endmodule

