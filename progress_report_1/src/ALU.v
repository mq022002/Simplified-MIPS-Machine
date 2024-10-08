// Author(s): Abbie Mathew
// ALU Module: This part of the CPU does math and logic tasks on two 16-bit numbers (A and B). 
// The task is chosen based on a control signal (ALUControl). It can do things like adding, 
// subtracting, AND, OR, and comparing which number is smaller. The result is stored in ALUOut. 
// It also checks if the result is zero.

module ALU (
    // 4-bit signal to decide which operation to perform
    input [3:0] ALUControl,      

    // 16-bit numbers to use in the operation
    input [15:0] A, B,           

    // Result of the operation
    output reg signed [15:0] ALUOut,  

    // 1 if the result is zero, otherwise 0
    output Zero                  
);

    // Wires are like connectors that hold the results of different operations
    wire [15:0] AndResult, OrResult, Sum, NorResult, NandResult, B_in;  
    wire CarryOut, Binvert, Less;

    // Binvert is turned on for subtraction or comparison operations
    assign Binvert = (ALUControl == 4'b0110) || (ALUControl == 4'b0111);

    // B_in is either B or the opposite of B, depending on the operation
    assign B_in = Binvert ? ~B : B;

    // Generate the results for AND, OR, NOR, and NAND for each bit in A and B
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin
            // AND operation
            and (AndResult[i], A[i], B[i]);   

            // OR operation
            or (OrResult[i], A[i], B[i]);     

            // NOR operation
            nor (NorResult[i], A[i], B[i]);   

            // NAND operation
            nand (NandResult[i], A[i], B[i]); 
        end
    endgenerate

    // Logic for adding and subtracting
    wire [15:0] Carry;

    // Add the first bits, including any inversion
    assign Sum[0] = A[0] ^ B_in[0] ^ Binvert;  

    // Handle carry from addition
    assign Carry[0] = (A[0] & B_in[0]) | (A[0] & Binvert) | (B_in[0] & Binvert);  

    generate
        for (i = 1; i < 16; i = i + 1) begin
            // Add the rest of the bits, carrying over if needed
            assign Sum[i] = A[i] ^ B_in[i] ^ Carry[i-1];  

            // Calculate carry for the next bit
            assign Carry[i] = (A[i] & B_in[i]) | (A[i] & Carry[i-1]) | (B_in[i] & Carry[i-1]);  
        end
    endgenerate

    // Less is set if A is smaller than B (for comparing)
    assign Less = (Sum[15] == 1) ? 1 : 0;

    // Choose what to do based on the control signal
    always @(*) begin
        case (ALUControl)
            // AND operation
            4'b0000: ALUOut = AndResult;        

            // OR operation
            4'b0001: ALUOut = OrResult;         

            // Addition
            4'b0010: ALUOut = Sum;              

            // Subtraction
            4'b0110: ALUOut = Sum;              

            // Compare: Is A smaller than B?
            4'b0111: ALUOut = (Less) ? 16'b1 : 16'b0;  

            // NOR operation
            4'b1100: ALUOut = NorResult;        

            // NAND operation
            4'b1101: ALUOut = NandResult;       

            // If the control signal is unknown, output 0
            default: ALUOut = 16'b0;            
        endcase
    end

    // Set Zero to 1 if the result is zero, otherwise 0
    assign Zero = (ALUOut == 16'b0);

endmodule
