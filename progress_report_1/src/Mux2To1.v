// Author(s): Joey Conroy, Abbie Mathew, Matthew Quijano
module Mux2To1 #(parameter N = 1) (input [N-1:0] a, input [N-1:0] b, input sel, output [N-1:0] y);
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin: mux_loop
            wire sel_n, a_and_sel_n, b_and_sel;
            not (sel_n, sel);
            and (a_and_sel_n, a[i], sel_n);
            and (b_and_sel, b[i], sel);
            or  (y[i], a_and_sel_n, b_and_sel);
        end
    endgenerate
endmodule