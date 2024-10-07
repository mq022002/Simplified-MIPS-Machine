// Author(s): Abbie Mathew
module ALU (
    input [3:0] ALUControl,
    input [15:0] A, B,
    output reg [15:0] ALUOut,
    output Zero
);
    always @(*)
        case (ALUControl)
            4'b0000: ALUOut = A & B;
            4'b0001: ALUOut = A | B;
            4'b0010: ALUOut = A + B;
            4'b0110: ALUOut = A - B;
            4'b0111: ALUOut = (A < B) ? 1 : 0;
            4'b1100: ALUOut = ~(A | B);
            4'b1101: ALUOut = ~(A & B);
            default: ALUOut = 16'h0000;
        endcase
    assign Zero = (ALUOut == 0);
endmodule

// Author(s): Abbie Mathew
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


// Author(s): Matthew Quijano
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

// Author(s): Joey Conrory, Abbie Mathew
module CPU (
    input clock,
    output [15:0] PC,
    output [15:0] ALUOut,
    output [15:0] IR
);
    reg [15:0] PC_reg;
    reg [15:0] IMemory[0:1023];
    wire [15:0] NextPC, A, RD2, B, SignExtend;
    wire [3:0] ALUControl;
    wire [1:0] WR;
    wire RegDst, ALUSrc, RegWrite, Zero;

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

    initial PC_reg = 0;
    assign PC = PC_reg;
    assign IR = IMemory[PC_reg >> 1];

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

    always @(negedge clock)
        PC_reg <= NextPC;
endmodule

// Author(s): Joey Conroy, Abbie Mathew
module CPU_tb;
    reg clock;
    wire [15:0] ALUOut, IR, PC;

    CPU test_cpu(
        .clock(clock),
        .PC(PC),
        .ALUOut(ALUOut),
        .IR(IR)
    );

    always #1 clock = ~clock;

    initial begin
        $display("Clock PC   IR                 WD");
        $monitor("%b     %2d   %b  %3d (%b)", clock, PC, IR, ALUOut, ALUOut);
        clock = 1;
        #34 $finish;
    end
endmodule