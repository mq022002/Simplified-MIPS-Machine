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

    reg_file register_file (
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
