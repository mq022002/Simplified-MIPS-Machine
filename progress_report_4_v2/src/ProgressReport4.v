// === START OF UTILITY MODULES ===
// Author(s): Joey Conroy, Abbie Mathew, Matthew Quijano
module Mux2To1(
    a,
    b,
    sel,
    y);
    input a,b,sel;
    output y;
    and a1(a_and_sel_n,b,sel);
    not n1(sel_n,sel);
    and a2(b_and_sel,a,sel_n);
    or o1(y,a_and_sel_n,b_and_sel);
endmodule

// Author(s): Joey Conroy, Abbie Mathew, Matthew Quijano
module Mux4To1 (
    out,
    in0,
    in1,
    in2,
    in3,
    sel0,
    sel1);
    output out;
    input in0, in1, in2, in3, sel0, sel1;
    wire sel0_n, sel1_n, and0, and1, and2, and3;
    not (s0bar, sel0), (sel1_n, sel1);
    and (and0, in0, s0bar, sel1_n), (and1, in1, s0bar, sel1),(and2, in2, sel0, sel1_n), (and3, in3, sel0, sel1);
    or(out, and0, and1, and2, and3);
endmodule

module BranchControl(
    beq,
    bne,
    zero,
    branchout);
    input beq, bne;
    input zero;
    output branchout;
    Mux2To1 branchCtl(beq, bne, zero, branchout);
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
    carryin,
    less,
    carryout,
    result);
    input a, b, ainvert, binvert, carryin, less;
    input [1:0] op;
    output carryout, result;
    wire a1, b1, a_and_b, a_or_b, sum;
    assign a1 = ainvert ? ~a : a;
    assign b1 = binvert ? ~b : b;
    assign a_and_b = a1 & b1;
    assign a_or_b = a1 | b1;
    assign {carryout, sum} = a1 + b1 + carryin;
    Mux4To1 m1(result, a_and_b, a_or_b, sum, less, op[1], op[0]);
endmodule

// Author(s): Joey Conroy, Abbie Mathew, Matthew Quijano
module ALUmsb (
    a,
    b,
    ainvert,
    binvert,
    op,
    carryin,
    less,
    carryout,
    result,
    sum);
    input a, b, ainvert, binvert, carryin, less;
    input [1:0] op;
    output carryout, result, sum;
    wire a1, b1, a_and_b, a_or_b;
    assign a1 = ainvert ? ~a : a;
    assign b1 = binvert ? ~b : b;
    assign a_and_b = a1 & b1;
    assign a_or_b = a1 | b1;
    assign {carryout, sum} = a1 + b1 + carryin;
    Mux4To1 m1(result, a_and_b, a_or_b, sum, less, op[1], op[0]);
endmodule

// Author(s): Joey Conroy, Abbie Mathew, Matthew Quijano
module ALU (
    op,
    a,
    b,
    result,
    zero);
    input [3:0] op;
    input [15:0] a, b;
    output  [15:0] result;
    output zero;
    ALU1 alu0(a[0],b[0],op[3],op[2],op[1:0],op[2],Set,C0,result[0]);
    ALU1 alu1(a[1],b[1],op[3],op[2],op[1:0],C0,1'b0,C1,result[1]);
    ALU1 alu2(a[2],b[2],op[3],op[2],op[1:0],C1,1'b0,C2,result[2]);
    ALU1 alu3(a[3],b[3],op[3],op[2],op[1:0],C2,1'b0,C3,result[3]);
    ALU1 alu4(a[4],b[4],op[3],op[2],op[1:0],C3,1'b0,C4,result[4]);
    ALU1 alu5(a[5],b[5],op[3],op[2],op[1:0],C4,1'b0,C5,result[5]);
    ALU1 alu6(a[6],b[6],op[3],op[2],op[1:0],C5,1'b0,C6,result[6]);
    ALU1 alu7(a[7],b[7],op[3],op[2],op[1:0],C6,1'b0,C7,result[7]);
    ALU1 alu8(a[8],b[8],op[3],op[2],op[1:0],C7,1'b0,C8,result[8]);
    ALU1 alu9(a[9],b[9],op[3],op[2],op[1:0],C8,1'b0,C9,result[9]);
    ALU1 alu10(a[10],b[10],op[3],op[2],op[1:0],C9,1'b0,C10,result[10]);
    ALU1 alu11(a[11],b[11],op[3],op[2],op[1:0],C10,1'b0,C11,result[11]);
    ALU1 alu12(a[12],b[12],op[3],op[2],op[1:0],C11,1'b0,C12,result[12]);
    ALU1 alu13(a[13],b[13],op[3],op[2],op[1:0],C12,1'b0,C13,result[13]);
    ALU1 alu14(a[14],b[14],op[3],op[2],op[1:0],C13,1'b0,C14,result[14]);
    ALUmsb alu15(a[15],b[15],op[3],op[2],op[1:0],C14,1'b0,C15,result[15],Set);
    nor nor1 (zero ,result[0], result[1], result[2], result[3],result[4],result[5],result[6],result[7],result[8],result[9],result[10],result[11],result[12],result[13],result[14],result[15]);
endmodule
// === END OF ALU-RELATED MODULES ===

// === START OF CORE COMPONENTS ===
// Author(s): Joey Conroy
module RegisterFile(
    RR1,
    RR2,
    WR,
    WD,
    RegWrite,
    RD1,
    RD2,
    clock);
    input [1:0] RR1,RR2;
    input [4:0] WR; 
    input [15:0] WD;
    input RegWrite,clock; 
    output [15:0] RD1,RD2;
    reg [15:0] Regs[0:3];
    assign RD1 = Regs[RR1]; 
    assign RD2 = Regs[RR2];
    initial Regs[0] = 0;
    always @(negedge clock)
    if (RegWrite==1 & WR!=0)
    Regs[WR] <= WD;
endmodule

// Author(s): Matthew Quijano
module ControlUnit(
    Op,
    ALUControl);
    input [3:0] Op;
    output reg [10:0] ALUControl;
    always @(Op) case (Op)
        4'b0010: ALUControl <= 11'b10010_0_0_0000; // and
        4'b0011: ALUControl <= 11'b10010_0_0_0001; // or
        4'b0000: ALUControl <= 11'b10010_0_0_0010; // add
        4'b0001: ALUControl <= 11'b10010_0_0_0110; // sub
        4'b0110: ALUControl <= 11'b10010_0_0_0111; // slt
        4'b0100: ALUControl <= 11'b10010_0_0_1100; // nor
        4'b0101: ALUControl <= 11'b10010_0_0_1101; // nand
        4'b0111: ALUControl <= 11'b01010_0_0_0010; // ADDI
        4'b1000: ALUControl <= 11'b01110_0_0_0010; // LW
        4'b1001: ALUControl <= 11'b01001_0_0_0010; // SW
        4'b1010: ALUControl <= 11'b00000_1_0_0110; // BEQ
        4'b1011: ALUControl <= 11'b00000_0_1_0110; // BNE
    endcase
    endmodule
// === END OF CORE COMPONENTS ===

// === START OF CPU ===
// Author(s): Joey Conroy, Abbie Mathew, Matthew Quijano
module CPU (clock, PC, IFID_IR, IDEX_IR, EXMEM_IR, MEMWB_IR, WD);
    input clock;
    output [15:0] PC, IFID_IR, IDEX_IR, EXMEM_IR, MEMWB_IR, WD;
    initial begin
        // Author(s): Abbie Mathew
        // With nops
        IMemory[0]   = 16'b1000_00_01_00000000;    // lw $t1, 0($0)   (Expected: Load 5 into $t1)
        IMemory[1]   = 16'b1000_00_10_00000100;    // lw $t2, 4($0)   (Expected: Load 7 into $t2)
        IMemory[2]   = 16'b0000000000000000;       // nop             (No changes expected)
        IMemory[3]   = 16'b0000000000000000;       // nop             (No changes expected)
        IMemory[4]   = 16'b0000000000000000;       // nop             (No changes expected)
        IMemory[5]   = 16'b0110_01_10_11_000000;   // slt $t3, $t1, $t2 (Expected: $t3 = $t1 < $t2 ? 1 : 0)
        IMemory[6]   = 16'b0000000000000000;       // nop             (No changes expected)
        IMemory[7]   = 16'b0000000000000000;       // nop             (No changes expected)
        IMemory[8]   = 16'b0000000000000000;       // nop             (No changes expected)
        IMemory[9]   = 16'b1010_00_11_00000111;    // beq $t3, $0, 5  (Expected: Branch if $t3 == 0)
        IMemory[10]  = 16'b0000000000000000;       // nop             (No changes expected)
        IMemory[11]  = 16'b0000000000000000;       // nop             (No changes expected)
        IMemory[12]  = 16'b0000000000000000;       // nop             (No changes expected)
        IMemory[13]  = 16'b1001_00_01_00000100;    // sw $t1, 4($0)   (Store $t1 into DMemory[1])
        IMemory[14]  = 16'b1001_00_10_00000000;    // sw $t2, 0($0)   (Store $t2 into DMemory[0])
        IMemory[15]  = 16'b0000000000000000;       // nop             (No changes expected)
        IMemory[16]  = 16'b0000000000000000;       // nop             (No changes expected)
        IMemory[17]  = 16'b0000000000000000;       // nop             (No changes expected)
        IMemory[18]  = 16'b1000_00_01_00000000;    // lw $t1, 0($0)   (Expected: Reload $t1 from DMemory[0])
        IMemory[19]  = 16'b1000_00_10_00000100;    // lw $t2, 4($0)   (Expected: Reload $t2 from DMemory[1])
        IMemory[20]  = 16'b0000000000000000;       // nop             (No changes expected)
        IMemory[21]  = 16'b0000000000000000;       // nop             (No changes expected)
        IMemory[22]  = 16'b0000000000000000;       // nop             (No changes expected)
        IMemory[23]  = 16'b0100_10_10_10_000000;   // nor $t2, $t2, $t2 (Two's complement for subtraction)
        IMemory[24]  = 16'b0000000000000000;       // nop             (No changes expected)
        IMemory[25]  = 16'b0000000000000000;       // nop             (No changes expected)
        IMemory[26]  = 16'b0000000000000000;       // nop             (No changes expected)
        IMemory[27]  = 16'b0111_10_10_00000001;    // addi $t2, $t2, 1 (Adjust $t2 after two's complement)
        IMemory[28]  = 16'b0000000000000000;       // nop             (No changes expected)
        IMemory[29]  = 16'b0000000000000000;       // nop             (No changes expected)
        IMemory[30]  = 16'b0000000000000000;       // nop             (No changes expected)
        IMemory[31]  = 16'b0000_01_10_11_000000;   // add $t3, $t1, $t2 (Expected: Absolute value calculation)

        // Author(s): Abbie Mathew
        // Without nops
        // IMemory[0]   = 16'b1000_00_01_00000000;    // lw $t1, 0($0)   (Expected: Load 5 into $t1)
        // IMemory[1]   = 16'b1000_00_10_00000100;    // lw $t2, 4($0)   (Expected: Load 7 into $t2)
        // IMemory[2]   = 16'b0110_01_10_11_000000;   // slt $t3, $t1, $t2 (Expected: $t3 = $t1 < $t2 ? 1 : 0)
        // IMemory[3]   = 16'b1010_00_11_00000111;    // beq $t3, $0, 5  (Branch if $t3 == 0)
        // IMemory[4]   = 16'b1001_00_01_00000100;    // sw $t1, 4($0)   (Store $t1 in DMemory[1])
        // IMemory[5]   = 16'b1001_00_10_00000000;    // sw $t2, 0($0)   (Store $t2 in DMemory[0])
        // IMemory[6]   = 16'b1000_00_01_00000000;    // lw $t1, 0($0)   (Reload $t1 from DMemory[0]) 
        // IMemory[7]   = 16'b1000_00_10_00000100;    // lw $t2, 4($0)   (Reload $t2 from DMemory[1])
        // IMemory[8]   = 16'b0100_10_10_10_000000;   // nor $t2, $t2, $t2 (Two's complement for subtraction)
        // IMemory[9]   = 16'b0111_10_10_00000001;    // addi $t2, $t2, 1 (Adjust $t2 after two's complement)
        // IMemory[10]  = 16'b0000_01_10_11_000000;   // add $t3, $t1, $t2 (Compute absolute value)

        DMemory[0] = 16'b0000000000000101; 
        DMemory[1] = 16'b0000000000000111; 
    end
    wire [15:0] PCplus4, NextPC;
    reg [15:0] PC, IMemory[0:1023], IFID_IR, IFID_PCplus4;
    ALU fetch (4'b0010, PC, 16'b0000000000000010, PCplus4, Unused1);
    assign NextPC = ( (EXMEM_Bne && ~EXMEM_Zero) || (EXMEM_Beq && EXMEM_Zero) ) ? EXMEM_Target : PCplus4;
    wire [10:0] ALUControl;
    reg IDEX_RegWrite, IDEX_MemtoReg,
    IDEX_Bne, IDEX_Beq, IDEX_MemWrite,
    IDEX_ALUSrc, IDEX_RegDst;
    reg [3:0] IDEX_ALUCtl;
    wire [15:0] RD1, RD2, SignExtend, WD;
    reg [15:0] IDEX_PCplus4, IDEX_RD1, IDEX_RD2, IDEX_SignExt, IDEXE_IR;
    reg [15:0] IDEX_IR;
    reg [4:0] IDEX_rt, IDEX_rd;
    reg MEMWB_RegWrite;
    reg [4:0] MEMWB_rd;
    RegisterFile rf (IFID_IR[11:10], IFID_IR[9:8], MEMWB_rd, WD, MEMWB_RegWrite, RD1, RD2, clock);
    ControlUnit MainCtr (IFID_IR[15:12], ALUControl); 
    assign SignExtend = {{8{IFID_IR[7]}}, IFID_IR[7:0]}; 
    reg EXMEM_RegWrite, EXMEM_MemtoReg,
    EXMEM_Bne, EXMEM_Beq, EXMEM_MemWrite;
    wire [15:0] Target;
    reg EXMEM_Zero;
    reg [15:0] EXMEM_Target, EXMEM_ALUOut, EXMEM_RD2;
    reg [15:0] EXMEM_IR;
    reg [4:0] EXMEM_rd;
    wire [15:0] B, ALUOut;
    wire [4:0] WR;
    ALU branch (4'b0010, IDEX_SignExt << 1, IDEX_PCplus4, Target, Unused2);
    assign B = IDEX_ALUSrc ? IDEX_SignExt : IDEX_RD2;
    ALU ex (IDEX_ALUCtl, IDEX_RD1, B, ALUOut, Zero);
    assign WR = IDEX_RegDst ? IDEX_rd : IDEX_rt;
    BranchControl branchCtl (EXMEM_Bne, EXMEM_Beq, EXMEM_Zero, branchout);
    reg MEMWB_MemtoReg;
    reg [15:0] DMemory[0:1023], MEMWB_MemOut, MEMWB_ALUOut;
    reg [15:0] MEMWB_IR;
    wire [15:0] MemOut;
    assign MemOut = DMemory[EXMEM_ALUOut >> 2];
    always @(negedge clock) begin
        if (EXMEM_MemWrite)
        DMemory[EXMEM_ALUOut >> 2] <= EXMEM_RD2;
    end
    assign WD = MEMWB_MemtoReg ? MEMWB_MemOut : MEMWB_ALUOut;
    initial begin
        PC = 0;
        IDEX_RegWrite = 0; IDEX_MemtoReg = 0; IDEX_Bne = 0; IDEX_Beq = 0;
        IDEX_MemWrite = 0; IDEX_ALUSrc = 0; IDEX_RegDst = 0; IDEX_ALUCtl = 0;
        IFID_IR = 0;
        EXMEM_RegWrite = 0; EXMEM_MemtoReg = 0; EXMEM_Bne = 0;
        EXMEM_Beq = 0; EXMEM_MemWrite = 0;
        EXMEM_Target = 0;
        MEMWB_RegWrite = 0; MEMWB_MemtoReg = 0;
    end

    always @(negedge clock) begin 
        // === START OF IF/ID PIPELINE STAGE ===
        PC <= NextPC;
        IFID_PCplus4 <= PCplus4;
        IFID_IR <= IMemory[PC >> 1];
        // === END OF IF/ID PIPELINE STAGE ===

        // === START OF ID/EX PIPELINE STAGE ===
        IDEX_IR <= IFID_IR;
        {IDEX_RegDst, IDEX_ALUSrc, IDEX_MemtoReg, IDEX_RegWrite, IDEX_MemWrite, IDEX_Beq, IDEX_Bne, IDEX_ALUCtl} <= ALUControl;   
        IDEX_PCplus4 <= IFID_PCplus4;
        IDEX_RD1 <= RD1; 
        IDEX_RD2 <= RD2;
        IDEX_SignExt <= SignExtend;
        IDEX_rt <= IFID_IR[9:8];
        IDEX_rd <= IFID_IR[7:6];
        // === END OF ID/EX PIPELINE STAGE ===

        // === START OF EX/MEM PIPELINE STAGE ===
        EXMEM_IR <= IDEX_IR;
        EXMEM_RegWrite <= IDEX_RegWrite;
        EXMEM_MemtoReg <= IDEX_MemtoReg;
        EXMEM_Beq   <= IDEX_Beq;
        EXMEM_Bne   <= IDEX_Bne;
        EXMEM_MemWrite <= IDEX_MemWrite;
        EXMEM_Target <= Target;
        EXMEM_Zero <= Zero;
        EXMEM_ALUOut <= ALUOut;
        EXMEM_RD2 <= IDEX_RD2;
        EXMEM_rd <= WR;
        // === END OF EX/MEM PIPELINE STAGE ===

        // === START OF MEM/WB PIPELINE STAGE ===
        MEMWB_IR <= EXMEM_IR;
        MEMWB_RegWrite <= EXMEM_RegWrite;
        MEMWB_MemtoReg <= EXMEM_MemtoReg;
        MEMWB_MemOut <= MemOut;
        MEMWB_ALUOut <= EXMEM_ALUOut;
        MEMWB_rd <= EXMEM_rd;
        // === END OF MEM/WB PIPELINE STAGE ===
    end
endmodule
// === END OF CPU ===

// === START OF TESTBENCH ===
// Author(s): Joey Conroy, Abbie Mathew
module CPUTestbench ();
    reg clock;
    wire signed [15:0] PC, IFID_IR, IDEX_IR, EXMEM_IR, MEMWB_IR, WD;
    CPU test_cpu(
    clock,
    PC,
    IFID_IR,
    IDEX_IR,
    EXMEM_IR,
    MEMWB_IR,
    WD);
    always #1 clock = ~clock;
    initial begin
        $display ("PC  IFID_IR  IDEX_IR  EXMEM_IR  MEMWB_IR  WD");
        $monitor ("%2d  %h     %h     %h      %h  %d (%h)", 
        PC, IFID_IR, IDEX_IR, EXMEM_IR, MEMWB_IR, WD, WD);
        clock = 1;
        #72;
        $display("CPU halted.");
        $finish;
    end
endmodule
// === END OF TESTBENCH ===

// With nops, branch not taken
/*
PC  IFID_IR  IDEX_IR  EXMEM_IR  MEMWB_IR  WD
 0  0000     xxxx     xxxx      xxxx       x (xxxx)
 2  8100     0000     xxxx      xxxx       x (xxxx)
 4  8204     8100     0000      xxxx       x (xxxx)
 6  0000     8204     8100      0000       0 (0000)
 8  0000     0000     8204      8100       5 (0005)
10  0000     0000     0000      8204       7 (0007)
12  66c0     0000     0000      0000       0 (0000)
14  0000     66c0     0000      0000       0 (0000)
16  0000     0000     66c0      0000       0 (0000)
18  0000     0000     0000      66c0       1 (0001)
20  a307     0000     0000      0000       0 (0000)
22  0000     a307     0000      0000       0 (0000)
24  0000     0000     a307      0000       0 (0000)
26  0000     0000     0000      a307      -1 (ffff)
28  9104     0000     0000      0000       0 (0000)
30  9200     9104     0000      0000       0 (0000)
32  0000     9200     9104      0000       0 (0000)
34  0000     0000     9200      9104       4 (0004)
36  0000     0000     0000      9200       0 (0000)
38  8100     0000     0000      0000       0 (0000)
40  8204     8100     0000      0000       0 (0000)
42  0000     8204     8100      0000       0 (0000)
44  0000     0000     8204      8100       7 (0007)
46  0000     0000     0000      8204       5 (0005)
48  4a80     0000     0000      0000       0 (0000)
50  0000     4a80     0000      0000       0 (0000)
52  0000     0000     4a80      0000       0 (0000)
54  0000     0000     0000      4a80      -6 (fffa)
56  7a01     0000     0000      0000       0 (0000)
58  0000     7a01     0000      0000       0 (0000)
60  0000     0000     7a01      0000       0 (0000)
62  0000     0000     0000      7a01      -5 (fffb)
64  06c0     0000     0000      0000       0 (0000)
66  xxxx     06c0     0000      0000       0 (0000)
68  xxxx     xxxx     06c0      0000       0 (0000)
70  xxxx     xxxx     xxxx      06c0       2 (0002)
72  xxxx     xxxx     xxxx      xxxx       x (xxxx)
CPU halted.
 */

// With nops, branch taken
/*
PC  IFID_IR  IDEX_IR  EXMEM_IR  MEMWB_IR  WD
 0  0000     xxxx     xxxx      xxxx       x (xxxx)
 2  8100     0000     xxxx      xxxx       x (xxxx)
 4  8204     8100     0000      xxxx       x (xxxx)
 6  0000     8204     8100      0000       0 (0000)
 8  0000     0000     8204      8100       7 (0007)
10  0000     0000     0000      8204       5 (0005)
12  66c0     0000     0000      0000       0 (0000)
14  0000     66c0     0000      0000       0 (0000)
16  0000     0000     66c0      0000       0 (0000)
18  0000     0000     0000      66c0       0 (0000)
20  a307     0000     0000      0000       0 (0000)
22  0000     a307     0000      0000       0 (0000)
24  0000     0000     a307      0000       0 (0000)
34  0000     0000     0000      a307       0 (0000)
36  0000     0000     0000      0000       0 (0000)
38  8100     0000     0000      0000       0 (0000)
40  8204     8100     0000      0000       0 (0000)
42  0000     8204     8100      0000       0 (0000)
44  0000     0000     8204      8100       7 (0007)
46  0000     0000     0000      8204       5 (0005)
48  4a80     0000     0000      0000       0 (0000)
50  0000     4a80     0000      0000       0 (0000)
52  0000     0000     4a80      0000       0 (0000)
54  0000     0000     0000      4a80      -6 (fffa)
56  7a01     0000     0000      0000       0 (0000)
58  0000     7a01     0000      0000       0 (0000)
60  0000     0000     7a01      0000       0 (0000)
62  0000     0000     0000      7a01      -5 (fffb)
64  06c0     0000     0000      0000       0 (0000)
66  xxxx     06c0     0000      0000       0 (0000)
68  xxxx     xxxx     06c0      0000       0 (0000)
70  xxxx     xxxx     xxxx      06c0       2 (0002)
72  xxxx     xxxx     xxxx      xxxx       x (xxxx)
74  xxxx     xxxx     xxxx      xxxx       x (xxxx)
76  xxxx     xxxx     xxxx      xxxx       x (xxxx)
78  xxxx     xxxx     xxxx      xxxx       x (xxxx)
80  xxxx     xxxx     xxxx      xxxx       x (xxxx)
CPU halted.
*/

//  Without nops, branch not taken
/*
PC  IFID_IR  IDEX_IR  EXMEM_IR  MEMWB_IR  WD
 0  0000     xxxx     xxxx      xxxx       x (xxxx)
 2  8100     0000     xxxx      xxxx       x (xxxx)
 4  8204     8100     0000      xxxx       x (xxxx)
 6  66c0     8204     8100      0000       0 (0000)
 8  a307     66c0     8204      8100       5 (0005)
10  9104     a307     66c0      8204       7 (0007)
12  9200     9104     a307      66c0       X (000X)
 X  8100     9200     9104      a307       x (xxxx)
 X  xxxx     8100     9200      9104       4 (0004)
 X  xxxx     xxxx     8100      9200       0 (0000)
 X  xxxx     xxxx     xxxx      8100       7 (0007)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
CPU halted.
  */

//  Without nops, branch taken
/*
PC  IFID_IR  IDEX_IR  EXMEM_IR  MEMWB_IR  WD
 0  0000     xxxx     xxxx      xxxx       x (xxxx)
 2  8100     0000     xxxx      xxxx       x (xxxx)
 4  8204     8100     0000      xxxx       x (xxxx)
 6  66c0     8204     8100      0000       0 (0000)
 8  a307     66c0     8204      8100       7 (0007)
10  9104     a307     66c0      8204       5 (0005)
12  9200     9104     a307      66c0       X (000X)
 X  8100     9200     9104      a307       x (xxxx)
 X  xxxx     8100     9200      9104       4 (0004)
 X  xxxx     xxxx     8100      9200       0 (0000)
 X  xxxx     xxxx     xxxx      8100       5 (0005)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
 X  xxxx     xxxx     xxxx      xxxx       x (xxxx)
CPU halted.
*/