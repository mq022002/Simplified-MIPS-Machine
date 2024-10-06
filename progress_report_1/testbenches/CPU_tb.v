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
        $monitor("Time: %0d | PC: %h | Instruction: %h | ALUOut: %h | A (RD1): %h | B (ALUIn2): %h | ALUControl: %b | Zero: %b | RegWrite: %b | WR: %b | WD: %h | Immediate: %h", 
                 $time, uut.PC, uut.instruction, uut.ALUOut, uut.RD1, uut.ALUIn2, uut.ALUControl, uut.Zero, uut.RegWrite, uut.instruction[7:6], uut.ALUOut, uut.immediate);
    end
endmodule
