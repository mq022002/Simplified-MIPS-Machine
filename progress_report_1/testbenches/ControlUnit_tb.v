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
