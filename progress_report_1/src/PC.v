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

// Author: Matthew Quijano
module pc_tb;
    reg clock;
    reg reset;
    reg [15:0] nextPC;
    wire [15:0] PC;

    PC uut (
        .clock(clock),
        .reset(reset),
        .nextPC(nextPC),
        .PC(PC)
    );

    initial begin
        clock = 0;
        reset = 1;
        nextPC = 16'h0004;
        #10 reset = 0;

        #10 nextPC = 16'h0008;
        #10 nextPC = 16'h000C;

        #30 $finish;
    end

    always #5 clock = ~clock;

    initial begin
        $monitor("Time: %0d | PC: %h | nextPC: %h | reset: %b", $time, PC, nextPC, reset);
    end
endmodule
