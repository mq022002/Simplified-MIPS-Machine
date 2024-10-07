// Author(s): Abbie Mathew
module ALU (
    input [3:0] ALUControl,
    input [15:0] A, B,
    output reg signed [15:0] ALUOut,
    output Zero
);
    wire [15:0] AndResult, OrResult, Sum, NorResult, NandResult, B_in;
    wire CarryOut, Binvert, Less;

    assign Binvert = (ALUControl == 4'b0110) || (ALUControl == 4'b0111);
    assign B_in = Binvert ? ~B : B;

    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin
            and (AndResult[i], A[i], B[i]);
            or (OrResult[i], A[i], B[i]);
            nor (NorResult[i], A[i], B[i]);
            nand (NandResult[i], A[i], B[i]);
        end
    endgenerate

    wire [15:0] Carry;
    assign Sum[0] = A[0] ^ B_in[0] ^ Binvert;
    assign Carry[0] = (A[0] & B_in[0]) | (A[0] & Binvert) | (B_in[0] & Binvert);

    generate
        for (i = 1; i < 16; i = i + 1) begin
            assign Sum[i] = A[i] ^ B_in[i] ^ Carry[i-1];
            assign Carry[i] = (A[i] & B_in[i]) | (A[i] & Carry[i-1]) | (B_in[i] & Carry[i-1]);
        end
    endgenerate

    assign Less = (Sum[15] == 1) ? 1 : 0;

    always @(*) begin
        case (ALUControl)
            4'b0000: ALUOut = AndResult;
            4'b0001: ALUOut = OrResult;
            4'b0010: ALUOut = Sum;
            4'b0110: ALUOut = Sum;
            4'b0111: ALUOut = (Less) ? 16'b1 : 16'b0;
            4'b1100: ALUOut = NorResult;
            4'b1101: ALUOut = NandResult;
            default: ALUOut = 16'b0;
        endcase
    end

    assign Zero = (ALUOut == 16'b0);
endmodule