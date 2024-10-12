// Author(s): Matthew Quijano
// Instruction Memory Testbench (InstructionMemory_tb): This testbench simulates the 
// InstructionMemory module by providing different memory addresses and displaying the 
// corresponding instruction values.

module InstructionMemory_tb;

    // Register to hold the address input for fetching an instruction
    reg [15:0] Address;

    // Wire to capture the 16-bit instruction output from the InstructionMemory
    wire [15:0] Instruction;

    // Instantiate the InstructionMemory module for testing
    InstructionMemory uut (
        .Address(Address),
        .Instruction(Instruction)
    );

    // Test sequence to apply different addresses and display the corresponding instruction
    initial begin
        $display("Time        Address       Instruction");
        $monitor("%2t          %h          %h", $time, Address, Instruction);

        // Apply different addresses to test the InstructionMemory's response
        Address = 16'h0000;
        #10 Address = 16'h0002;
        #10 Address = 16'h0004;
        #10 Address = 16'h0006;
        #10 Address = 16'h0008;
        #10 Address = 16'h000A;
        #10 Address = 16'h000C;
        #10 Address = 16'h000E;
        #10 Address = 16'h0010;
        #10 Address = 16'h0012;

        // End the test
        $finish;
    end
endmodule

/*
Time        Address       Instruction
 0          0000          710f
10          0002          7207
20          0004          26c0
30          0006          1780
40          0008          3b80
50          000a          0bc0
60          000c          4b40
70          000e          6e40
80          0010          6b40
testbenches/InstructionMemory_tb.v:26: $finish called at 90 (1s)
90          0012          ffff
*/
