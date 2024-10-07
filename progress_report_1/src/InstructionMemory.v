// Author(s): Matthew Quijano
module InstructionMemory (
    input [15:0] Address,
    output [15:0] Instruction
);
    reg [15:0] IMemory[0:1023];
    assign Instruction = IMemory[Address >> 1];

    initial begin
        IMemory[0] = 16'b0111_00_01_00001111;
        IMemory[1] = 16'b0111_00_10_00000111;
        IMemory[2] = 16'b0010_01_10_11_000000;
        IMemory[3] = 16'b0001_01_11_10_000000;
        IMemory[4] = 16'b0011_10_11_10_000000;
        IMemory[5] = 16'b0000_10_11_11_000000;
        IMemory[6] = 16'b0100_10_11_01_000000;
        IMemory[7] = 16'b0110_11_10_01_000000;
        IMemory[8] = 16'b0110_10_11_01_000000;
        IMemory[9] = 16'hFFFF;
    end
endmodule