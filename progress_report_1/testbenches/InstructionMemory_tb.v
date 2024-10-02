// Author(s): Matthew Quijano
module instruction_memory_tb;
    reg [15:0] address;
    wire [15:0] instruction;

    InstructionMemory uut (
        .address(address),
        .instruction(instruction)
    );

    initial begin
        address = 16'h0000;
        #10 address = 16'h0002;
        #10 address = 16'h0004;
        #10 address = 16'h0006;
        #10 $finish;
    end

    initial begin
        $monitor("Time: %0d | Address: %h | Instruction: %h", $time, address, instruction);
    end
endmodule
