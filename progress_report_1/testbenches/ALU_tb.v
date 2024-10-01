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
