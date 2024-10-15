// Author(s): Joey Conroy, Abbie Mathew, Matthew Quijano
module Mux4To1(input in0, input in1, input in2, input in3, input [1:0] sel, output y);
    wire sel0_n, sel1_n, and0, and1, and2, and3;
    not (sel0_n, sel[0]);
    not (sel1_n, sel[1]);
    and (and0, in0, sel1_n, sel0_n);
    and (and1, in1, sel1_n, sel[0]);
    and (and2, in2, sel[1], sel0_n);
    and (and3, in3, sel[1], sel[0]);
    or (y, and0, and1, and2, and3);
endmodule