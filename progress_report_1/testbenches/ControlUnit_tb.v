// Author(s): Matthew Quijano
// Control Unit Testbench (ControlUnit_tb): This testbench is designed to simulate the ControlUnit 
// module by providing different operation codes (Op) and displaying the generated control signals.

module ControlUnit_tb;

    // Register to hold the operation code (Op) input
    reg [3:0] Op;

    // Wires to capture the control signals output from the ControlUnit
    wire RegDst, ALUSrc, RegWrite;
    wire [3:0] ALUControl;

    // Instantiate the ControlUnit module for testing
    ControlUnit uut (
        .Op(Op),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .ALUControl(ALUControl)
    );

    // Apply different operation codes to test the ControlUnit's response
    initial begin
        Op = 4'b0000;
        #10 Op = 4'b0001;
        #10 Op = 4'b0010;
        #10 Op = 4'b0011;
        #10 Op = 4'b0100;
        #10 Op = 4'b0101;
        #10 Op = 4'b0110;
        #10 Op = 4'b0111;
        #10 Op = 4'b1000;
        #10 $finish;
    end

    // Display and monitor the time, operation code, and generated control signals
    initial begin
        $display("Time        Op            RegDst     ALUSrc     RegWrite   ALUControl");
        $monitor("%2t          %b          %b          %b          %b          %b", 
                 $time, Op, RegDst, ALUSrc, RegWrite, ALUControl);
    end
endmodule

/*
Time        Op            RegDst     ALUSrc     RegWrite   ALUControl
 0          0000          1          0          1          0010
10          0001          1          0          1          0110
20          0010          1          0          1          0000
30          0011          1          0          1          0001
40          0100          1          0          1          1100
50          0101          1          0          1          1101
60          0110          1          0          1          0111
70          0111          0          1          1          0010
80          1000          0          0          0          0000
testbenches/ControlUnit_tb.v:25: $finish called at 90 (1s)
*/
