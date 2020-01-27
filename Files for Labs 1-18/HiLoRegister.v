`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2018 03:31:50 PM
// Design Name: 
// Module Name: HiLoRegister
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


module HiLoRegister(WriteData, ReadH, ReadL, RegWriteH, RegWriteL, ReadDataH, ReadDataL, Op, Clk, WriteData1, debugLo, debugHi);

input ReadH, ReadL, RegWriteH, RegWriteL, Clk;
input [63:0] WriteData, WriteData1; 
input [1:0] Op; 
output reg [31:0] ReadDataH, ReadDataL; 
(*mark_debug = "true" *) reg [31:0] regFile[0:1];
output [31:0] debugLo, debugHi;


  always@(posedge Clk)begin
   if(Op == 0) begin 
        if (RegWriteH == 1) begin
           regFile[1] = WriteData[63:32];
        end
        if (RegWriteL == 1) begin 
           regFile[0] = WriteData[31:0]; 
       end
       end
   else if(Op == 1) begin 
       {regFile[1], regFile[0]} = (WriteData + {regFile[1], regFile[0]});
       end 
   else if(Op == 2) begin  
       {regFile[1], regFile[0]} = ({regFile[1], regFile[0]} - WriteData);
      end      
      end

    
  always@(negedge Clk)begin
        ReadDataH = regFile[1];
        ReadDataL = regFile[0]; 
    end


   assign debugLo = regFile[0];
   assign debugHi = regFile[1];
endmodule
