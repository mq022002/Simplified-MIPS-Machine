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

// Author(s): Joey Conroy
module ALU_tb;
    reg [15:0] A;
    reg [15:0] B;
    reg [3:0] ALUControl;
    wire [15:0] ALUOut;
    wire Zero;

    ALU uut (
        .A(A),
        .B(B),
        .ALUControl(ALUControl),
        .ALUOut(ALUOut),
        .Zero(Zero)
    );

    initial begin
        A = 16'h0000; B = 16'h0000; ALUControl = 4'b0000;
        #10 A = 16'hFFFF; B = 16'h00FF; ALUControl = 4'b0000;
        #10 A = 16'h1234; B = 16'h5678; ALUControl = 4'b0000;
        #10 ALUControl = 4'b0001; A = 16'hAAAA; B = 16'h5555;
        #10 ALUControl = 4'b0010; A = 16'h0001; B = 16'h0001;
        #10 ALUControl = 4'b0010; A = 16'hFFFF; B = 16'h0001;
        #10 ALUControl = 4'b0110; A = 16'h0002; B = 16'h0001;
        #10 ALUControl = 4'b0110; A = 16'h0001; B = 16'h0002;
        #10 ALUControl = 4'b0111; A = 16'h0001; B = 16'h0002;
        #10 ALUControl = 4'b0111; A = 16'h0003; B = 16'h0002;
        #10 ALUControl = 4'b1100; A = 16'hFFFF; B = 16'h0000;
        #10 ALUControl = 4'b1101; A = 16'hFFFF; B = 16'hFFFF;
        #10 $finish;
    end

    initial begin
        $monitor("Time=%0dns | A=%h | B=%h | Control=%b | ALUOut=%h | Zero=%b", 
                 $time, A, B, ALUControl, ALUOut, Zero);
    end
endmodule
