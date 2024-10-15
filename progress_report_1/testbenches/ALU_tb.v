// Author(s): Abbie Mathew
module ALU_tb;
    reg [3:0] op;
    reg signed [15:0] a, b;
    wire signed [15:0] result;
    wire zero;
    ALU uut (.op(op), .a(a), .b(b), .result(result), .zero(zero));
    initial begin
        $display("op   a                     b                     result                zero");
        $monitor("%b %b(%2d)  %b(%2d)  %b(%2d)  %b", op, a, a, b, b, result, result, zero);
        op = 4'b0000; a = 16'b0000000000000111; b = 16'b0000000000000001; #1;
        op = 4'b0001; a = 16'b0000000000000101; b = 16'b0000000000000010; #1;
        op = 4'b0010; a = 16'b0000000000000100; b = 16'b0000000000000010; #1;
        op = 4'b0010; a = 16'b0000000000000111; b = 16'b0000000000000001; #1;
        op = 4'b0110; a = 16'b0000000000000101; b = 16'b0000000000000011; #1;
        op = 4'b0110; a = 16'b0000000000001111; b = 16'b0000000000000001; #1;
        op = 4'b0111; a = 16'b0000000000000101; b = 16'b0000000000000001; #1;
        op = 4'b0111; a = 16'b0000000000001110; b = 16'b0000000000001111; #1;
        op = 4'b1100; a = 16'b0000000000000101; b = 16'b0000000000000010; #1;
        op = 4'b1101; a = 16'b0000000000000101; b = 16'b0000000000000010; #1;
        $finish;
    end
endmodule

/*
op   a                     b                     result                zero
0000 0000000000000111( 7)  0000000000000001( 1)  0000000000000001( 1)  0
0001 0000000000000101( 5)  0000000000000010( 2)  0000000000000111( 7)  0
0010 0000000000000100( 4)  0000000000000010( 2)  0000000000000110( 6)  0
0010 0000000000000111( 7)  0000000000000001( 1)  0000000000001000( 8)  0
0110 0000000000000101( 5)  0000000000000011( 3)  0000000000000010( 2)  0
0110 0000000000001111(15)  0000000000000001( 1)  0000000000001110(14)  0
0111 0000000000000101( 5)  0000000000000001( 1)  0000000000000000( 0)  1
0111 0000000000001110(14)  0000000000001111(15)  0000000000000001( 1)  0
1100 0000000000000101( 5)  0000000000000010( 2)  1111111111111000(-8)  0
1101 0000000000000101( 5)  0000000000000010( 2)  1111111111111111(-1)  0
testbenches/ALU_tb.v:21: $finish called at 10 (1s)
*/