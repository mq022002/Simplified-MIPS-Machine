// Author(s): Abbie Mathew
module RegisterFile (
    input [1:0] RR1,
    input [1:0] RR2,
    input [1:0] WR,
    input [15:0] WD,
    input RegWrite,
    input clock,
    output [15:0] RD1,
    output [15:0] RD2
);
    reg [15:0] Regs [3:0];

    initial begin
        Regs[0] = 16'h0000;
        Regs[1] = 16'h0000;
        Regs[2] = 16'h0000;
        Regs[3] = 16'h0000;
    end

    assign RD1 = Regs[RR1];
    assign RD2 = Regs[RR2];

    always @(negedge clock) begin
        if (RegWrite && WR != 2'b00) begin
            Regs[WR] <= WD;
        end
    end
endmodule
