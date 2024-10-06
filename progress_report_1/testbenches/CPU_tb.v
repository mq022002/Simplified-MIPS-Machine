// Author(s): Joey Conroy, Abbie Mathew
module CPU_tb;
    reg clock;
    reg reset;

    CPU uut (
        .clock(clock),
        .reset(reset)
    );

    initial begin
        clock = 0;
        reset = 1;
        #10 reset = 0;
        #100 $finish;
    end

    always #5 clock = ~clock;

    initial begin
        $display("Clock PC   IR                  WD");
        $monitor("%b     %2d   %b  %3d (%b)", clock, uut.PC, uut.instruction, uut.ALUOut, uut.ALUOut);
    end
endmodule
