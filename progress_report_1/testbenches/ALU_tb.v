// Author(s): Abbie Mathew
// ALU Testbench (ALU_tb): This testbench is designed to simulate the ALU module by providing 
// various control signals and inputs, then displaying the results of ALU operations.

module ALU_tb;

    // Register to hold the ALUControl signal, which determines the ALU operation
    reg [3:0] ALUControl;

    // Registers to hold the signed 16-bit input values for the ALU
    reg signed [15:0] A, B;

    // Wire to capture the 16-bit signed output result from the ALU
    wire signed [15:0] ALUOut;

    // Wire to capture the Zero flag output from the ALU
    wire Zero;

    // Instantiate the ALU module for testing
    ALU uut (
        .ALUControl(ALUControl),
        .A(A),
        .B(B),
        .ALUOut(ALUOut),
        .Zero(Zero)
    );

    // Test sequence to apply different control signals and inputs to the ALU
    initial begin
        $display("op   a                     b                     result                zero");
        $monitor ("%b %b(%2d)  %b(%2d)  %b(%2d)  %b", ALUControl, A, A, B, B, ALUOut, ALUOut, Zero);

        // Apply different ALUControl values and inputs A, B for testing various ALU operations
        ALUControl = 4'b0000; A = 16'b0111; B = 16'b0001;
        #1 ALUControl = 4'b0001; A = 16'b0101; B = 16'b0010;
        #1 ALUControl = 4'b0010; A = 16'b0100; B = 16'b0010;
        #1 ALUControl = 4'b0010; A = 16'b0111; B = 16'b0001;
        #1 ALUControl = 4'b0110; A = 16'b0101; B = 16'b0011;
        #1 ALUControl = 4'b0110; A = 16'b1111; B = 16'b0001;
        #1 ALUControl = 4'b0111; A = 16'b0101; B = 16'b0001;
        #1 ALUControl = 4'b0111; A = 16'b1110; B = 16'b1111;
        #1 ALUControl = 4'b1100; A = 16'b0101; B = 16'b0010;
        #1 ALUControl = 4'b1101; A = 16'b0101; B = 16'b0010;

        // End the test
        $finish;
    end
endmodule

/*
op   a                     b                     result                zero
0000 0000000000000111( 7)  0000000000000001( 1)  0000000000000001( 1)  0
0001 0000000000000101( 5)  0000000000000010( 2)  0000000000000111( 7)  0
0010 0000000000000100( 4)  0000000000000010( 2)  0000000000000110( 6)  0
0010 0000000000000111( 7)  0000000000000001( 1)  0000000000001000( 8)  0
0110 0000000000000101( 5)  0000000000000011( 3)  0000000000000010( 2)  0
0110 0000000000001111(15)  0000000000000001( 1)  0000000000001110(14)  0
0111 0000000000000101( 5)  0000000000000001( 1)  0000000000000000( 0)  1
0111 0000000000001110(14)  0000000000001111(15)  0000000000000001( 1)  0
1100 0000000000000101( 5)  0000000000000010( 2)  1111111111111000(-8)  0
testbenches/ALU_tb.v:31: $finish called at 9 (1s)
1101 0000000000000101( 5)  0000000000000010( 2)  1111111111111111(-1)  0
*/
