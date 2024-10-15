// Author(s): Joey Conroy, Abbie Mathew, Matthew Quijano
module Mux4To1_tb;
    reg in0, in1, in2, in3;
    reg [1:0] sel;
    wire y;
    Mux4To1 uut (.in0(in0), .in1(in1), .in2(in2), .in3(in3), .sel(sel), .y(y));
    initial begin
        $display("Time sel  in0 in1 in2 in3 y");
        $monitor("%2t   %b   %b   %b   %b   %b   %b", $time, sel, in0, in1, in2, in3, y);
        sel = 2'b00; in0 = 1; in1 = 0; in2 = 0; in3 = 0; #10;
        sel = 2'b01; in0 = 0; in1 = 1; in2 = 0; in3 = 0; #10;
        sel = 2'b10; in0 = 0; in1 = 0; in2 = 1; in3 = 0; #10;
        sel = 2'b11; in0 = 0; in1 = 0; in2 = 0; in3 = 1; #10;
        sel = 2'b10; in0 = 1; in1 = 1; in2 = 1; in3 = 1; #10;
        sel = 2'b00; in0 = 0; in1 = 1; in2 = 1; in3 = 1; #10;
        $finish;
    end
endmodule

/*
Time sel  in0 in1 in2 in3 y
 0   00   1   0   0   0   1
10   01   0   1   0   0   1
20   10   0   0   1   0   1
30   11   0   0   0   1   1
40   10   1   1   1   1   1
50   00   0   1   1   1   0
testbenches/Mux4To1Testbench.v:16: $finish called at 60 (1s)
*/