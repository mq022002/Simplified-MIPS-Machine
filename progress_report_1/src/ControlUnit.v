// Author(s): Matthew Quijano
// Control Unit Module: This module generates control signals for the CPU based on the operation (Op) code.
// It outputs control signals like RegDst, ALUSrc, RegWrite, and ALUControl to guide the operation of other components.

module ControlUnit (
    // 4-bit operation code input that determines the instruction type
    input [3:0] Op,

    // Control signal for selecting the destination register
    output reg RegDst,

    // Control signal to choose between register data or immediate value for ALU input
    output reg ALUSrc,

    // Control signal to enable writing data to the register
    output reg RegWrite,

    // 4-bit control signal that determines the operation performed by the ALU
    output reg [3:0] ALUControl
);

    // Always block that sets control signals based on the Op code
    always @(*)
        // Case statement to check the Op code and set control signals accordingly
        case (Op)
            // Op 0000: Add instruction
            4'b0000: begin
                RegDst   = 1;
                ALUSrc   = 0;
                RegWrite = 1;
                ALUControl   = 4'b0010;
            end

            // Op 0001: Subtract instruction
            4'b0001: begin
                RegDst   = 1;
                ALUSrc   = 0;
                RegWrite = 1;
                ALUControl   = 4'b0110;
            end

            // Op 0010: AND instruction
            4'b0010: begin
                RegDst   = 1;
                ALUSrc   = 0;
                RegWrite = 1;
                ALUControl   = 4'b0000;
            end

            // Op 0011: OR instruction
            4'b0011: begin
                RegDst   = 1;
                ALUSrc   = 0;
                RegWrite = 1;
                ALUControl   = 4'b0001;
            end

            // Op 0100: NOR instruction
            4'b0100: begin
                RegDst   = 1;
                ALUSrc   = 0;
                RegWrite = 1;
                ALUControl   = 4'b1100;
            end

            // Op 0101: NAND instruction
            4'b0101: begin
                RegDst   = 1;
                ALUSrc   = 0;
                RegWrite = 1;
                ALUControl   = 4'b1101;
            end

            // Op 0110: Set less than instruction
            4'b0110: begin
                RegDst   = 1;
                ALUSrc   = 0;
                RegWrite = 1;
                ALUControl   = 4'b0111;
            end

            // Op 0111: Load immediate instruction
            4'b0111: begin
                RegDst   = 0;
                ALUSrc   = 1;
                RegWrite = 1;
                ALUControl   = 4'b0010;
            end

            // Default case: No operation, disable writes and default ALUControl
            default: begin
                RegDst   = 0;
                ALUSrc   = 0;
                RegWrite = 0;
                ALUControl   = 4'b0000;
            end
        endcase
endmodule
