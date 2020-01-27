`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: 4-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU, so that it supports a set of arithmetic and 
// logical operaitons. The 'ALUResult' will output the corresponding 
// result of the operation based on the 32-Bit inputs, 'A', and 'B'. 
// The 'Zero' flag is high when 'ALUResult' is '0'. 
// The 'ALUControl' signal determines the function of the ALU based 
// on the table below. 

// Op|'ALUControl' value  | Description | Notes
// ==========================
// ADDITION       | 0000 | ALUResult = A + B
// SUBRACTION     | 0001 | ALUResult = A - B
// MULTIPLICATION | 0010 | ALUResult = A * B        (see notes below)
// AND            | 0011 | ALUResult = A and B
// OR             | 0100 | ALUResult = A or B
// SET LESS THAN  | 0101 | ALUResult =(A < B)? 1:0  (see notes below)
// SET EQUAL      | 0110 | ALUResult =(A=B)  ? 1:0
// SET NOT EQUAL  | 0111 | ALUResult =(A!=B) ? 1:0
// LEFT SHIFT     | 1000 | ALUResult = A << B       (see notes below)
// RIGHT SHIFT    | 1001 | ALUResult = A >> B	    (see notes below)
// ROTATE RIGHT   | 1010 | ALUResult = A ROTR B     (see notes below)
// COUNT ONES     | 1011 | ALUResult = A CLO        (see notes below)
// COUNT ZEROS    | 1100 | ALUResult = A CLZ        (see notes below)
//
// NOTES:-
// MULTIPLICATION : 32-bit signed multiplication results with 64-bit output.
//                  ALUResult will be set to lower 32 bits of the product value. 
//
// SET LESS THAN : ALUResult is '32'h000000001' if A < B.
// 
// LEFT SHIFT: The contents of the 32-bit "A" input are shifted left, 
//             inserting zeros into the emptied bits by the amount 
//             specified in B.
// RIGHT SHIFT: The contents of the 32-bit "A" input are shifted right, 
//             inserting zeros into the emptied bits by the amount 
//             specified in B.
//
// ROTR: logical right-rotate of a word by a fixed number of bits. 
//       The contents of the 32-bit "A" input are rotated right. 
//       The bit-rotate amount is specified by "B".
//	     ((A >> B) | (A << (32-B))) 
//
// CLO: Count the number of leading ones in a word.
//      Bits 31..0 of the input "A" are scanned from most significant to 
//      least significant bit.  
// 
// CLZ: Count the number of leading zeros in a word.
//      Bits 31..0 of the input "A" are scanned from most significant to 
//      least significant bit.  
//
// 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, A, B, ALUResult, ALUResult64, Zero);

	input [5:0] ALUControl; // control bits for ALU operation
	(* mark_debug = "true" *) input [31:0] A; 
	(* mark_debug = "true" *) input [31:0] B;	    // inputs
    reg signed [31:0] Temp1;
    reg signed [31:0] Temp2;
    integer temp, i;
	(* mark_debug = "true" *) output reg [31:0] ALUResult;	// answer
	output reg signed [63:0] ALUResult64; 
	output wire Zero;	    // Zero=1 if ALUResult == 0
    
    always @(ALUControl, A, B) begin
        if(ALUControl == 6'd0) begin
            ALUResult <= A + B;
        end
        else if(ALUControl == 6'd1)begin
            ALUResult <= A - B;  
        end
        else if(ALUControl == 6'd2)begin
            ALUResult <= A * B;
        end
        else if(ALUControl == 6'd3)begin
            ALUResult <= A & B;
        end
        else if(ALUControl == 6'd4)begin
            ALUResult <= A | B;
        end
        else if(ALUControl == 6'd5)begin
            ALUResult <= A < B;
        end
        else if(ALUControl == 6'd6)begin
            ALUResult <= (A == B);
        end
        else if(ALUControl == 6'd7)begin
            ALUResult <= (A != B);
        end
        else if(ALUControl == 6'd8)begin
            ALUResult <= (A << B);
        end
        else if(ALUControl == 6'd9)begin 
            ALUResult <= (A >> B);
        end
        else if(ALUControl == 6'd10)begin
          ALUResult <=  ((A >> B) | (A << (32-B))); 
           // Temp2 <= (A >> B); 
           // ALUResult <= (Temp1 | Temp2); 
        end  
		else if(ALUControl == 6'd11)begin
			ALUResult = 0;
			i = 0;
			while (A[31-i] == 1 && i < 32)begin
			     ALUResult = ALUResult + 1;
			     i = i + 1;
			end
        end
		
		else if(ALUControl == 6'd12)begin
            ALUResult = 0;
            i = 0;
            while (A[31-i] == 0 && i < 32)begin
                 ALUResult = ALUResult + 1;
                 i = i + 1;
            end
        end
        else if(ALUControl == 6'd13) begin 
            ALUResult <= ~(A | B); 
        end        
        else if(ALUControl == 6'd14) begin   
            ALUResult <= A^B;
        end
        else if(ALUControl == 6'd15) begin   //Seh 
            ALUResult <= B; 
            end
        else if(ALUControl == 6'd16) begin   //movz
            if(B == 0) begin
            ALUResult <= A; 
            end
            else begin 
            ALUResult <= 0; 
            end
        end
        else if(ALUControl == 6'd17) begin 
            Temp1 = A[31]; 
            ALUResult <= A >> B; 
            ALUResult[31] <= Temp1; 
        end
        else if(ALUControl == 6'd18) begin   //movn
            if(B != 0) begin
            ALUResult <= A; 
            end
            else begin 
            ALUResult <= 0; 
            end
        end
        else if (ALUControl == 6'd19) begin 
         Temp1 <= (A); 
         Temp2 <= (B);
         ALUResult64 <= Temp1 * Temp2; 
          
          /* if(A[31] == 0 && B[31] == 0) begin
           //ALUResult64 <= A * B; 
           end
           else if(A[31] == 1 && B[31] == 1) begin
           ALUResult64 <= A[30:0] * B[30:0];
           end
           else if(A[31] == 1 && B[31] == 0) begin
           Temp2 <= (~A+1) * B[31:0];
           ALUResult64 <= {(~Temp2[63:32]+1),Temp2[31:0]};
           end
           else if(A[31] == 0 && B[31] == 1) begin
           Temp2 <= A[31:0] * {1'b0 ,B[30:0]};
           ALUResult64 <= {1'b0, Temp2[62:0]};
           end*/
        end
        else if (ALUControl == 6'd20) begin 
            ALUResult64 <= A * B;
        end
        else if (ALUControl == 6'd21) begin  //For lui 
            ALUResult <= {B[15:0], 16'd0}; 
        end 
        else begin
            ALUResult <= 32'd0;
        end
    end
    
assign Zero = (ALUResult == 32'b0)?1:0;
endmodule

