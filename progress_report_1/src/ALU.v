module ALU1 (a, b, ainvert, binvert, op, less, carryin, carryout, result);
    input a, b, less, carryin, ainvert, binvert;
    input [1:0] op;
    output carryout, result;
    wire a1, b1, a_and_b, a_or_b, sum, c1, c2;
    wire not_a, not_b;
    not (not_a, a);
    not (not_b, b);
    Mux2To1 mux_a(.a(a), .b(not_a), .sel(ainvert), .y(a1));
    Mux2To1 mux_b(.a(b), .b(not_b), .sel(binvert), .y(b1));
    and (a_and_b, a1, b1);
    or  (a_or_b, a1, b1);
    xor (sum, a1, b1, carryin);
    and (c1, a1, b1);
    and (c2, a1 ^ b1, carryin);
    or  (carryout, c1, c2);
    Mux4To1 mux1 (.in0(a_and_b), .in1(a_or_b), .in2(sum), .in3(less), .sel(op), .y(result));
endmodule

// Author(s): Joey Conroy, Abbie Mathew, Matthew Quijano
module ALUmsb (a, b, ainvert, binvert, op, less, carryin, carryout, result, sum);
    input a, b, less, carryin, ainvert, binvert;
    input [1:0] op;
    output carryout, result, sum;
    wire a1, b1, a_and_b, a_or_b;
    wire not_a, not_b;
    not (not_a, a);
    not (not_b, b);
    Mux2To1 mux_a(.a(a), .b(not_a), .sel(ainvert), .y(a1));
    Mux2To1 mux_b(.a(b), .b(not_b), .sel(binvert), .y(b1));
    and (a_and_b, a1, b1);
    or  (a_or_b, a1, b1);
    xor (sum, a1, b1, carryin);
    and (carryout, a1 & b1, (a1 ^ b1) & carryin);
    Mux4To1 mux2 (.in0(a_and_b), .in1(a_or_b), .in2(sum), .in3(less), .sel(op), .y(result));
endmodule

// Author(s): Joey Conroy, Abbie Mathew, Matthew Quijano
module ALU (op, a, b, result, zero);
    input [3:0] op;
    input [15:0] a, b;
    output [15:0] result;
    output zero;
    wire [15:0] carry;
    wire set;
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
    ALUmsb alu15 (a[15], b[15], op[3], op[2], op[1:0], 1'b0, carry[14], carry[15], result[15], set);
    nor nor1(zero, result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], 
             result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]);
endmodule