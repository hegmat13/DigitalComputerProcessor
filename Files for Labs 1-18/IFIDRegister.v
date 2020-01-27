`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2018 04:37:32 PM
// Design Name: 
// Module Name: IFIDRegister
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


module IFIDRegister(flush, IFIDWrite, IFPCAddResult, IFInstruction, IDPCAddResult, IDInstruction, Clk);
input Clk, IFIDWrite, flush;
input [31:0] IFPCAddResult, IFInstruction; 
 (* mark_debug = "true" *) output reg [31:0] IDPCAddResult, IDInstruction; 
reg [31:0] regFile[1:0]; 

 always@(posedge Clk)begin
       if((IFIDWrite == 1) && (flush == 0)) begin   
       regFile[0] = IFPCAddResult;
       regFile[1] = IFInstruction; 
       end 
       else if(IFIDWrite == 0) begin 
       end 
       else if (flush == 1) begin 
       regFile[0] = 0; 
       regFile[1] = 0; 
       end 
    end
    
    always@(negedge Clk)begin
        if(IFIDWrite == 1) begin 
        IDPCAddResult = regFile[0];
        IDInstruction= regFile[1];
        end 
    end

endmodule
