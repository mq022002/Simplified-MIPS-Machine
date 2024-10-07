// Author(s): Abbie Mathew
module ALU (
    input [15:0] A,
    input [15:0] B,
    input [3:0] ALUControl,
    output [15:0] ALUOut,
    output Zero
);
    wire [15:0] B_inverted;
    wire carry_in0;
    wire [15:0] sum;
    wire [15:0] carry_out;

    assign B_inverted = (ALUControl == 4'b0110) ? ~B : B;
    assign carry_in0 = (ALUControl == 4'b0110) ? 1'b1 : 1'b0;

    ALU1 alu0 (A[0], B_inverted[0], carry_in0, sum[0], carry_out[0]);
    ALU1 alu1 (A[1], B_inverted[1], carry_out[0], sum[1], carry_out[1]);
    ALU1 alu2 (A[2], B_inverted[2], carry_out[1], sum[2], carry_out[2]);
    ALU1 alu3 (A[3], B_inverted[3], carry_out[2], sum[3], carry_out[3]);
    ALU1 alu4 (A[4], B_inverted[4], carry_out[3], sum[4], carry_out[4]);
    ALU1 alu5 (A[5], B_inverted[5], carry_out[4], sum[5], carry_out[5]);
    ALU1 alu6 (A[6], B_inverted[6], carry_out[5], sum[6], carry_out[6]);
    ALU1 alu7 (A[7], B_inverted[7], carry_out[6], sum[7], carry_out[7]);
    ALU1 alu8 (A[8], B_inverted[8], carry_out[7], sum[8], carry_out[8]);
    ALU1 alu9 (A[9], B_inverted[9], carry_out[8], sum[9], carry_out[9]);
    ALU1 alu10 (A[10], B_inverted[10], carry_out[9], sum[10], carry_out[10]);
    ALU1 alu11 (A[11], B_inverted[11], carry_out[10], sum[11], carry_out[11]);
    ALU1 alu12 (A[12], B_inverted[12], carry_out[11], sum[12], carry_out[12]);
    ALU1 alu13 (A[13], B_inverted[13], carry_out[12], sum[13], carry_out[13]);
    ALU1 alu14 (A[14], B_inverted[14], carry_out[13], sum[14], carry_out[14]);
    ALU1 alu15 (A[15], B_inverted[15], carry_out[14], sum[15], carry_out[15]);

    wire [15:0] and_result, or_result, nor_result, nand_result;
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin
            and (and_result[i], A[i], B[i]);
            or  (or_result[i], A[i], B[i]);
            nor (nor_result[i], A[i], B[i]);
            nand (nand_result[i], A[i], B[i]);
        end
    endgenerate

    assign ALUOut = (ALUControl == 4'b0000) ? and_result :
                    (ALUControl == 4'b0001) ? or_result :
                    (ALUControl == 4'b0010 || ALUControl == 4'b0110) ? sum :
                    (ALUControl == 4'b0111) ? (A < B ? 16'h0001 : 16'h0000) :
                    (ALUControl == 4'b1100) ? nor_result :
                    (ALUControl == 4'b1101) ? nand_result :
                    16'h0000;

    assign Zero = (ALUOut == 16'b0);
endmodule

// Author(s): Abbie Mathew
module ALU1 (
    input A,
    input B,
    input carry_in,
    output Result,
    output carry_out
);
    wire sum, carry1, carry2, carry3;

    xor (sum, A, B, carry_in);
    and (carry1, A, B);
    and (carry2, A, carry_in);
    and (carry3, B, carry_in);
    or  (carry_out, carry1, carry2, carry3);

    assign Result = sum;
endmodule

// Author(s): Abbie Mathew
module RegisterFile (
    input [1:0] RR1,
    input [1:0] RR2,
    input [1:0] WR,
    input [15:0] WD,
    input RegWrite,
    input clock,
    output [15:0] RD1,
    output [15:0] RD2
);
    reg [15:0] Regs [3:0];

    initial begin
        Regs[0] = 16'h0000;
        Regs[1] = 16'h0000;
        Regs[2] = 16'h0000;
        Regs[3] = 16'h0000;
    end

    assign RD1 = Regs[RR1];
    assign RD2 = Regs[RR2];

    always @(negedge clock) begin
        if (RegWrite && WR != 2'b00) begin
            Regs[WR] <= WD;
        end
    end
endmodule


// Author(s): Matthew Quijano
module ControlUnit (
    input [3:0] opcode,
    output reg RegWrite,
    output reg [3:0] ALUControl,
    output reg ALUSrc
);
    always @(*) begin
        case (opcode)
            4'b0000: begin
                RegWrite = 1;
                ALUControl = 4'b0010;
                ALUSrc = 0;
            end
            4'b0001: begin
                RegWrite = 1;
                ALUControl = 4'b0010;
                ALUSrc = 1;
            end
            default: begin
                RegWrite = 0;
                ALUControl = 4'b0000;
                ALUSrc = 0;
            end
        endcase
    end
endmodule

// Author: Matthew Quijano
module PC (
    input clock,
    input reset,
    input [15:0] nextPC,
    output reg [15:0] PC
);
    always @(posedge clock or posedge reset) begin
        if (reset) 
            PC <= 16'h0000;
        else 
            PC <= nextPC;
    end
endmodule

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

// Author(s): Joey Conrory, Abbie Mathew
module CPU (
    input clock,
    input reset
);
    wire [15:0] PC, nextPC, instruction, RD1, RD2, ALUOut, ALUIn2, immediate;
    wire [3:0] ALUControl;
    wire RegWrite, ALUSrc, Zero;
    reg halt;

    initial begin
        halt = 0;
    end

    PC program_counter (
        .clock(clock),
        .reset(reset),
        .nextPC(halt ? PC : nextPC),
        .PC(PC)
    );

    InstructionMemory instr_mem (
        .address(PC),
        .instruction(instruction)
    );

    ControlUnit control_unit (
        .opcode(instruction[15:12]),
        .RegWrite(RegWrite),
        .ALUControl(ALUControl),
        .ALUSrc(ALUSrc)
    );

    RegisterFile register_file (
        .RR1(instruction[11:10]),
        .RR2(instruction[9:8]),
        .WR(instruction[7:6]),
        .WD(ALUOut),
        .RegWrite(RegWrite),
        .clock(clock),
        .RD1(RD1),
        .RD2(RD2)
    );

    assign immediate = {{8{instruction[7]}}, instruction[7:0]};

    assign ALUIn2 = (ALUSrc) ? immediate : RD2;

    ALU alu (
        .A(RD1),
        .B(ALUIn2),
        .ALUControl(ALUControl),
        .ALUOut(ALUOut),
        .Zero(Zero)
    );

    always @(posedge clock or posedge reset) begin
        if (reset)
            halt <= 0;
        else if (instruction == 16'hFFFF)
            halt <= 1;
    end

    assign nextPC = PC + 16'h0002;

endmodule

// Author(s): Joey Conroy, Abbie Mathew
module CPU_tb;
    reg clock;
    reg reset;

    CPU uut (
        .clock(clock),
        .reset(reset)
    );

    initial begin
        clock = 0;
        reset = 1;
        #10 reset = 0;
        #100 $finish;
    end

    always #5 clock = ~clock;

    initial begin
        $display("Clock PC   IR                  WD");
        $monitor("%b     %2d   %b  %3d (%b)", clock, uut.PC, uut.instruction, uut.ALUOut, uut.ALUOut);
    end
endmodule
