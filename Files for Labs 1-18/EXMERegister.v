`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2018 09:44:33 PM
// Design Name: 
// Module Name: EXMERegister
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


module EXMERegister(EXPCSrc, EXMemtoReg, EXMemRead, EXMemWrite, EXZero, EXRegWrite, EXResult, EXMemWriteData, EXWriteReg, EXReadDMMux, EXType, Clk, MEPCSrc, MEMemtoReg, MEMemRead, MEMemWrite, MEZero, MERegWrite, MEResult, MERD2, MEWriteReg, MEReadDMMux, METype);
input Clk; 
input EXPCSrc, EXMemtoReg, EXMemRead, EXMemWrite, EXZero, EXRegWrite; 
input [31:0] EXResult, EXMemWriteData; 
input [4:0] EXWriteReg; 
input [3:0] EXType; 
input [1:0] EXReadDMMux; 

output reg MEPCSrc, MEMemtoReg, MEMemRead, MEMemWrite, MEZero, MERegWrite; 
output reg [31:0] MEResult, MERD2; 
output reg [4:0] MEWriteReg; 
(* mark_debug = "true" *) output reg [3:0] METype; 
output reg [1:0] MEReadDMMux;

reg OneBitSignals [5:0];     //All one bit Control Signals
reg [1:0] TwoBitSignals [1:0]; //two bit control signals
reg [3:0] TypeSignal; 
reg [4:0] FiveBitSignals [1:0]; //five bit control signals 
reg [31:0] Output32Bits[3:0];  //All 32 bit output 

 always@(posedge Clk)begin
   //One Bit Signals 
   OneBitSignals[0] = EXPCSrc;
   OneBitSignals[1] = EXMemtoReg;
   OneBitSignals[2] = EXMemRead;
   OneBitSignals[3] = EXMemWrite;
   OneBitSignals[4] = EXZero;
   OneBitSignals[5] = EXRegWrite;
   //Two Bit Signals 
   TwoBitSignals[0] = EXReadDMMux; 
   //Type Signal
   TypeSignal = EXType; 
   //Five Bit Signals
   FiveBitSignals[0] = EXWriteReg; 
   //32 Bit Inputs 
   Output32Bits[0] =  EXResult;
   Output32Bits[1] =  EXMemWriteData; 
   end  
   
  always@(negedge Clk)begin
  //One Bit Signals  
   MEPCSrc    = OneBitSignals[0]; 
   MEMemtoReg = OneBitSignals[1]; 
   MEMemRead  = OneBitSignals[2]; 
   MEMemWrite = OneBitSignals[3]; 
   MEZero     = OneBitSignals[4]; 
   MERegWrite = OneBitSignals[5]; 
   //Two Bit Signals 
   MEReadDMMux =   TwoBitSignals[0]; 
   //Type Signal 
   METype = TypeSignal; 
   //Five Bit Signals
   MEWriteReg = FiveBitSignals[0];
   //32 Bit Signals 
   MEResult      = Output32Bits[0]; 
   MERD2         = Output32Bits[1]; 
  end 
endmodule
