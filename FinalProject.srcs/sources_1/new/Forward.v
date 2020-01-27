`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/31/2018 04:35:37 PM
// Design Name: 
// Module Name: Forward
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


module Forward(EXRS, EXRT, MEWriteReg, WBWriteReg, EXType, METype, EXRegDst, EXMemFor, EXMemRead, WBMemWrite, MERegWrite, WBRegWrite, EXForAMux, EXForBMux);
input [4:0] EXRS, EXRT, MEWriteReg, WBWriteReg; 
input [3:0] EXType, METype; 
input EXRegDst, WBMemWrite, EXMemRead, MERegWrite, WBRegWrite; 
(* mark_debug = "true" *) output reg [1:0] EXForAMux, EXForBMux, EXMemFor; 

always@(EXRS, EXRT, MEWriteReg, WBWriteReg) begin 
    EXForAMux <= 0; 
    EXForBMux <= 0;
    EXMemFor <= 0; 
    
     
    /*
    if((EXType == 0) && (METype == 6)) begin 
    if(EXRS == MEWriteReg) begin 
    EXForAMux <= 3; 
    end
    else if(EXRS == WBWriteReg) begin 
    EXForAMux <= 2'd2;
    end 
    if(EXRT == MEWriteReg) begin 
    EXForBMux <= 3; 
    end 
    else if (EXRT == MEWriteReg) begin 
    EXForBMux <= 2'd2;
    end
    end 
    
    else begin */
    
    //forward to any R-type 
    if((EXType == 0) || (EXType == 5)) begin 
    if((EXRS == WBWriteReg) && (WBRegWrite == 1)) begin 
    EXForAMux <= 2'd2;
    end 
   
    if((EXRS == MEWriteReg) && (MERegWrite == 1)) begin 
    EXForAMux <= 1; 
    end
    
    if((EXRT == WBWriteReg)   && (WBRegWrite == 1)) begin 
    EXForBMux <= 2'd2;
    end
    
    if((EXRT == MEWriteReg) && (MERegWrite == 1)) begin 
    EXForBMux <= 1; 
    end
    end
    
    //forward to any I-type or mthi
    if((EXType == 2) || (EXType == 8)) begin 
    if((EXRS == WBWriteReg) && (WBRegWrite == 1)) begin 
    EXForAMux <= 2'd2;
    end 
   
    if((EXRS == MEWriteReg) && (MERegWrite == 1)) begin 
    EXForAMux <= 1; 
    end
    end 
    
    //forward to any shift-type
    if(EXType == 4) begin 
    if((EXRT == WBWriteReg) && (WBRegWrite == 1)) begin 
    EXForAMux <= 2'd2;
    end 
   
    if((EXRT == MEWriteReg) && (MERegWrite == 1)) begin 
    EXForAMux <= 1; 
    end
    end
    
    //forward to any sllv and srlv
    if(EXType == 1) begin 
    if((EXRT == WBWriteReg) && (WBRegWrite == 1)) begin 
    EXForAMux <= 2'd2;
    end 
   
    if((EXRT == MEWriteReg) && (MERegWrite == 1)) begin 
    EXForAMux <= 1; 
    end
    if((EXRS == WBWriteReg) && (WBRegWrite == 1)) begin 
    EXForBMux <= 2'd2;
    end 
   
    if((EXRS == MEWriteReg) && (MERegWrite == 1)) begin 
    EXForBMux <= 1; 
    end
    end
    
    //forwarding case for lw to sw
    if (EXType == 6) begin 
    if ((EXRT == WBWriteReg) && (EXMemRead == 0) && (WBRegWrite == 1)) begin   //Only for sw
    EXMemFor <= 1; 
    end 
    if ((EXRT == MEWriteReg) && (EXMemRead == 0) && (MERegWrite == 1)) begin  //Only for sw
    EXMemFor <= 2; 
    end 
    if ((EXRS == MEWriteReg) && (MERegWrite == 1)) begin 
    EXForAMux <= 1; 
    end 
    if ((EXRS == WBWriteReg) && (WBRegWrite == 1)) begin
    EXForAMux <= 2; 
    end 
    end 
    //Control input B
    /*
    if(EXRegDst == 1 ) begin 
    if(EXRT == WBWriteReg) begin 
    EXForBMux <= 2'd2;
    end
    
    if(EXRT == MEWriteReg) begin 
    EXForBMux <= 1; 
    end
    end  */ 
    
end

endmodule
