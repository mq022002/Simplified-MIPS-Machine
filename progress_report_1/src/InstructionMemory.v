// Author(s): Matthew Quijano
module InstructionMemory (
    input [15:0] address,
    output [15:0] instruction
);
    reg [15:0] memory [0:1023];

    initial begin
        memory[0] = 16'h2009;
        memory[1] = 16'h200A;
        memory[2] = 16'h012A;
        memory[3] = 16'h012B;
        memory[4] = 16'h014B;
        memory[5] = 16'h014B;
        memory[6] = 16'h016A;
    end

    assign instruction = memory[address[9:0]];
endmodule

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
