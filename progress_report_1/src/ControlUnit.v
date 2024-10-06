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
