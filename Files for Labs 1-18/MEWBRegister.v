`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2018 10:22:45 PM
// Design Name: 
// Module Name: MEWBRegister
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


module MEWBRegister(MEMemtoReg, MERegWrite, MEResult, MEWriteReg, MEReadDM, METype, MEMemWrite, Clk, WBMemtoReg, WBRegWrite, WBResult, WBWriteReg, WBReadDM, WBType, WBMemWrite);
input Clk; 
input MEMemtoReg, MERegWrite, MEMemWrite; 
input [3:0] METype; 
input [4:0] MEWriteReg; 
input [31:0] MEResult, MEReadDM; 

output reg WBMemtoReg, WBRegWrite, WBMemWrite; 
(* mark_debug = "true" *) output reg [3:0] WBType; 
output reg [4:0] WBWriteReg;
output reg [31:0] WBResult, WBReadDM; 

reg OneBitSignals[2:0];         // All one bit Control Signals 
reg [3:0] TypeSignal;     //Type Signal
reg [4:0] FiveBitSignals[1:0];        //All Five bit Register Addresses 
reg [31:0] Output32Bits[2:0];  //All 32 bit output 

always@(posedge Clk)begin
   //One Bit Signals 
   OneBitSignals[0] = MEMemtoReg; 
   OneBitSignals[1] = MERegWrite;
   OneBitSignals[2] = MEMemWrite;
   //Type Signal
   TypeSignal = METype; 
   //Five Bit Signals 
   FiveBitSignals[0] = MEWriteReg;  
   //32 Bit input 
   Output32Bits[0] = MEResult; 
   Output32Bits[1] = MEReadDM; 
   end 

always@(negedge Clk)begin
    //One Bit Signals  
    WBMemtoReg =  OneBitSignals[0];  
    WBRegWrite =  OneBitSignals[1];  
    WBMemWrite =  OneBitSignals[2];  
    //Type Signal
    WBType = TypeSignal; 
    //Five Bit Signals
    WBWriteReg =  FiveBitSignals[0]; 
    //32 Bit input 
    WBResult   =  Output32Bits[0];  
    WBReadDM   =  Output32Bits[1]; 
    end
endmodule
