// Author(s): Joey Conroy, Abbie Mathew, Matthew Quijano
// CPU Module: This module represents the Central Processing Unit (CPU). It fetches instructions 
// from memory, decodes them, and executes them using components like the ALU, Control Unit, 
// and Register File. The Program Counter (PC) keeps track of the current instruction address.

module CPU (
    // Clock signal to synchronize the CPU operations
    input clock,

    // Program Counter (PC) output to hold the current instruction address
    output [15:0] PC,

    // ALUOut output to hold the result of the ALU operation
    output [15:0] ALUOut,

    // Instruction Register (IR) output to hold the current instruction
    output [15:0] IR
);

    // Internal register to hold the current value of the program counter
    reg [15:0] PC_reg;

    // Internal register to indicate if the CPU should halt
    reg halt;

    // Wires for internal connections between components
    wire [15:0] NextPC, A, RD2, B, SignExtend;
    wire [3:0] ALUControl;
    wire [1:0] WR;
    wire RegDst, ALUSrc, RegWrite, Zero;

    // InstructionMemory module to fetch instructions based on the PC value
    InstructionMemory instr_mem (
        .Address(PC_reg),
        .Instruction(IR)
    );

    // Initial block to initialize the PC and halt signal
    initial begin
        PC_reg = 0;
        halt = 0;
    end

    // Assign the current PC value to the PC output
    assign PC = PC_reg;

    // ControlUnit module to generate control signals based on the opcode in the instruction
    ControlUnit MainCtr(
        .Op(IR[15:12]),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .ALUControl(ALUControl)
    );

    // RegisterFile module to handle register reads and writes
    RegisterFile rf(
        .RR1(IR[11:10]),
        .RR2(IR[9:8]),
        .WR(WR),
        .WD(ALUOut),
        .RegWrite(RegWrite),
        .clock(clock),
        .RD1(A),
        .RD2(RD2)
    );

    // Sign-extend the immediate value in the instruction
    assign SignExtend = {{8{IR[7]}}, IR[7:0]};

    // Determine the write register based on the RegDst signal
    assign WR = (RegDst) ? IR[7:6] : IR[9:8];

    // Select the second ALU input based on the ALUSrc signal
    assign B = (ALUSrc) ? SignExtend : RD2;

    // ALU module to perform arithmetic and logic operations
    ALU ex(
        .op(ALUControl),
        .a(A),
        .b(B),
        .result(ALUOut),
        .zero(Zero)
    );

    // ALU module to calculate the next PC value by adding 2 to the current PC
    ALU fetch(
        .op(4'b0010),
        .a(PC_reg),
        .b(16'd2),
        .result(NextPC),
        .zero()
    );

    // Always block to update the PC and halt the CPU when the halt instruction (0xFFFF) is encountered
    always @(negedge clock) begin
        if (IR == 16'hFFFF)
            halt <= 1;
        if (!halt)
            PC_reg <= NextPC;
    end
endmodule
