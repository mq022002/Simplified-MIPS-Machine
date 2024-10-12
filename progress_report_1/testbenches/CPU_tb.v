// Author(s): Joey Conroy, Abbie Mathew
// CPU Testbench (CPU_tb): This testbench simulates the CPU by generating a clock signal 
// and monitoring the Program Counter (PC), Instruction Register (IR), and ALU output (ALUOut). 
// The test runs until the halt instruction (0xFFFF) is encountered, at which point it stops.

module CPU_tb;

    // Register to hold the clock signal
    reg clock;

    // Wires to capture the outputs from the CPU: ALUOut, IR (Instruction Register), and PC (Program Counter)
    wire signed [15:0] ALUOut, IR, PC;

    // Instantiate the CPU module for testing
    CPU test_cpu(
        .clock(clock),
        .PC(PC),
        .ALUOut(ALUOut),
        .IR(IR)
    );

    // Generate the clock signal: toggle the clock every 1 time unit
    always #1 clock = ~clock;

    // Test sequence: initialize the clock, monitor the outputs, and stop when the halt instruction is encountered
    initial begin
        $display("Clock PC   IR                    WD");
        $monitor("%b     %2d   %b  %d (%b)", clock, PC, IR, ALUOut, ALUOut);

        // Initialize the clock signal
        clock = 1;

        // Wait for 2 time units before starting the CPU
        #2;

        // Loop until the halt instruction (0xFFFF) is fetched
        while (IR != 16'hFFFF) begin
            #2; 
        end

        // Halt the CPU and display the message when the halt instruction is encountered
        $display("CPU halted.");

        // End the test
        $finish;
    end
endmodule

/*
Clock PC   IR                 WD
1      0   0111000100001111      15 (0000000000001111)
0      2   0111001000000111       7 (0000000000000111)
1      2   0111001000000111       7 (0000000000000111)
0      4   0010011011000000       7 (0000000000000111)
1      4   0010011011000000       7 (0000000000000111)
0      6   0001011110000000       8 (0000000000001000)
1      6   0001011110000000       8 (0000000000001000)
0      8   0011101110000000      15 (0000000000001111)
1      8   0011101110000000      15 (0000000000001111)
0     10   0000101111000000      22 (0000000000010110)
1     10   0000101111000000      22 (0000000000010110)
0     12   0100101101000000     -32 (1111111111100000)
1     12   0100101101000000     -32 (1111111111100000)
0     14   0110111001000000       0 (0000000000000000)
1     14   0110111001000000       0 (0000000000000000)
0     16   0110101101000000       1 (0000000000000001)
1     16   0110101101000000       1 (0000000000000001)
0     18   1111111111111111      22 (0000000000010110)
CPU halted.
testbenches/CPU_tb.v:45: $finish called at 18 (1s)
1     18   1111111111111111      22 (0000000000010110)
*/
