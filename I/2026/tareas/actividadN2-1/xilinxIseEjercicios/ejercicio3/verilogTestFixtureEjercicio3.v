`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:34:43 05/14/2026
// Design Name:   descripcionVerilogEjercicio3
// Module Name:   /home/xilinx/proyectos/ejercicio3/verilogTestFixtureEjercicio3.v
// Project Name:  ejercicio3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: descripcionVerilogEjercicio3
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module verilogTestFixtureEjercicio3;

	// Inputs
	reg inputX;
	reg inputY;
	reg inputZ;

	// Outputs
	wire outputFunction;

	// Instantiate the Unit Under Test (UUT)
	descripcionVerilogEjercicio3 uut (
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
      inputX = 0; inputY = 0; inputZ = 1;
		#100;
      inputX = 0; inputY = 1; inputZ = 0;
		#100;
      inputX = 0; inputY = 1; inputZ = 1;
		#100;
      inputX = 1; inputY = 0; inputZ = 0;
		#100;
      inputX = 1; inputY = 0; inputZ = 1;
		#100;
      inputX = 1; inputY = 1; inputZ = 0;
		#100;
      inputX = 1; inputY = 1; inputZ = 1;		
		// Add stimulus here

	end
      
endmodule

