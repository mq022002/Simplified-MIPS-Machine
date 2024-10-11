// Author(s): Abbie Mathew
// InstructionMemory Module: This stores a set of instructions, each 16 bits wide. 
// It takes an address and outputs the corresponding instruction from memory.

module InstructionMemory (
    // 16-bit address used to select an instruction
    input [15:0] Address,

    // 16-bit instruction that gets fetched from memory
    output [15:0] Instruction
);

    // Array to store up to 1024 instructions, each 16 bits wide
    reg [15:0] IMemory[0:1023];

    // Fetch the instruction at the given address (address divided by 2 to account for 16-bit alignment)
    assign Instruction = IMemory[Address >> 1];

    // Initialize the memory with predefined instructions
    initial begin
        // Example instruction at address 0
        IMemory[0] = 16'b0111_00_01_00001111;

        // Example instruction at address 1
        IMemory[1] = 16'b0111_00_10_00000111;

        // Example instruction at address 2
        IMemory[2] = 16'b0010_01_10_11_000000;

        // Example instruction at address 3
        IMemory[3] = 16'b0001_01_11_10_000000;

        // Example instruction at address 4
        IMemory[4] = 16'b0011_10_11_10_000000;

        // Example instruction at address 5
        IMemory[5] = 16'b0000_10_11_11_000000;

        // Example instruction at address 6
        IMemory[6] = 16'b0100_10_11_01_000000;

        // Example instruction at address 7
        IMemory[7] = 16'b0110_11_10_01_000000;

        // Example instruction at address 8
        IMemory[8] = 16'b0110_10_11_01_000000;

        // End of program instruction
        IMemory[9] = 16'hFFFF;
    end
endmodule
