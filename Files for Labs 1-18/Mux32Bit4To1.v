`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu
// 
// Module - Mux32Bit2To1.v
// Description - Use the sel input signal to choose which 32-bit inputs should be at the output
//              - sel = 1, out = inA
//              - sel = 0, out = inB
////////////////////////////////////////////////////////////////////////////////

module Mux32Bit4To1(out, inA, inB, inC, inD, sel);

    output reg [31:0] out;
    
    input [31:0] inA;
    input [31:0] inB;
    input [31:0] inC;
    input [31:0] inD;
   (* mark_debug = "true" *)  input [1:0] sel;
    always @(inA, inB, inC, inD, sel) begin
        if(sel == 2'd0)begin
            out = inA;
        end    
        else if (sel == 2'd1) begin
            out = inB;
        end
        else if (sel == 2'd2) begin 
            out = inC; 
        end 
        else if (sel == 2'd3) begin 
            out = inD; 
        end 
    end
endmodule