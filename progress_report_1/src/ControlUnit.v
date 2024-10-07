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