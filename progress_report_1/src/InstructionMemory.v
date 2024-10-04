// Author(s): Matthew Quijano
module InstructionMemory (
    input [15:0] address,
    output [15:0] instruction
);
    reg [15:0] memory [0:1023];

    initial begin
        memory[0] = 16'h2009;
        memory[1] = 16'h200A;
        memory[2] = 16'h012A;
        memory[3] = 16'h012B;
        memory[4] = 16'h014B;
        memory[5] = 16'h014B;
        memory[6] = 16'h016A;
        memory[7] = 16'h018B;
        memory[8] = 16'hFFFF;
    end

    assign instruction = memory[address[9:0]];
endmodule
