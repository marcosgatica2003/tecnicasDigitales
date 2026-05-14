`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:57:13 05/14/2026
// Design Name:   descripcionVerilogEjercicio4
// Module Name:   /home/xilinx/proyectos/ejercicio4/verilogTestFixtureEjercicio4.v
// Project Name:  ejercicio4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: descripcionVerilogEjercicio4
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module verilogTestFixtureEjercicio4;

	// Inputs
	reg inputX;
	reg inputY;
	reg inputZ;

	// Outputs
	wire outputFunction;

	// Instantiate the Unit Under Test (UUT)
	descripcionVerilogEjercicio4 uut (
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

