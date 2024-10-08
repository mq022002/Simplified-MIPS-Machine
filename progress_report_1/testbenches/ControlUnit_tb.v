// Author(s): Matthew Quijano
module ControlUnit_tb;
    reg [3:0] Op;
    wire RegDst, ALUSrc, RegWrite;
    wire [3:0] ALUControl;

    ControlUnit uut (
        .Op(Op),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .ALUControl(ALUControl)
    );

    initial begin
        Op = 4'b0000;
        #10 Op = 4'b0001;
        #10 Op = 4'b0010;
        #10 Op = 4'b0011;
        #10 Op = 4'b0100;
        #10 Op = 4'b0101;
        #10 Op = 4'b0110;
        #10 Op = 4'b0111;
        #10 Op = 4'b1000;
        #10 $finish;
    end

    initial begin
        $display("Time        Op            RegDst     ALUSrc     RegWrite   ALUControl");
        $monitor("%2t          %b          %b          %b          %b          %b", 
                 $time, Op, RegDst, ALUSrc, RegWrite, ALUControl);
    end
endmodule

/*
Time        Op            RegDst     ALUSrc     RegWrite   ALUControl
 0          0000          1          0          1          0010
10          0001          1          0          1          0110
20          0010          1          0          1          0000
30          0011          1          0          1          0001
40          0100          1          0          1          1100
50          0101          1          0          1          1101
60          0110          1          0          1          0111
70          0111          0          1          1          0010
80          1000          0          0          0          0000
testbenches/ControlUnit_tb.v:25: $finish called at 90 (1s)
*/