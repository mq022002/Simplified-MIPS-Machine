// Author(s): Matthew Quijano
module InstructionMemory_tb;
    reg [15:0] Address;
    wire [15:0] Instruction;
    InstructionMemory uut (
        .Address(Address),
        .Instruction(Instruction)
    );
    initial begin
        $display("Time        Address       Instruction");
        $monitor("%2t          %h          %h", $time, Address, Instruction);
        Address = 16'h0000;
        #10 Address = 16'h0002;
        #10 Address = 16'h0004;
        #10 Address = 16'h0006;
        #10 Address = 16'h0008;
        #10 Address = 16'h000A;
        #10 Address = 16'h000C;
        #10 Address = 16'h000E;
        #10 Address = 16'h0010;
        #10 Address = 16'h0012;
        $finish;
    end
endmodule

/*
Time        Address       Instruction
 0          0000          710f
10          0002          7207
20          0004          26c0
30          0006          16c0
40          0008          3980
50          000a          06c0
60          000c          4740
70          000e          710f
80          0010          65ff
testbenches/InstructionMemory_tb.v:22: $finish called at 90 (1s)
90          0012          ffff
*/