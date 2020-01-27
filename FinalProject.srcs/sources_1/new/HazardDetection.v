`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2018 07:53:39 PM
// Design Name: 
// Module Name: HazardDetection
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


module HazardDetection(Clk, R1, R2, WBWriteReg, MEWriteReg, EXWriteReg, EXMemRead, MEMemRead, IDType, IDCompare, IDPCSrc, MERegWrite, EXRegWrite, WBRegWrite, IFIDWrite, PCWrite, RD1Haz, RD2Haz, flush);
input [4:0] R1, R2, WBWriteReg, MEWriteReg, EXWriteReg; 
input [3:0] IDType; 
input EXMemRead, Clk, IDCompare, IDPCSrc, EXRegWrite, MERegWrite, WBRegWrite, MEMemRead; 
(* mark_debug = "true" *) output reg IFIDWrite, PCWrite, flush; 
output reg [1:0] RD1Haz, RD2Haz; 

always@ (R1, R2, IDType) begin  
   RD1Haz <= 0; 
   RD2Haz <= 0; 
   flush <= 0; 
 
   if((R1 == WBWriteReg) && (WBRegWrite == 1)) begin   //When write back register equals IDRS or IDRT 
   RD1Haz <= 1; 
   end
   if((R2 == WBWriteReg) && (WBRegWrite == 1)) begin 
   RD2Haz <= 1; 
   end 
   
   //forwarding from wb stage for jump and branches 
   if((R1 == MEWriteReg) && (MERegWrite == 1) && ((IDType == 7) || (IDType == 3) || (IDType == 8)) && (MEMemRead == 0)) begin 
   RD1Haz <= 2; 
   end 
   
   if((R2 == MEWriteReg) && (MERegWrite == 1) && ((IDType == 7) || (IDType == 3) || (IDType == 8)) && (MEMemRead == 0)) begin 
   RD2Haz <= 2; 
   end 
   
   
   if(IDType == 10 || IDType == 8) begin  // flush after any jump type
   flush <= 1;
   end 
   
   if((IDPCSrc == 1) && (IDCompare == 1)) begin //flush whenever a branch is taken
   flush <= 1; 
   end 
   
   
   end
   
always@(EXWriteReg, EXMemRead) begin 
    IFIDWrite <= 1; 
    PCWrite <= 1;  
    
   if((R1 == EXWriteReg) && (EXMemRead == 1)) begin   //Stalls for any lw dependency in the ME stage
   IFIDWrite <= 0; 
   PCWrite <= 0; 
   end 
   if((R2 == EXWriteReg) && (EXMemRead == 1)) begin 
   IFIDWrite <= 0; 
   PCWrite <= 0; 
end    

//Stall for forwarding to any branch 
   if((EXRegWrite == 1) && ((IDType == 7) || (IDType == 3) || (IDType == 8)) && (R1 == EXWriteReg))begin 
   IFIDWrite <= 0; 
   PCWrite <= 0; 
   end 
   
   if((EXRegWrite == 1) && ((IDType == 7) || (IDType == 3) || (IDType == 8)) && (R2 == EXWriteReg))begin 
   IFIDWrite <= 0; 
   PCWrite <= 0; 
   end 
   
   if((MERegWrite == 1) && ((IDType == 7) || (IDType == 3) || (IDType == 8)) && (R1 == MEWriteReg) && (MEMemRead == 1))begin 
   IFIDWrite <= 0; 
   PCWrite <= 0; 
   end 
   
   if((MERegWrite == 1) && ((IDType == 7) || (IDType == 3) || (IDType == 8)) && (R2 == MEWriteReg) && (MEMemRead == 1))begin 
   IFIDWrite <= 0; 
   PCWrite <= 0; 
   end 
   
   
   
   
  
  /* 
   if((MERegWrite == 1) && ((IDType == 7) || (IDType == 3)) && (R1 == MEWriteReg))begin 
   IFIDWrite <= 0; 
   PCWrite <= 0; 
   end */
end 

endmodule
