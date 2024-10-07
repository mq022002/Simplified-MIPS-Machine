// Author(s): Joey Conroy
module RegisterFile_tb;
    reg [1:0] RR1, RR2, WR;
    reg [15:0] WD;
    reg RegWrite, clock;
    wire [15:0] RD1, RD2;

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

    always #5 clock = ~clock;

    initial begin
        clock = 0; 
        RegWrite = 1; 
        WD = 0;

        #10 RR1 = 0; RR2 = 0;
        #10 WR = 1; RR1 = 1; RR2 = 1; clock = 1;
        #10 clock = 0;
        #10 WR = 2; RR1 = 2; RR2 = 2; clock = 1;
        #10 clock = 0;
        #10 WR = 3; RR1 = 3; RR2 = 3; clock = 1;
        #10 clock = 0;

        #10 RegWrite = 0;
        #10 WD = 16'hAAAA;
        #10 WR = 1; RR1 = 1; RR2 = 1; clock = 1;
        #10 clock = 0;
        #10 WR = 2; RR1 = 2; RR2 = 2; clock = 1;
        #10 clock = 0;
        #10 WR = 3; RR1 = 3; RR2 = 3; clock = 1;
        #10 clock = 0;

        #10 RegWrite = 1;
        #10 WD = 16'h5555;
        #10 WR = 1; RR1 = 1; RR2 = 1; clock = 1;
        #10 clock = 0;
        #10 WR = 2; RR1 = 2; RR2 = 2; clock = 1;
        #10 clock = 0;
        #10 WR = 3; RR1 = 3; RR2 = 3; clock = 1;
        #10 clock = 0;

        $finish;
    end

    initial begin
        $monitor("regwrite=%d clock=%d RR1=%d RR2=%d WR=%d WD=%h RD1=%h RD2=%h", 
                 RegWrite, clock, RR1, RR2, WR, WD, RD1, RD2);
    end
endmodule
