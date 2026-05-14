`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:20:47 05/14/2026
// Design Name:   descripcionVerilogEjercicio6
// Module Name:   /home/xilinx/proyectos/ejercicio6/verilogTestFixtureEjercicio6.v
// Project Name:  ejercicio6
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: descripcionVerilogEjercicio6
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module verilogTestFixtureEjercicio6;

	// Inputs
	reg inputW;
	reg inputX;
	reg inputY;
	reg inputZ;

	// Outputs
	wire outputFunction;

	// Instantiate the Unit Under Test (UUT)
	descripcionVerilogEjercicio6 uut (
		.inputW(inputW), 
		.inputX(inputX), 
		.inputY(inputY), 
		.inputZ(inputZ), 
		.outputFunction(outputFunction)
	);

	initial begin
		// Initialize Inputs
		inputW = 0;
		inputX = 0;
		inputY = 0;
		inputZ = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		inputW = 0; inputX = 0; inputY = 0; inputZ = 1;
		#100;
		inputW = 0; inputX = 0; inputY = 1; inputZ = 0;
		#100;
		inputW = 0; inputX = 0; inputY = 1; inputZ = 1;
		#100;
		inputW = 0; inputX = 1; inputY = 0; inputZ = 0;
		#100;
		inputW = 0; inputX = 1; inputY = 0; inputZ = 1;
		#100;
		inputW = 0; inputX = 1; inputY = 1; inputZ = 0;
		#100;
		inputW = 0; inputX = 1; inputY = 1; inputZ = 1;
		#100;
		inputW = 1; inputX = 0; inputY = 0; inputZ = 0;
		#100;
		inputW = 1; inputX = 0; inputY = 0; inputZ = 1;
		#100;
		inputW = 1; inputX = 0; inputY = 1; inputZ = 0;
		#100;
		inputW = 1; inputX = 0; inputY = 1; inputZ = 1;
		#100;
		inputW = 1; inputX = 1; inputY = 0; inputZ = 0;
		#100;
		inputW = 1; inputX = 1; inputY = 0; inputZ = 1;
		#100;
		inputW = 1; inputX = 1; inputY = 1; inputZ = 0;
		#100;
		inputW = 1; inputX = 1; inputY = 1; inputZ = 1;
		#100;
	end
      
endmodule

