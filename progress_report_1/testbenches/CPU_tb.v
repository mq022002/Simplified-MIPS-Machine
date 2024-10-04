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
        $monitor("Time: %0d | PC: %h | Instruction: %h | ALUOut: %h | Zero: %b", 
                 $time, uut.PC, uut.instruction, uut.ALUOut, uut.Zero);
    end
endmodule
