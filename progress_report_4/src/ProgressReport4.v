// === START OF UTILITY MODULES ===
// Author(s): Joey Conroy, Abbie Mathew, Matthew Quijano
module Mux2To1 #(parameter N = 1) (
    input [N-1:0] a,
    input [N-1:0] b,
    input sel,
    output [N-1:0] y
    );
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin: mux_loop
            wire sel_n, a_and_sel_n, b_and_sel;
            not (sel_n, sel);
            and (a_and_sel_n, a[i], sel_n);
            and (b_and_sel, b[i], sel);
            or  (y[i], a_and_sel_n, b_and_sel);
        end
    endgenerate
endmodule

// Author(s): Joey Conroy, Abbie Mathew, Matthew Quijano
module Mux4To1(
    input in0,
    input in1,
    input in2,
    input in3,
    input [1:0] sel,
    output y
    );
    wire sel0_n, sel1_n, and0, and1, and2, and3;
    not (sel0_n, sel[0]);
    not (sel1_n, sel[1]);
    and (and0, in0, sel1_n, sel0_n);
    and (and1, in1, sel1_n, sel[0]);
    and (and2, in2, sel[1], sel0_n);
    and (and3, in3, sel[1], sel[0]);
    or (y, and0, and1, and2, and3);
endmodule

// Author(s): Joey Conroy, Abbie Mathew, Matthew Quijano
module BranchControl (
    input beq,
    input bne,
    input zero,
    output branchout
    );
    wire notzero, beqtaken, bnetaken;
    not (notzero, zero);
    and (beqtaken, beq, zero);
    and (bnetaken, bne, notzero);
    or (branchout, beqtaken, bnetaken);
endmodule
// === END OF UTILITY MODULES ===

// === START OF ALU-RELATED MODULES ===
// Author(s): Joey Conroy, Abbie Mathew, Matthew Quijano
module ALU1 (
    a,
    b,
    ainvert,
    binvert,
    op,
    less,
    carryin,
    carryout,
    result
    );
    input a, b, less, carryin, ainvert, binvert;
    input [1:0] op;
    output carryout, result;
    wire a1, b1, a_and_b, a_or_b, sum, c1, c2;
    wire not_a, not_b;
    not (not_a, a);
    not (not_b, b);
    Mux2To1 mux_a(.a(a), .b(not_a), .sel(ainvert), .y(a1));
    Mux2To1 mux_b(.a(b), .b(not_b), .sel(binvert), .y(b1));
    and (a_and_b, a1, b1);
    or  (a_or_b, a1, b1);
    xor (sum, a1, b1, carryin);
    and (c1, a1, b1);
    and (c2, a1 ^ b1, carryin);
    or  (carryout, c1, c2);
    Mux4To1 mux1 (.in0(a_and_b), .in1(a_or_b), .in2(sum), .in3(less), .sel(op), .y(result));
endmodule

// Author(s): Joey Conroy, Abbie Mathew, Matthew Quijano
module ALUmsb (
    a,
    b,
    ainvert,
    binvert,
    op,
    less,
    carryin,
    carryout,
    result,
    sum
    );
    input a, b, less, carryin, ainvert, binvert;
    input [1:0] op;
    output carryout, result, sum;
    wire a1, b1, a_and_b, a_or_b;
    wire not_a, not_b;
    not (not_a, a);
    not (not_b, b);
    Mux2To1 mux_a(.a(a), .b(not_a), .sel(ainvert), .y(a1));
    Mux2To1 mux_b(.a(b), .b(not_b), .sel(binvert), .y(b1));
    and (a_and_b, a1, b1);
    or  (a_or_b, a1, b1);
    xor (sum, a1, b1, carryin);
    and (carryout, a1 & b1, (a1 ^ b1) & carryin);
    Mux4To1 mux2 (.in0(a_and_b), .in1(a_or_b), .in2(sum), .in3(less), .sel(op), .y(result));
endmodule

// Author(s): Joey Conroy, Abbie Mathew, Matthew Quijano
module ALU (
    op,
    a,
    b,
    result,
    zero
    );
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
    ALUmsb alu15 (a[15], b[15], op[3], op[2], op[1:0], 1'b0, carry[14], carry[15], result[15], set);
    nor nor1(zero, result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], 
             result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]);
endmodule
// === END OF ALU-RELATED MODULES ===

// === START OF CORE COMPONENTS ===
// Author(s): Joey Conroy
module RegisterFile (
    input [1:0] RR1,
    RR2,
    input [1:0] WR,
    input [15:0] WD,
    input RegWrite,
    input clock,
    output [15:0] RD1,
    RD2
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

// Author(s): Abbie Mathew
// With nops
module InstructionMemory (
    input [15:0] Address,
    output [15:0] Instruction
    );
    reg [15:0] IMemory[0:1023];
    assign Instruction = IMemory[Address >> 1];
    initial begin
        IMemory[0] = 16'b0111_00_01_00001111;   // addi $t1, $0, 15 (Expected: $t1 = 15)
        IMemory[1] = 16'b0111_00_10_00000111;   // addi $t2, $0, 7 (Expected: $t2 = 7)
        IMemory[2] = 16'b0000_0000_0000_0000;   // nop (No changes expected)
        IMemory[3] = 16'b0010_01_10_11_000000;  // and $t3, $t1, $t2 (Expected: $t3 = $t1 & $t2 = 7)
        IMemory[4] = 16'b0000_0000_0000_0000;   // nop (No changes expected)
        IMemory[5] = 16'b0001_01_10_11_000000;  // sub $t3, $t1, $t2 (Expected: $t3 = $t1 - $t2 = 8)
        IMemory[6] = 16'b0000_0000_0000_0000;   // nop (No changes expected)
        IMemory[7] = 16'b0011_10_01_10_000000;  // or $t2, $t2, $t1 (Expected: $t2 = $t2 | $t1 = 15)
        IMemory[8] = 16'b0000_0000_0000_0000;   // nop (No changes expected)
        IMemory[9] = 16'b0000_01_10_11_000000;  // add $t3, $t1, $t2 (Expected: $t3 = $t1 + $t2 = 22)
        IMemory[10] = 16'b0000_0000_0000_0000;  // nop (No changes expected)
        IMemory[11] = 16'b0100_01_11_01_000000; // nor $t1, $t3, $t1 (Expected: $t1 = ~($t3 | $t1) = -32)
        IMemory[12] = 16'b0111_00_01_00001111;  // addi $t1, $0, 15 (Expected: $t1 = 15)
        IMemory[13] = 16'b0000_0000_0000_0000;  // nop (No changes expected)
        IMemory[14] = 16'b0110_01_01_11_111111; // slt $t3, $t1, $t1 (Expected: $t3 = ($t1 < $t1) = 0)
        IMemory[15] = 16'hFFFF;                 // halt (Stop execution)
    end
endmodule

// Author(s): Abbie Mathew
// Without nops
// module InstructionMemory (
//     input [15:0] Address,
//     output [15:0] Instruction
//     );
//     reg [15:0] IMemory[0:1023];
//     assign Instruction = IMemory[Address >> 1];
//     initial begin
//         IMemory[0] = 16'b0111_00_01_00001111;   // addi $t1, $0, 15 (Expected: $t1 = 15)
//         IMemory[1] = 16'b0111_00_10_00000111;   // addi $t2, $0, 7 (Expected: $t2 = 7)
//         IMemory[2] = 16'b0010_01_10_11_000000;  // and $t3, $t1, $t2 (Expected: Hazard; incorrect $t3)
//         IMemory[3] = 16'b0001_01_10_11_000000;  // sub $t3, $t1, $t2 (Expected: Hazard; incorrect $t3)
//         IMemory[4] = 16'b0011_10_01_10_000000;  // or $t2, $t2, $t1 (Expected: Hazard; incorrect $t2)
//         IMemory[5] = 16'b0000_01_10_11_000000;  // add $t3, $t1, $t2 (Expected: Hazard; incorrect $t3)
//         IMemory[6] = 16'b0100_01_11_01_000000;  // nor $t1, $t3, $t1 (Expected: Hazard; incorrect $t1)
//         IMemory[7] = 16'b0111_00_01_00001111;   // addi $t1, $0, 15 (Expected: $t1 = 15)
//         IMemory[8] = 16'b0110_01_01_11_111111;  // slt $t3, $t1, $t1 (Expected: Hazard; incorrect $t3)
//         IMemory[9] = 16'hFFFF;                  // halt (Stop execution)
//     end
// endmodule

// Author(s): Joey Conroy, Abbie Mathew, Matthew Quijano
module DataMemory (
    input clock,
    input [15:0] address,
    input [15:0] writeData,
    input memWrite,
    output [15:0] readData
    );
    reg [15:0] DMemory[0:1023];
    initial begin
        DMemory[0] = 16'd5;
        DMemory[1] = 16'd7;
    end
    assign readData = DMemory[address >> 1];
    always @(negedge clock) begin
        if (memWrite) begin
            DMemory[address >> 1] <= writeData;
        end
    end
endmodule

// Author(s): Matthew Quijano
module ControlUnit (
    input [3:0] Op,
    output reg RegDst,
    output reg ALUSrc,
    output reg RegWrite,
    output reg MemWrite,
    output reg MemtoReg,
    output reg Beq,
    output reg Bne,
    output reg [3:0] ALUControl
    );
    always @(*) begin
        RegDst = 0;
        ALUSrc = 0;
        RegWrite = 0;
        MemWrite = 0;
        MemtoReg = 0;
        Beq = 0;
        Bne = 0;
        ALUControl = 4'b0000;
        case (Op)
            4'b0000: begin // add
                RegDst   = 1;
                ALUSrc   = 0;
                RegWrite = 1;
                ALUControl   = 4'b0010;
            end
            4'b0001: begin // sub
                RegDst   = 1;
                ALUSrc   = 0;
                RegWrite = 1;
                ALUControl   = 4'b0110;
            end
            4'b0010: begin // and
                RegDst   = 1;
                ALUSrc   = 0;
                RegWrite = 1;
                ALUControl   = 4'b0000;
            end
            4'b0011: begin // or
                RegDst   = 1;
                ALUSrc   = 0;
                RegWrite = 1;
                ALUControl   = 4'b0001;
            end
            4'b0100: begin // nor
                RegDst   = 1;
                ALUSrc   = 0;
                RegWrite = 1;
                ALUControl   = 4'b1100;
            end
            4'b0101: begin // nand
                RegDst   = 1;
                ALUSrc   = 0;
                RegWrite = 1;
                ALUControl   = 4'b1101;
            end
            4'b0110: begin // slt
                RegDst   = 1;
                ALUSrc   = 0;
                RegWrite = 1;
                ALUControl   = 4'b0111;
            end
            4'b0111: begin // addi
                RegDst   = 0;
                ALUSrc   = 1;
                RegWrite = 1;
                ALUControl   = 4'b0010;
            end
            4'b1000: begin // lw
                RegDst = 0;
                ALUSrc = 1;
                MemtoReg = 1;
                RegWrite = 1;
                ALUControl = 4'b0010;
            end
            4'b1001: begin // sw
                ALUSrc = 1;
                MemWrite = 1;
                ALUControl = 4'b0010;
            end
            4'b1010: begin // beq
                Beq = 1;
                ALUControl = 4'b0110;
            end
            4'b1011: begin // bne
                Bne = 1;
                ALUControl = 4'b0110;
            end
            default: begin
                RegDst   = 0;
                ALUSrc   = 0;
                RegWrite = 0;
                MemWrite = 0;
                MemtoReg = 0;
                Beq = 0;
                Bne = 0;
                ALUControl   = 4'b0000;
            end
        endcase
    end
endmodule
// === END OF CORE COMPONENTS ===

// === START OF CPU ===
// Author(s): Joey Conroy, Abbie Mathew, Matthew Quijano
module CPU (
    input clock,
    output [15:0] PC,
    output [15:0] IFID_IR,
    output [15:0] IDEX_IR,
    output [15:0] WD
    );
    reg [15:0] PC_reg;
    reg [15:0] IDEX_IR_reg;
    reg [15:0] WD_reg;
    reg halt;
    wire [15:0] NextPC, A, RD2, B, SignExtend, ALUOut;
    wire [3:0] ALUControl;
    wire [1:0] WR;
    wire RegDst, ALUSrc, RegWrite, Zero;
    reg [15:0] IFID_PC; 
    reg [15:0] IDEX_PC, IDEX_A, IDEX_RD2, IDEX_SignExtend;
    reg IDEX_RegWrite, IDEX_ALUSrc, IDEX_RegDst;
    reg [3:0] IDEX_ALUControl;
    reg [1:0] IDEX_WR;
    InstructionMemory instr_mem (.Address(PC_reg), .Instruction(IFID_IR));
    initial begin
        PC_reg = 0;
        halt = 0;
    end
    assign PC = PC_reg;
    ControlUnit MainCtr(.Op(IFID_IR[15:12]), .RegDst(RegDst), .ALUSrc(ALUSrc), .RegWrite(RegWrite), .ALUControl(ALUControl));
    RegisterFile rf(.RR1(IFID_IR[11:10]), .RR2(IFID_IR[9:8]), .WR(IDEX_WR), .WD(ALUOut), .RegWrite(IDEX_RegWrite), .clock(clock), .RD1(A), .RD2(RD2));
    assign SignExtend = {{8{IFID_IR[7]}}, IFID_IR[7:0]}; 
    Mux2To1 #(2) RegDstMux (.a(IFID_IR[9:8]), .b(IFID_IR[7:6]), .sel(RegDst), .y(WR));
    Mux2To1 #(16) ALUSrcMux (.a(IDEX_RD2), .b(IDEX_SignExtend), .sel(IDEX_ALUSrc), .y(B));
    ALU ex(.op(IDEX_ALUControl), .a(IDEX_A), .b(B), .result(ALUOut), .zero(Zero));
    ALU fetch(.op(4'b0010), .a(PC_reg), .b(16'd2), .result(NextPC), .zero());
    assign IDEX_IR = IDEX_IR_reg;
    assign WD = WD_reg;
    always @(negedge clock) begin
        if (IFID_IR == 16'hFFFF) halt <= 1;
        if (!halt) begin
            // === START OF IF/ID PIPELINE STAGE ===
            PC_reg <= NextPC;
            IFID_PC <= PC_reg;
            // === END OF IF/ID PIPELINE STAGE ===

            // === START OF ID/EX PIPELINE STAGE ===
            IDEX_IR_reg <= IFID_IR;
            IDEX_PC <= IFID_PC;
            IDEX_A <= A;
            IDEX_RD2 <= RD2;
            IDEX_SignExtend <= SignExtend;
            IDEX_RegWrite <= RegWrite;
            IDEX_ALUSrc <= ALUSrc;
            IDEX_RegDst <= RegDst;
            IDEX_ALUControl <= ALUControl;
            IDEX_WR <= WR;
            // === END OF ID/EX PIPELINE STAGE ===

            // === START OF EX/MEM Pipeline Stage ===
            WD_reg <= ALUOut;
            // === END OF EX/MEM Pipeline Stage ===
        end
    end
endmodule
// === END OF CPU ===

// === START OF TESTBENCH ===
// Author(s): Joey Conroy, Abbie Mathew
module CPUTestbench;
    reg clock;
    wire signed [15:0] PC, IFID_IR, IDEX_IR, WD;
    CPU test_cpu(
        .clock(clock),
        .PC(PC),
        .IFID_IR(IFID_IR),
        .IDEX_IR(IDEX_IR),
        .WD(WD)
        );
    always #1 clock = ~clock;
    initial begin
        $display("Clock PC  IFID_IR            IDEX_IR               WD");
        $monitor("%b    %2d   %b   %b   %d (%b)", clock, PC, IFID_IR, IDEX_IR, WD, WD);
        clock = 1;
        #2;
        while (IFID_IR != 16'hFFFF) begin
            #2; 
        end
        $display("CPU halted.");
        $finish;
    end
endmodule
// === END OF TESTBENCH ===

// With nops
/*
Clock PC  IFID_IR            IDEX_IR               WD
1     0   0111000100001111   xxxxxxxxxxxxxxxx        x (xxxxxxxxxxxxxxxx)
0     2   0111001000000111   0111000100001111        x (xxxxxxxxxxxxxxxx)
1     2   0111001000000111   0111000100001111        x (xxxxxxxxxxxxxxxx)
0     4   0000000000000000   0111001000000111       15 (0000000000001111)
1     4   0000000000000000   0111001000000111       15 (0000000000001111)
0     6   0010011011000000   0000000000000000        7 (0000000000000111)
1     6   0010011011000000   0000000000000000        7 (0000000000000111)
0     8   0000000000000000   0010011011000000        0 (0000000000000000)
1     8   0000000000000000   0010011011000000        0 (0000000000000000)
0    10   0001011011000000   0000000000000000        7 (0000000000000111)
1    10   0001011011000000   0000000000000000        7 (0000000000000111)
0    12   0000000000000000   0001011011000000        0 (0000000000000000)
1    12   0000000000000000   0001011011000000        0 (0000000000000000)
0    14   0011100110000000   0000000000000000        8 (0000000000001000)
1    14   0011100110000000   0000000000000000        8 (0000000000001000)
0    16   0000000000000000   0011100110000000        0 (0000000000000000)
1    16   0000000000000000   0011100110000000        0 (0000000000000000)
0    18   0000011011000000   0000000000000000       15 (0000000000001111)
1    18   0000011011000000   0000000000000000       15 (0000000000001111)
0    20   0000000000000000   0000011011000000        0 (0000000000000000)
1    20   0000000000000000   0000011011000000        0 (0000000000000000)
0    22   0100011101000000   0000000000000000       30 (0000000000011110)
1    22   0100011101000000   0000000000000000       30 (0000000000011110)
0    24   0111000100001111   0100011101000000        0 (0000000000000000)
1    24   0111000100001111   0100011101000000        0 (0000000000000000)
0    26   0000000000000000   0111000100001111      -32 (1111111111100000)
1    26   0000000000000000   0111000100001111      -32 (1111111111100000)
0    28   0110010111111111   0000000000000000       15 (0000000000001111)
1    28   0110010111111111   0000000000000000       15 (0000000000001111)
0    30   1111111111111111   0110010111111111        0 (0000000000000000)
*/

// Without nops
/*
Clock PC  IFID_IR            IDEX_IR               WD
1     0   0111000100001111   xxxxxxxxxxxxxxxx        x (xxxxxxxxxxxxxxxx)
0     2   0111001000000111   0111000100001111        x (xxxxxxxxxxxxxxxx)
1     2   0111001000000111   0111000100001111        x (xxxxxxxxxxxxxxxx)
0     4   0010011011000000   0111001000000111       15 (0000000000001111)
1     4   0010011011000000   0111001000000111       15 (0000000000001111)
0     6   0001011011000000   0010011011000000        7 (0000000000000111)
1     6   0001011011000000   0010011011000000        7 (0000000000000111)
0     8   0011100110000000   0001011011000000        0 (0000000000000000)
1     8   0011100110000000   0001011011000000        0 (0000000000000000)
0    10   0000011011000000   0011100110000000        8 (0000000000001000)
1    10   0000011011000000   0011100110000000        8 (0000000000001000)
0    12   0100011101000000   0000011011000000       15 (0000000000001111)
1    12   0100011101000000   0000011011000000       15 (0000000000001111)
0    14   0111000100001111   0100011101000000       22 (0000000000010110)
1    14   0111000100001111   0100011101000000       22 (0000000000010110)
0    16   0110010111111111   0111000100001111      -16 (1111111111110000)
1    16   0110010111111111   0111000100001111      -16 (1111111111110000)
0    18   1111111111111111   0110010111111111       15 (0000000000001111)
CPU halted.
*/