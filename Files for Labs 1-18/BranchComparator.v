`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2018 09:12:52 PM
// Design Name: 
// Module Name: BranchComparator
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module BranchComparator(CompareOp, A, B, IDCompare, DebugA, Clk);

input Clk; 
input [2:0] CompareOp; 
output reg IDCompare; 
(* mark_debug = "true" *) input signed [31:0] A, B; 

 output [31:0] DebugA;     // Instruction at memory location Address
    
always @(A, B) begin
  if(CompareOp == 3'd0) begin    //Default no branch 
     IDCompare <= 0;  
  end 
  else if(CompareOp == 3'd1) begin   //Bgez
  if (A >= 0) 
     IDCompare <= 1; 
  else 
     IDCompare <= 0;
  end   
  else if(CompareOp == 3'd2) begin   //Beq
  if (A == B) 
     IDCompare <= 1; 
  else 
     IDCompare <= 0;
  end   
  else if(CompareOp == 3'd6) begin   //Bltz
  if (A <= 0) 
     IDCompare <= 1; 
  else 
     IDCompare <= 0;
  end   
  else if(CompareOp == 3'd3) begin   //Bne 
  if (A != B) 
     IDCompare <= 1; 
  else 
     IDCompare <= 0;
  end   
  else if(CompareOp == 3'd4) begin   //Bgtz
  if (A > 0) 
     IDCompare <= 1;
  else 
     IDCompare <= 0; 
  end   
  else if(CompareOp == 3'd5) begin   //Blez
  if (A <= 0) 
     IDCompare <= 1;  
  else 
     IDCompare <= 0; 
  end 
end 

assign DebugA = A;

endmodule
