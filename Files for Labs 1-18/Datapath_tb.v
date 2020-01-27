`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2018 02:58:17 PM
// Design Name: 
// Module Name: Datapath_tb
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
// 50/50

module Datapath_tb();
reg Clk_tb, Rst_tb;
wire [31:0] Reg_writedata_tb, pcresult_tb, Hireg_tb, Loreg_tb; 


Datapath DP_tb(Clk_tb, Rst_tb, Reg_writedata_tb, pcresult_tb, Hireg_tb, Loreg_tb);

// Clock procedure
   always begin
      Clk_tb <= 0;
      #10;
      Clk_tb <= 1;
      #10;	
   end
   
   
   initial begin
        Rst_tb <= 1;
        #15 Rst_tb <= 0;
   end
   

endmodule
