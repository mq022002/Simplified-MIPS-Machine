// Author: Matthew Quijano
module PC (
    input clock,
    input reset,
    input [15:0] nextPC,
    output reg [15:0] PC
);
    always @(posedge clock or posedge reset) begin
        if (reset) 
            PC <= 16'h0000;
        else 
            PC <= nextPC;
    end
endmodule
