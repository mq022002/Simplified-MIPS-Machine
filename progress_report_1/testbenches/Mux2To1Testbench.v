// Author(s): Joey Conroy, Abbie Mathew, Matthew Quijano
module Mux2To1_tb;
    parameter N = 4;
    reg [N-1:0] a, b;
    reg sel;
    wire [N-1:0] y;
    Mux2To1 #(N) uut (.a(a), .b(b), .sel(sel), .y(y));
    initial begin
        $display("Time sel a      b      y");
        a = 4'b0001; b = 4'b0010; sel = 0; #10;
        $display("%0t    %b    %b    %b    %b", $time, sel, a, b, y);
        a = 4'b0001; b = 4'b0010; sel = 1; #10;
        $display("%0t    %b    %b    %b    %b", $time, sel, a, b, y);
        a = 4'b1111; b = 4'b0000; sel = 0; #10;
        $display("%0t    %b    %b    %b    %b", $time, sel, a, b, y);
        a = 4'b1111; b = 4'b0000; sel = 1; #10;
        $display("%0t    %b    %b    %b    %b", $time, sel, a, b, y);
        a = 4'b1010; b = 4'b0101; sel = 0; #10;
        $display("%0t    %b    %b    %b    %b", $time, sel, a, b, y);
        a = 4'b1010; b = 4'b0101; sel = 1; #10;
        $display("%0t    %b    %b    %b    %b", $time, sel, a, b, y);
        $finish;
    end
endmodule

/*
Time sel a      b      y
10    0    0001    0010    0001
20    1    0001    0010    0010
30    0    1111    0000    1111
40    1    1111    0000    0000
50    0    1010    0101    1010
60    1    1010    0101    0101
testbenches/Mux2To1Testbench.v:22: $finish called at 60 (1s)
*/