module CPUTestbench;
    reg clock;
    wire signed [15:0] ALUOut, IR, PC;
    CPU test_cpu(.clock(clock), .PC(PC), .ALUOut(ALUOut), .IR(IR));
    always #1 clock = ~clock;
    initial begin
        $display("Clock PC   IR                    WD");
        $monitor("%b     %2d   %b  %d (%b)", clock, PC, IR, ALUOut, ALUOut);
        clock = 1;
        #2;
        while (IR != 16'hFFFF) begin
            #2; 
        end
        $display("CPU halted.");
        $finish;
    end
endmodule

/*
Clock PC   IR                    WD
1      0   0111000100001111      15 (0000000000001111)
0      2   0111001000000111       7 (0000000000000111)
1      2   0111001000000111       7 (0000000000000111)
0      4   0010011011000000       7 (0000000000000111)
1      4   0010011011000000       7 (0000000000000111)
0      6   0001011011000000       8 (0000000000001000)
1      6   0001011011000000       8 (0000000000001000)
0      8   0011100110000000      15 (0000000000001111)
1      8   0011100110000000      15 (0000000000001111)
0     10   0000011011000000      30 (0000000000011110)
1     10   0000011011000000      30 (0000000000011110)
0     12   0100011101000000     -32 (1111111111100000)
1     12   0100011101000000     -32 (1111111111100000)
0     14   0111000100001111      15 (0000000000001111)
1     14   0111000100001111      15 (0000000000001111)
0     16   0110010111111111       0 (0000000000000000)
1     16   0110010111111111       0 (0000000000000000)
0     18   1111111111111111       0 (0000000000000000)
CPU halted.
C:\Users\Matthew Quijano\Documents\2024_Semester-10_CCSU\CS-385-10961-01_Computer-Architecture\Simplified-MIPS-Machine\progress_report_1\src\ProgressReport1.v:262: $finish called at 18 (1s)
1     18   1111111111111111       0 (0000000000000000)
*/