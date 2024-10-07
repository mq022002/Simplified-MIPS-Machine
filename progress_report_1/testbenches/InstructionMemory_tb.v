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
