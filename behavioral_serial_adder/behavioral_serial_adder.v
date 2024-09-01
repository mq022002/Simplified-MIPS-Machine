// 4-bit adder using shift registers and 1-bit serial adder
// Behavioural model
module adder(x,y,S,Load,Clock);
   input [3:0] x,y;
   input Load,Clock;
   output [3:0] S;
   wire [3:0] PO;
   shiftreg r1(SI,x,SO1,S,Clock,Load),
            r2(1'b0,y,SO2,PO,Clock,Load);
   serial_adder sa(SO1,SO2,SI,Clock,Load);
// Uncomment the following line to trace execution 
// always @(negedge Clock) $monitor("%b %b",S,PO);
endmodule

// Behavioral shift register with parallel load
// Load=1 -> load; 
// Load=0 -> shift
module shiftreg (SI,PI,SO,PO,Clock,Load);
   input Load,Clock;
   input SI; // Serial input
   input [3:0] PI; // Parallel input
   output SO; // Serial output
   output [3:0] PO; // Parallel output
   reg [3:0] R; // Register
   assign SO = R[0];
   assign PO = R;
   always @(negedge Clock) 
     if (Load) R = PI; // Parallel load
     else begin // Shift right
       R = R>>1;
       R[3] = SI;
     end
endmodule

// Behavioral model of 1-bit serial adder
module serial_adder(x,y,S,Clock,Clear);
   input x,y,Clock,Clear;
   output S;
   reg D; // simulating D flip-flop
   wire C1;
   assign {C,S} = x+y+D;      // dataflow binary adder
   assign C1 = Clear ? 0 : C; // behavioral 2x1 multiplexer
   always @(negedge Clock)    // load D on negative edge
     D = C1;
endmodule

module test;
   reg signed [3:0] A,B;
   reg Load, Clock;
   wire signed [3:0] S;
   adder add (A,B,S,Load,Clock);
   always #1 Clock = ~Clock; // Generate a clock edge at every time unit 
   initial begin
     A=5; B=2;
     Load=1; // Load inputs and clear the flip-flop
     Clock=1; // Start Clock
  #2 Load=0; // Start serial adder (enable shifing) 
  #8 $display("%d +%d =%d",A,B,S); // Show sum after 4 negaive edges
     $finish; // Stop clock pulses
   end
endmodule