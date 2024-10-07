// Author(s): Joey Conroy
module RegisterFile (
    input [1:0] RR1, RR2, WR,
    input [15:0] WD,
    input RegWrite,
    input clock,
    output [15:0] RD1, RD2
);
    reg [15:0] Regs[0:3];
    assign RD1 = Regs[RR1];
    assign RD2 = Regs[RR2];
    initial begin
        Regs[0] = 0;
        Regs[1] = 0;
        Regs[2] = 0;
        Regs[3] = 0;
    end
    always @(negedge clock)
        if (RegWrite == 1 && WR != 0)
            Regs[WR] <= WD;
endmodule