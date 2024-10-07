// Author(s): Abbie Mathew
module ALU_tb;
    reg [3:0] ALUControl;
    reg signed [15:0] A, B;
    wire signed [15:0] ALUOut;
    wire Zero;

    ALU uut (
        .ALUControl(ALUControl),
        .A(A),
        .B(B),
        .ALUOut(ALUOut),
        .Zero(Zero)
    );

    initial begin
        $display("op   a                     b                     result                zero");
        $monitor ("%b %b(%2d)  %b(%2d)  %b(%2d)  %b",ALUControl,A,A,B,B,ALUOut,ALUOut,Zero);
        
        ALUControl = 4'b0000; A = 16'b0111; B = 16'b0001;
        #1 ALUControl = 4'b0001; A = 16'b0101; B = 16'b0010;
        #1 ALUControl = 4'b0010; A = 16'b0100; B = 16'b0010;
        #1 ALUControl = 4'b0010; A = 16'b0111; B = 16'b0001;
        #1 ALUControl = 4'b0110; A = 16'b0101; B = 16'b0011;
        #1 ALUControl = 4'b0110; A = 16'b1111; B = 16'b0001;
        #1 ALUControl = 4'b0111; A = 16'b0101; B = 16'b0001;
        #1 ALUControl = 4'b0111; A = 16'b1110; B = 16'b1111;
        #1 ALUControl = 4'b1100; A = 16'b0101; B = 16'b0010;
        #1 ALUControl = 4'b1101; A = 16'b0101; B = 16'b0010;
        
        $finish;
    end
endmodule
