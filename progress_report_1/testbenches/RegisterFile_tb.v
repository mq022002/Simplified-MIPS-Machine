// Author(s): Joey Conroy, Matthew Quijano
module RegisterFile_tb;
    reg [1:0] RR1;
    reg [1:0] RR2;
    reg [1:0] WR;
    reg [15:0] WD;
    reg RegWrite;
    reg clock;
    wire [15:0] RD1;
    wire [15:0] RD2;

    RegisterFile uut (
        .RR1(RR1),
        .RR2(RR2),
        .WR(WR),
        .WD(WD),
        .RegWrite(RegWrite),
        .clock(clock),
        .RD1(RD1),
        .RD2(RD2)
    );

    initial begin
        clock = 0;
        RegWrite = 0;
        WD = 16'h0000;
        RR1 = 2'b00;
        RR2 = 2'b01;
        WR = 2'b00;

        #5 RegWrite = 1; WR = 2'b01; WD = 16'hAAAA;
        #10 RegWrite = 0;

        #5 RR1 = 2'b01;

        #5 RegWrite = 1; WR = 2'b10; WD = 16'h5555;
        #10 RegWrite = 0;

        #5 RR2 = 2'b10;

        #20 $finish;
    end

    always #5 clock = ~clock;

    initial begin
        $monitor("Time: %0d | RR1: %b | RR2: %b | RD1: %h | RD2: %h", $time, RR1, RR2, RD1, RD2);
    end
endmodule
