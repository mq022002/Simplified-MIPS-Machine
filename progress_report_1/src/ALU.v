// Author(s): Joey Conroy, Abbie Mathew, Matthew Quijano
// ALU Module: This is the main Arithmetic Logic Unit (ALU) that performs arithmetic and logic 
// operations on two 16-bit inputs (a and b) based on the operation code (op). It outputs the 
// result of the operation and a zero flag indicating if the result is zero.

module ALU (op, a, b, result, zero);
    
    // 4-bit operation code input
    input [3:0] op;

    // 16-bit inputs a and b
    input [15:0] a, b;

    // 16-bit result of the operation
    output [15:0] result;

    // Zero flag, set to 1 if the result is zero
    output zero;

    // Internal wires for carry propagation and set flag
    wire [15:0] carry;
    wire set;

    // Instantiate 16 1-bit ALUs for each bit of the inputs
    ALU1 alu0 (a[0], b[0], op[3], op[2], op[1:0], set, op[2], carry[0], result[0]);
    ALU1 alu1 (a[1], b[1], op[3], op[2], op[1:0], 1'b0, carry[0], carry[1], result[1]);
    ALU1 alu2 (a[2], b[2], op[3], op[2], op[1:0], 1'b0, carry[1], carry[2], result[2]);
    ALU1 alu3 (a[3], b[3], op[3], op[2], op[1:0], 1'b0, carry[2], carry[3], result[3]);
    ALU1 alu4 (a[4], b[4], op[3], op[2], op[1:0], 1'b0, carry[3], carry[4], result[4]);
    ALU1 alu5 (a[5], b[5], op[3], op[2], op[1:0], 1'b0, carry[4], carry[5], result[5]);
    ALU1 alu6 (a[6], b[6], op[3], op[2], op[1:0], 1'b0, carry[5], carry[6], result[6]);
    ALU1 alu7 (a[7], b[7], op[3], op[2], op[1:0], 1'b0, carry[6], carry[7], result[7]);
    ALU1 alu8 (a[8], b[8], op[3], op[2], op[1:0], 1'b0, carry[7], carry[8], result[8]);
    ALU1 alu9 (a[9], b[9], op[3], op[2], op[1:0], 1'b0, carry[8], carry[9], result[9]);
    ALU1 alu10 (a[10], b[10], op[3], op[2], op[1:0], 1'b0, carry[9], carry[10], result[10]);
    ALU1 alu11 (a[11], b[11], op[3], op[2], op[1:0], 1'b0, carry[10], carry[11], result[11]);
    ALU1 alu12 (a[12], b[12], op[3], op[2], op[1:0], 1'b0, carry[11], carry[12], result[12]);
    ALU1 alu13 (a[13], b[13], op[3], op[2], op[1:0], 1'b0, carry[12], carry[13], result[13]);
    ALU1 alu14 (a[14], b[14], op[3], op[2], op[1:0], 1'b0, carry[13], carry[14], result[14]);

    // The most significant bit (MSB) is handled by a separate ALUmsb module
    ALUmsb alu15 (a[15], b[15], op[3], op[2], op[1:0], 1'b0, carry[14], carry[15], result[15], set);

    // Zero flag is set if all result bits are zero
    nor nor1(zero, result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], 
             result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]);

endmodule

// Author(s): Joey Conroy, Abbie Mathew, Matthew Quijano
// ALU1 Module: 1-bit ALU that performs operations such as AND, OR, addition, and set-less-than.
// It takes 1-bit inputs and control signals, and produces a 1-bit result and carry-out.

module ALU1 (a, b, ainvert, binvert, op, less, carryin, carryout, result);
    
    // Inputs for 1-bit operands, control signals, and carry-in
    input a, b, less, carryin, ainvert, binvert;
    input [1:0] op;

    // Outputs for carry-out and result
    output carryout, result;

    // Internal wires for intermediate calculations
    wire a1, b1, a_and_b, a_or_b, sum, c1, c2;
    wire not_a, not_b;

    // Invert inputs if required
    not (not_a, a);
    not (not_b, b);
    Mux2To1 mux_a(a, not_a, ainvert, a1);
    Mux2To1 mux_b(b, not_b, binvert, b1);

    // AND and OR operations
    and (a_and_b, a1, b1);
    or  (a_or_b, a1, b1);

    // Perform addition
    xor (sum, a1, b1, carryin);
    and (c1, a1, b1);
    and (c2, a1 ^ b1, carryin);
    or  (carryout, c1, c2);

    // Select the final result based on the operation
    Mux4To1 mux1 (a_and_b, a_or_b, sum, less, op, result);

endmodule

// Author(s): Joey Conroy, Abbie Mathew, Matthew Quijano
// ALUmsb Module: This handles the most significant bit (MSB) of the ALU and includes the logic 
// for set-less-than. It is similar to the ALU1 module but has additional logic for the MSB.

module ALUmsb (a, b, ainvert, binvert, op, less, carryin, carryout, result, sum);

    // Inputs for the MSB operands, control signals, and carry-in
    input a, b, less, carryin, ainvert, binvert;
    input [1:0] op;

    // Outputs for carry-out, result, and sum
    output carryout, result, sum;

    // Internal wires for intermediate calculations
    wire a1, b1, a_and_b, a_or_b;
    wire not_a, not_b;

    // Invert inputs if required
    not (not_a, a);
    not (not_b, b);
    Mux2To1 mux_a(a, not_a, ainvert, a1);
    Mux2To1 mux_b(b, not_b, binvert, b1);

    // AND and OR operations
    and (a_and_b, a1, b1);
    or  (a_or_b, a1, b1);

    // Perform addition
    xor (sum, a1, b1, carryin);
    and (carryout, a1 & b1, (a1 ^ b1) & carryin);

    // Select the final result based on the operation
    Mux4To1 mux2 (a_and_b, a_or_b, sum, less, op, result);

endmodule

// 2-to-1 Multiplexer: Selects between two inputs based on the selection signal.

module Mux2To1(input a, input b, input sel, output y);

    wire sel_n, a_and_sel_n, b_and_sel;
    not (sel_n, sel);
    and (a_and_sel_n, a, sel_n);
    and (b_and_sel, b, sel);
    or  (y, a_and_sel_n, b_and_sel);

endmodule

// 4-to-1 Multiplexer: Selects between four inputs based on a 2-bit selection signal.

module Mux4To1(input in0, input in1, input in2, input in3, input [1:0] sel, output y);

    wire sel0_n, sel1_n, and0, and1, and2, and3;
    not (sel0_n, sel[0]);
    not (sel1_n, sel[1]);
    and (and0, in0, sel1_n, sel0_n);
    and (and1, in1, sel1_n, sel[0]);
    and (and2, in2, sel[1], sel0_n);
    and (and3, in3, sel[1], sel[0]);
    or (y, and0, and1, and2, and3);

endmodule
