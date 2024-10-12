// Author(s): Joey Conroy
// RegisterFile Module: This stores four 16-bit values in registers.
// Two registers can be read at the same time (RD1, RD2), and 
// one register can be written to (WD), based on the control signals.

module RegisterFile (
    // 2-bit numbers used to select which registers to read
    input [1:0] RR1, RR2,             

    // 2-bit number to select which register to write to
    input [1:0] WR,                   

    // 16-bit value to write into the selected register
    input [15:0] WD,                  

    // Control signal: 1 enables writing, 0 disables it
    input RegWrite,                   

    // Clock signal to control when writing happens
    input clock,                      

    // 16-bit values read from the two selected registers
    output [15:0] RD1, RD2            
);

    // Define four 16-bit registers
    reg [15:0] Regs[0:3];             

    // Assign the values of the selected registers to the outputs
    assign RD1 = Regs[RR1];           
    assign RD2 = Regs[RR2];           

    // Initialize all registers to 0 at the start
    initial begin
        Regs[0] = 0;
        Regs[1] = 0;
        Regs[2] = 0;
        Regs[3] = 0;
    end

    // On the falling edge of the clock signal, write to the register if RegWrite is enabled and WR is not 0
    always @(negedge clock)
        if (RegWrite == 1 && WR != 0)
            Regs[WR] <= WD;
endmodule
