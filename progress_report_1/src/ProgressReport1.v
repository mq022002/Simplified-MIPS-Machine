// START OF ALU.v
module ALU (op, a, b, result, zero);
    input [3:0] op;
    input [15:0] a, b;
    output [15:0] result;
    output zero;

    wire [15:0] carry;
    wire set;

    ALU1 alu0 (a[0], b[0], op[3], op[2], op[1:0], set, op[2], carry[0], result[0]);
    ALU1 alu1 (a[1], b[1], op[3], op[2], op[1:0], 1'b0, carry[0], carry[1], result[1]);
    ALU1 alu2 (a[2], b[2], op[3], op[2], op[1:0], 1'b0, carry[1], carry[2], result[2]);
    ALU1 alu3 (a[3], b[3], op[3], op[2], op[1:0], 1'b0, carry[2], carry[3], result[3]);
    ALU1 alu4 (a[4], b[4], op[3], op[2], op[1:0], 1'b0, carry[3], carry[4], result[4]);
    ALU1 alu5 (a[5], b[5], op[3], op[2], op[1:0], 1'b0, carry[4], carry[5], result[5]);
    ALU1 alu6 (a[6], b[6], op[3], op[2], op[1:0], 1'b0, carry[5], carry[6], result[6]);
    ALU1 alu7 (a[7], b[7], op[3], op[2], op[1:0], 1'b0, carry[6], carry[7], result[7]);
    ALU1 alu8 (a[8], b[8], op[3], op[2], op[1:0], 1'b0, carry[7], carry[8], result[8]);
    ALU1 alu9 (a[9], b[9], op[3], op[2], op[1:0], 1'b0, carry[8], carry[9], result[9]);
    ALU1 alu10 (a[10], b[10], op[3], op[2], op[1:0], 1'b0, carry[9], carry[10], result[10]);
    ALU1 alu11 (a[11], b[11], op[3], op[2], op[1:0], 1'b0, carry[10], carry[11], result[11]);
    ALU1 alu12 (a[12], b[12], op[3], op[2], op[1:0], 1'b0, carry[11], carry[12], result[12]);
    ALU1 alu13 (a[13], b[13], op[3], op[2], op[1:0], 1'b0, carry[12], carry[13], result[13]);
    ALU1 alu14 (a[14], b[14], op[3], op[2], op[1:0], 1'b0, carry[13], carry[14], result[14]);
    ALUMSB alu15 (a[15], b[15], op[3], op[2], op[1:0], 1'b0, carry[14], carry[15], result[15], set);

    nor nor1(zero, result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], 
             result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]);
endmodule

module ALU1 (a, b, ainvert, binvert, op, less, carryin, carryout, result);
    input a, b, less, carryin, ainvert, binvert;
    input [1:0] op;
    output carryout, result;

    wire a1, b1, a_and_b, a_or_b, sum, c1, c2;
    wire not_a, not_b;

    not (not_a, a);
    not (not_b, b);
    Mux2to1 mux_a(a, not_a, ainvert, a1);
    Mux2to1 mux_b(b, not_b, binvert, b1);

    and (a_and_b, a1, b1);
    or  (a_or_b, a1, b1);

    xor (sum, a1, b1, carryin);
    and (c1, a1, b1);
    and (c2, a1 ^ b1, carryin);
    or  (carryout, c1, c2);

    Mux4to1 mux1 (a_and_b, a_or_b, sum, less, op, result);
endmodule

module ALUMSB (a, b, ainvert, binvert, op, less, carryin, carryout, result, sum);
    input a, b, less, carryin, ainvert, binvert;
    input [1:0] op;
    output carryout, result, sum;

    wire a1, b1, a_and_b, a_or_b;
    wire not_a, not_b;

    not (not_a, a);
    not (not_b, b);
    Mux2to1 mux_a(a, not_a, ainvert, a1);
    Mux2to1 mux_b(b, not_b, binvert, b1);

    and (a_and_b, a1, b1);
    or  (a_or_b, a1, b1);

    xor (sum, a1, b1, carryin);
    and (carryout, a1 & b1, (a1 ^ b1) & carryin);

    Mux4to1 mux2 (a_and_b, a_or_b, sum, less, op, result);
endmodule

module Mux2to1(input a, input b, input sel, output y);
    assign y = sel ? b : a;
endmodule

module Mux4to1(input in0, input in1, input in2, input in3, input [1:0] sel, output y);
    assign y = (sel == 2'b00) ? in0 :
               (sel == 2'b01) ? in1 :
               (sel == 2'b10) ? in2 : in3;
endmodule
// END OF ALU.v

// START OF RegisterFile.v
module RegisterFile (
    input [1:0] RR1, RR2, WR,
    input [15:0] WD,
    input RegWrite,
    input clock,
    output [15:0] RD1, RD2
);
    reg [15:0] Regs[0:3];
    assign RD1 = Regs[RR1];
    assign RD2 = Regs[RR2];
    initial begin
        Regs[0] = 0;
        Regs[1] = 0;
        Regs[2] = 0;
        Regs[3] = 0;
    end
    always @(negedge clock)
        if (RegWrite == 1 && WR != 0)
            Regs[WR] <= WD;
endmodule
// END OF RegisterFile.v

// START OF InstructionMemory.v
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
// END OF InstructionMemory.v

// START OF ControlUnit.v
module ControlUnit (
    input [3:0] Op,
    output reg RegDst,
    output reg ALUSrc,
    output reg RegWrite,
    output reg [3:0] ALUControl
);
    always @(*)
        case (Op)
            4'b0000: begin
                RegDst   = 1;
                ALUSrc   = 0;
                RegWrite = 1;
                ALUControl   = 4'b0010;
            end
            4'b0001: begin
                RegDst   = 1;
                ALUSrc   = 0;
                RegWrite = 1;
                ALUControl   = 4'b0110;
            end
            4'b0010: begin
                RegDst   = 1;
                ALUSrc   = 0;
                RegWrite = 1;
                ALUControl   = 4'b0000;
            end
            4'b0011: begin
                RegDst   = 1;
                ALUSrc   = 0;
                RegWrite = 1;
                ALUControl   = 4'b0001;
            end
            4'b0100: begin
                RegDst   = 1;
                ALUSrc   = 0;
                RegWrite = 1;
                ALUControl   = 4'b1100;
            end
            4'b0101: begin
                RegDst   = 1;
                ALUSrc   = 0;
                RegWrite = 1;
                ALUControl   = 4'b1101;
            end
            4'b0110: begin
                RegDst   = 1;
                ALUSrc   = 0;
                RegWrite = 1;
                ALUControl   = 4'b0111;
            end
            4'b0111: begin
                RegDst   = 0;
                ALUSrc   = 1;
                RegWrite = 1;
                ALUControl   = 4'b0010;
            end
            default: begin
                RegDst   = 0;
                ALUSrc   = 0;
                RegWrite = 0;
                ALUControl   = 4'b0000;
            end
        endcase
endmodule
// END OF ControlUnit.v

// START OF CPU.v
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
        .op(ALUControl),
        .a(A),
        .b(B),
        .result(ALUOut),
        .zero(Zero)
    );

    ALU fetch(
        .op(4'b0010),
        .a(PC_reg),
        .b(16'd2),
        .result(NextPC),
        .zero()
    );

    always @(negedge clock) begin
        if (IR == 16'hFFFF)
            halt <= 1;
        if (!halt)
            PC_reg <= NextPC;
    end
endmodule
// END OF CPU.v

// START OF CPU_tb.v
module CPU_tb;
    reg clock;
    wire signed[15:0] ALUOut, IR, PC;

    CPU test_cpu(
        .clock(clock),
        .PC(PC),
        .ALUOut(ALUOut),
        .IR(IR)
    );

    always #1 clock = ~clock;

    initial begin
        $display("Clock PC   IR                 WD");
        $monitor("%b     %2d   %b  %d (%b)", clock, PC, IR, ALUOut, ALUOut);
        clock = 1;
        #34 $finish;
    end
endmodule
// END OF CPU_tb.v
