// Author(s): Joey Conroy, Abbie Mathew
module CPU_tb;
    reg clock;
    wire signed[15:0] ALUOut, IR, PC;

    CPU test_cpu(
        .clock(clock),
        .PC(PC),
        .ALUOut(ALUOut),
        .IR(IR)
    );

    always #1 clock = ~clock;

    initial begin
        $display("Clock PC   IR                 WD");
        $monitor("%b     %2d   %b  %d (%b)", clock, PC, IR, ALUOut, ALUOut);
        clock = 1;
        #34 $finish;
    end
endmodule
