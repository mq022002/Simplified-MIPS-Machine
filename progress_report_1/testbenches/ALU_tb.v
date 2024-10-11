// Author(s): Abbie Mathew
// ALU Testbench (ALU_tb): This testbench simulates the ALU module by providing different 
// operation codes and operand values. It displays the result of each ALU operation and 
// indicates if the result is zero.

module ALU_tb;

    // Register to hold the 4-bit operation code for the ALU
    reg [3:0] op;

    // Registers to hold the signed 16-bit input values for the ALU
    reg signed [15:0] a, b;

    // Wire to capture the signed 16-bit result output from the ALU
    wire signed [15:0] result;

    // Wire to capture the zero flag output from the ALU
    wire zero;

    // Instantiate the ALU module for testing
    ALU uut (
        .op(op),
        .a(a),
        .b(b),
        .result(result),
        .zero(zero)
    );

    // Test sequence to apply different operations and inputs to the ALU
    initial begin
        $display("op   a                     b                     result                zero");
        $monitor ("%b %b(%2d)  %b(%2d)  %b(%2d)  %b", op, a, a, b, b, result, result, zero);

        // Apply various operation codes and input values to the ALU
        op = 4'b0000; a = 16'b0000000000000111; b = 16'b0000000000000001; #1;
        op = 4'b0001; a = 16'b0000000000000101; b = 16'b0000000000000010; #1;
        op = 4'b0010; a = 16'b0000000000000100; b = 16'b0000000000000010; #1;
        op = 4'b0010; a = 16'b0000000000000111; b = 16'b0000000000000001; #1;
        op = 4'b0110; a = 16'b0000000000000101; b = 16'b0000000000000011; #1;
        op = 4'b0110; a = 16'b0000000000001111; b = 16'b0000000000000001; #1;
        op = 4'b0111; a = 16'b0000000000000101; b = 16'b0000000000000001; #1;
        op = 4'b0111; a = 16'b0000000000001110; b = 16'b0000000000001111; #1;
        op = 4'b1100; a = 16'b0000000000000101; b = 16'b0000000000000010; #1;
        op = 4'b1101; a = 16'b0000000000000101; b = 16'b0000000000000010; #1;

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
1101 0000000000000101( 5)  0000000000000010( 2)  1111111111111111(-1)  0
*/
