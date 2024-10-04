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
        $monitor("Time: %0d | PC: %h | Instruction: %h | ALUOut: %h | A: %h | B: %h | ALUControl: %b | Zero: %b | RD1: %h | RD2: %h | WR: %b | WD: %h | RegWrite: %b | Immediate: %h", 
                 $time, uut.PC, uut.instruction, uut.ALUOut, uut.RD1, uut.ALUIn2, uut.ALUControl, uut.Zero, uut.register_file.RD1, uut.register_file.RD2, uut.register_file.WR, uut.register_file.WD, uut.register_file.RegWrite, uut.immediate);
    end
endmodule
