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
    InstructionMemory instr_mem (.Address(PC_reg), .Instruction(IR));
    initial begin
        PC_reg = 0;
        halt = 0;
    end
    assign PC = PC_reg;
    ControlUnit MainCtr(.Op(IR[15:12]), .RegDst(RegDst), .ALUSrc(ALUSrc), .RegWrite(RegWrite), .ALUControl(ALUControl));
    RegisterFile rf(.RR1(IR[11:10]), .RR2(IR[9:8]), .WR(WR), .WD(ALUOut), .RegWrite(RegWrite), .clock(clock), .RD1(A), .RD2(RD2));
    assign SignExtend = {{8{IR[7]}}, IR[7:0]};
    Mux2To1 #(2) RegDstMux (.a(IR[9:8]), .b(IR[7:6]), .sel(RegDst), .y(WR));
    Mux2To1 #(16) ALUSrcMux (.a(RD2), .b(SignExtend), .sel(ALUSrc), .y(B));
    ALU ex(.op(ALUControl), .a(A), .b(B), .result(ALUOut), .zero(Zero));
    ALU fetch(.op(4'b0010), .a(PC_reg), .b(16'd2), .result(NextPC), .zero());
    always @(negedge clock) begin
        if (IR == 16'hFFFF)
            halt <= 1;
        if (!halt)
            PC_reg <= NextPC;
    end
endmodule