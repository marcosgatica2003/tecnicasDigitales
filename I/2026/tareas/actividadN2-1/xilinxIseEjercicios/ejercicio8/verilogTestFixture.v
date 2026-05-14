`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:58:08 05/14/2026
// Design Name:   descripcionVerilogEjercicio8
// Module Name:   /home/xilinx/proyectos/ejercicio8/verilogTestFixture.v
// Project Name:  ejercicio8
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: descripcionVerilogEjercicio8
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module verilogTestFixture;

	// Inputs
	reg inputA;
	reg inputB;
	reg inputC;
	reg inputD;

	// Outputs
	wire outputFunction;

	// Instantiate the Unit Under Test (UUT)
	descripcionVerilogEjercicio8 uut (
		.inputA(inputA), 
		.inputB(inputB), 
		.inputC(inputC), 
		.inputD(inputD), 
		.outputFunction(outputFunction)
	);

	initial begin
		// Initialize Inputs
		inputA = 0;
		inputB = 0;
		inputC = 0;
		inputD = 0;

		// Wait 100 ns for global reset to finish
		#100;
      inputA = 0; inputB = 0; inputC = 0; inputD = 1;
		#100;
      inputA = 0; inputB = 0; inputC = 1; inputD = 0;
		#100;
      inputA = 0; inputB = 0; inputC = 1; inputD = 1;
		#100;
      inputA = 0; inputB = 1; inputC = 0; inputD = 0;
		#100;
      inputA = 0; inputB = 1; inputC = 0; inputD = 1;
		#100;
      inputA = 0; inputB = 1; inputC = 1; inputD = 0;
		#100;
      inputA = 0; inputB = 1; inputC = 1; inputD = 1;
		#100;
      inputA = 1; inputB = 0; inputC = 0; inputD = 0;
		#100;
      inputA = 1; inputB = 0; inputC = 0; inputD = 1;
		#100;
      inputA = 1; inputB = 0; inputC = 1; inputD = 0;
		#100;
      inputA = 1; inputB = 0; inputC = 1; inputD = 1;
		#100;
      inputA = 1; inputB = 1; inputC = 0; inputD = 0;
		#100;
      inputA = 1; inputB = 1; inputC = 0; inputD = 1;
		#100;
      inputA = 1; inputB = 1; inputC = 1; inputD = 0;
		#100;
		inputA = 1; inputB = 1; inputC = 1; inputD = 1;

		// Add stimulus here

	end
      
endmodule

