// Author(s): Joey Conroy, Abbie Mathew
// CPU Testbench (CPU_tb): This is a testbench for the CPU module. It simulates the 
// operation of the CPU by providing a clock signal and monitoring the values of 
// the program counter (PC), instruction register (IR), and the output of the ALU.

module CPU_tb;

    // Register for the clock signal
    reg clock;

    // Wires to capture the output from the CPU: ALUOut, IR (Instruction Register), and PC (Program Counter)
    wire signed [15:0] ALUOut, IR, PC;

    // Instantiate the CPU module for testing
    CPU test_cpu(
        .clock(clock),
        .PC(PC),
        .ALUOut(ALUOut),
        .IR(IR)
    );

    // Generate the clock signal: toggle the clock every 1 unit of time
    always #1 clock = ~clock;

    // Test sequence: display and monitor values, start the simulation, and stop it after 34 time units
    initial begin
        $display("Clock PC   IR                 WD");
        $monitor("%b     %2d   %b  %d (%b)", clock, PC, IR, ALUOut, ALUOut);
        clock = 1;
        #34 $finish;
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
1     18   1111111111111111      22 (0000000000010110)
0     20   xxxxxxxxxxxxxxxx       x (xxxxxxxxxxxxxxxx)
1     20   xxxxxxxxxxxxxxxx       x (xxxxxxxxxxxxxxxx)
0     20   xxxxxxxxxxxxxxxx       x (xxxxxxxxxxxxxxxx)
1     20   xxxxxxxxxxxxxxxx       x (xxxxxxxxxxxxxxxx)
0     20   xxxxxxxxxxxxxxxx       x (xxxxxxxxxxxxxxxx)
1     20   xxxxxxxxxxxxxxxx       x (xxxxxxxxxxxxxxxx)
0     20   xxxxxxxxxxxxxxxx       x (xxxxxxxxxxxxxxxx)
1     20   xxxxxxxxxxxxxxxx       x (xxxxxxxxxxxxxxxx)
0     20   xxxxxxxxxxxxxxxx       x (xxxxxxxxxxxxxxxx)
1     20   xxxxxxxxxxxxxxxx       x (xxxxxxxxxxxxxxxx)
0     20   xxxxxxxxxxxxxxxx       x (xxxxxxxxxxxxxxxx)
1     20   xxxxxxxxxxxxxxxx       x (xxxxxxxxxxxxxxxx)
0     20   xxxxxxxxxxxxxxxx       x (xxxxxxxxxxxxxxxx)
1     20   xxxxxxxxxxxxxxxx       x (xxxxxxxxxxxxxxxx)
0     20   xxxxxxxxxxxxxxxx       x (xxxxxxxxxxxxxxxx)
testbenches/CPU_tb.v:19: $finish called at 34 (1s)
1     20   xxxxxxxxxxxxxxxx       x (xxxxxxxxxxxxxxxx)
*/
