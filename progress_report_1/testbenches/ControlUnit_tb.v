`timescale 1ns / 1ps

module ControlUnit_tb;
    reg [3:0] opcode;
    wire RegWrite;
    wire [3:0] ALUControl;
    wire ALUSrc;

    ControlUnit uut (
        .opcode(opcode),
        .RegWrite(RegWrite),
        .ALUControl(ALUControl),
        .ALUSrc(ALUSrc)
    );

    initial begin
        $display("Time\tOpcode\tRegWrite\tALUControl\tALUSrc");
        $monitor("%0d\t%b\t%b\t\t%b\t\t%b", $time, opcode, RegWrite, ALUControl, ALUSrc);

        opcode = 4'b0000;
        #10;

        opcode = 4'b0001;
        #10;

        opcode = 4'b0010;
        #10;

        opcode = 4'b1111;
        #10;

        $finish;
    end
endmodule
