// Author(s): Joey Conroy, Abbie Mathew, Matthew Quijano
module CPU (
    input clock,
    output [15:0] PC,
    output [15:0] ALUOut,
    output [15:0] IR
);
    reg [15:0] PC_reg;
    reg halt;
    wire [15:0] NextPC, A, RD2, B, SignExtend;
    wire [3:0] ALUControl;
    wire [1:0] WR;
    wire RegDst, ALUSrc, RegWrite, Zero;

    InstructionMemory instr_mem (
        .Address(PC_reg),
        .Instruction(IR)
    );

    initial begin
        PC_reg = 0;
        halt = 0;
    end

    assign PC = PC_reg;

    ControlUnit MainCtr(
        .Op(IR[15:12]),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .ALUControl(ALUControl)
    );

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

    assign SignExtend = {{8{IR[7]}}, IR[7:0]};

    assign WR = (RegDst) ? IR[7:6] : IR[9:8];

    assign B = (ALUSrc) ? SignExtend : RD2;

    ALU ex(
        .ALUControl(ALUControl),
        .A(A),
        .B(B),
        .ALUOut(ALUOut),
        .Zero(Zero)
    );

    ALU fetch(
        .ALUControl(4'b0010),
        .A(PC_reg),
        .B(16'd2),
        .ALUOut(NextPC),
        .Zero()
    );

    always @(negedge clock) begin
        if (IR == 16'hFFFF)
            halt <= 1;
        if (!halt)
            PC_reg <= NextPC;
    end
endmodule