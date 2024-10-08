// Author(s): Joey Conroy, Abbie Mathew, Matthew Quijano
// CPU Module: This represents the central processing unit. It fetches instructions 
// from memory, decodes them, and executes them using components like the ALU, control unit, 
// and register file. The program counter (PC) keeps track of the current instruction.

module CPU (
    // Clock signal for synchronization
    input clock,

    // Program Counter (PC): holds the address of the current instruction
    output [15:0] PC,

    // ALUOut: result from the ALU after execution
    output [15:0] ALUOut,

    // IR: Instruction Register, holds the fetched instruction
    output [15:0] IR
);

    // Register to hold the current value of the program counter
    reg [15:0] PC_reg;

    // Halt signal to stop the CPU from running
    reg halt;

    // Internal wires for next PC value, ALU inputs, and control signals
    wire [15:0] NextPC, A, RD2, B, SignExtend;
    wire [3:0] ALUControl;
    wire [1:0] WR;
    wire RegDst, ALUSrc, RegWrite, Zero;

    // Instruction Memory: Fetches instructions based on the current PC address
    InstructionMemory instr_mem (
        .Address(PC_reg),
        .Instruction(IR)
    );

    // Initialize the program counter and halt signal at the start
    initial begin
        PC_reg = 0;
        halt = 0;
    end

    // Assign the current value of PC_reg to PC output
    assign PC = PC_reg;

    // Control Unit generates control signals based on the opcode in the instruction
    ControlUnit MainCtr(
        .Op(IR[15:12]),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .ALUControl(ALUControl)
    );

    // Register File holds data and provides values for the ALU
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

    // Determine which register to write based on the control signal
    assign WR = (RegDst) ? IR[7:6] : IR[9:8];

    // Choose the ALU's second input: either from the register or the sign-extended immediate
    assign B = (ALUSrc) ? SignExtend : RD2;

    // ALU performs the actual arithmetic or logic operations
    ALU ex(
        .ALUControl(ALUControl),
        .A(A),
        .B(B),
        .ALUOut(ALUOut),
        .Zero(Zero)
    );

    // ALU to calculate the next PC value (PC + 2)
    ALU fetch(
        .ALUControl(4'b0010),
        .A(PC_reg),
        .B(16'd2),
        .ALUOut(NextPC),
        .Zero()
    );

    // Always block runs at the falling edge of the clock signal
    always @(negedge clock) begin
        if (IR == 16'hFFFF)
            halt <= 1;
        if (!halt)
            PC_reg <= NextPC;
    end

endmodule
