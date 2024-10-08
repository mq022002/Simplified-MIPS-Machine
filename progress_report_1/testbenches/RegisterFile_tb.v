// Author(s): Joey Conroy
// Register File Testbench (RegisterFile_tb): This testbench simulates the RegisterFile 
// module by providing various register read/write operations and observing the output.

module RegisterFile_tb;

    // Registers to hold the input values for read/write register numbers (RR1, RR2, WR)
    reg [1:0] RR1, RR2, WR;

    // Register to hold the write data (WD)
    reg [15:0] WD;

    // Register to control the write enable (RegWrite) and clock signal
    reg RegWrite, clock;

    // Wires to capture the read data outputs from the RegisterFile (RD1, RD2)
    wire [15:0] RD1, RD2;

    // Instantiate the RegisterFile module for testing
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

    // Generate the clock signal by toggling every 5 time units
    always #5 clock = ~clock;

    // Test sequence to apply different register operations and display the results
    initial begin
        clock = 0; 
        RegWrite = 1; 
        WD = 0;

        // Perform read and write operations on the registers at different time intervals
        #10 RR1 = 0; RR2 = 0;
        #10 WR = 1; RR1 = 1; RR2 = 1; clock = 1;
        #10 clock = 0;
        #10 WR = 2; RR1 = 2; RR2 = 2; clock = 1;
        #10 clock = 0;
        #10 WR = 3; RR1 = 3; RR2 = 3; clock = 1;
        #10 clock = 0;

        // Disable writing and modify WD values to observe the effects
        #10 RegWrite = 0;
        #10 WD = 16'hAAAA;
        #10 WR = 1; RR1 = 1; RR2 = 1; clock = 1;
        #10 clock = 0;
        #10 WR = 2; RR1 = 2; RR2 = 2; clock = 1;
        #10 clock = 0;
        #10 WR = 3; RR1 = 3; RR2 = 3; clock = 1;
        #10 clock = 0;

        // Enable writing again with new values for WD
        #10 RegWrite = 1;
        #10 WD = 16'h5555;
        #10 WR = 1; RR1 = 1; RR2 = 1; clock = 1;
        #10 clock = 0;
        #10 WR = 2; RR1 = 2; RR2 = 2; clock = 1;
        #10 clock = 0;
        #10 WR = 3; RR1 = 3; RR2 = 3; clock = 1;
        #10 clock = 0;

        // End the test
        $finish;
    end

    // Monitor the state of the registers and display the results at each time step
    initial begin
        $monitor("regwrite=%d clock=%d RR1=%d RR2=%d WR=%d WD=%h RD1=%h RD2=%h", 
                 RegWrite, clock, RR1, RR2, WR, WD, RD1, RD2);
    end
endmodule

/*
regwrite=1 clock=0 RR1=x RR2=x WR=x WD=0000 RD1=xxxx RD2=xxxx
regwrite=1 clock=1 RR1=x RR2=x WR=x WD=0000 RD1=xxxx RD2=xxxx
regwrite=1 clock=0 RR1=0 RR2=0 WR=x WD=0000 RD1=0000 RD2=0000
regwrite=1 clock=1 RR1=0 RR2=0 WR=x WD=0000 RD1=0000 RD2=0000
regwrite=1 clock=0 RR1=1 RR2=1 WR=1 WD=0000 RD1=0000 RD2=0000
regwrite=1 clock=1 RR1=1 RR2=1 WR=1 WD=0000 RD1=0000 RD2=0000
regwrite=1 clock=1 RR1=1 RR2=1 WR=1 WD=0000 RD1=0000 RD2=0000
regwrite=1 clock=0 RR1=1 RR2=1 WR=1 WD=0000 RD1=0000 RD2=0000
regwrite=1 clock=0 RR1=2 RR2=2 WR=2 WD=0000 RD1=0000 RD2=0000
regwrite=1 clock=1 RR1=2 RR2=2 WR=2 WD=0000 RD1=0000 RD2=0000
regwrite=1 clock=1 RR1=2 RR2=2 WR=2 WD=0000 RD1=0000 RD2=0000
regwrite=1 clock=0 RR1=2 RR2=2 WR=2 WD=0000 RD1=0000 RD2=0000
regwrite=1 clock=0 RR1=3 RR2=3 WR=3 WD=0000 RD1=0000 RD2=0000
regwrite=1 clock=1 RR1=3 RR2=3 WR=3 WD=0000 RD1=0000 RD2=0000
regwrite=1 clock=1 RR1=3 RR2=3 WR=3 WD=0000 RD1=0000 RD2=0000
regwrite=1 clock=0 RR1=3 RR2=3 WR=3 WD=0000 RD1=0000 RD2=0000
regwrite=0 clock=1 RR1=3 RR2=3 WR=3 WD=0000 RD1=0000 RD2=0000
regwrite=0 clock=0 RR1=3 RR2=3 WR=3 WD=0000 RD1=0000 RD2=0000
regwrite=0 clock=1 RR1=3 RR2=3 WR=3 WD=aaaa RD1=0000 RD2=0000
regwrite=0 clock=0 RR1=3 RR2=3 WR=3 WD=aaaa RD1=0000 RD2=0000
regwrite=0 clock=0 RR1=1 RR2=1 WR=1 WD=aaaa RD1=0000 RD2=0000
regwrite=0 clock=1 RR1=1 RR2=1 WR=1 WD=aaaa RD1=0000 RD2=0000
regwrite=0 clock=1 RR1=1 RR2=1 WR=1 WD=aaaa RD1=0000 RD2=0000
regwrite=0 clock=0 RR1=1 RR2=1 WR=1 WD=aaaa RD1=0000 RD2=0000
regwrite=0 clock=0 RR1=2 RR2=2 WR=2 WD=aaaa RD1=0000 RD2=0000
regwrite=0 clock=1 RR1=2 RR2=2 WR=2 WD=aaaa RD1=0000 RD2=0000
regwrite=0 clock=1 RR1=2 RR2=2 WR=2 WD=aaaa RD1=0000 RD2=0000
regwrite=0 clock=0 RR1=2 RR2=2 WR=2 WD=aaaa RD1=0000 RD2=0000
regwrite=0 clock=0 RR1=3 RR2=3 WR=3 WD=aaaa RD1=0000 RD2=0000
regwrite=0 clock=1 RR1=3 RR2=3 WR=3 WD=aaaa RD1=0000 RD2=0000
regwrite=0 clock=1 RR1=3 RR2=3 WR=3 WD=aaaa RD1=0000 RD2=0000
regwrite=0 clock=0 RR1=3 RR2=3 WR=3 WD=aaaa RD1=0000 RD2=0000
regwrite=1 clock=1 RR1=3 RR2=3 WR=3 WD=aaaa RD1=0000 RD2=0000
regwrite=1 clock=0 RR1=3 RR2=3 WR=3 WD=aaaa RD1=aaaa RD2=aaaa
regwrite=1 clock=1 RR1=3 RR2=3 WR=3 WD=5555 RD1=aaaa RD2=aaaa
regwrite=1 clock=0 RR1=3 RR2=3 WR=3 WD=5555 RD1=5555 RD2=5555
regwrite=1 clock=0 RR1=1 RR2=1 WR=1 WD=5555 RD1=5555 RD2=5555
regwrite=1 clock=1 RR1=1 RR2=1 WR=1 WD=5555 RD1=5555 RD2=5555
regwrite=1 clock=1 RR1=1 RR2=1 WR=1 WD=5555 RD1=5555 RD2=5555
regwrite=1 clock=0 RR1=1 RR2=1 WR=1 WD=5555 RD1=5555 RD2=5555
regwrite=1 clock=0 RR1=2 RR2=2 WR=2 WD=5555 RD1=5555 RD2=5555
regwrite=1 clock=1 RR1=2 RR2=2 WR=2 WD=5555 RD1=5555 RD2=5555
regwrite=1 clock=1 RR1=2 RR2=2 WR=2 WD=5555 RD1=5555 RD2=5555
regwrite=1 clock=0 RR1=2 RR2=2 WR=2 WD=5555 RD1=5555 RD2=5555
regwrite=1 clock=0 RR1=3 RR2=3 WR=3 WD=5555 RD1=5555 RD2=5555
regwrite=1 clock=1 RR1=3 RR2=3 WR=3 WD=5555 RD1=5555 RD2=5555
testbenches/RegisterFile_tb.v:52: $finish called at 230 (1s)
regwrite=1 clock=1 RR1=3 RR2=3 WR=3 WD=5555 RD1=5555 RD2=5555
*/
