`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2018 05:27:27 PM
// Design Name: 
// Module Name: IDEXRegister
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


module IDEXRegister(IDRegWrite, IDMemRead, IDMemWrite, IDMemtoReg, IDPCSrc, IDMyCtl1, IDRegDst, IDReadH, IDReadL, IDRegWriteH, IDRegWriteL, IDALUSrc, IDHiLoInput, IDOutputToWriteData, IDOp, IDALUOp, IDMemData, IDReadDMMux, IDRD1, IDRD2, IDSignOutput, IDInstruction, IDType, IFIDWrite, Clk, EXRegWrite, EXMemRead, EXMemWrite, EXMemtoReg, EXPCSrc, EXMyCtl1, EXRegDst, EXReadH, EXReadL, EXRegWriteH, EXRegWriteL, EXALUSrc, EXHiLoInput, EXOutputToWriteData, EXOp, EXALUOp, EXMemData, EXReadDMMux, EXRD1, EXRD2, EXSignOutput, EXInstruction, EXType); 
input Clk; 
input IDRegWrite, IDMemRead, IDMemWrite, IDMemtoReg, IDPCSrc, IDMyCtl1, IDRegDst, IDReadH, IDReadL, IDRegWriteH, IDRegWriteL, IFIDWrite;
input [1:0] IDALUSrc, IDHiLoInput, IDOutputToWriteData, IDOp, IDMemData, IDReadDMMux;
input [3:0] IDType; 
input [5:0] IDALUOp; 
input [31:0] IDRD1, IDRD2, IDSignOutput, IDInstruction; 

output reg EXRegWrite, EXMemRead, EXMemWrite, EXMemtoReg, EXPCSrc, EXMyCtl1, EXRegDst, EXReadH, EXReadL, EXRegWriteH, EXRegWriteL;
output reg [1:0] EXALUSrc, EXHiLoInput, EXOutputToWriteData, EXOp, EXMemData, EXReadDMMux;
(* mark_debug = "true" *) output reg [3:0] EXType; 
output reg [5:0] EXALUOp; 
output reg [31:0] EXRD1, EXRD2, EXSignOutput, EXInstruction; 
//output reg [31:0]  
reg OneBitSignals[10:0];   //One Bit Control signals 
reg [1:0] TwoBitSignals[6:0];   //Two Bit Control signals 
reg [3:0] TypeSignal;   //Type Signal 
reg [5:0] ALUOpSignal;    //ALUOp Control signal 
reg [31:0] Output32Bits[3:0];  //All 32 bit output 

 always@(posedge Clk)begin
   //One Bit Signals 
      if(IFIDWrite == 1) begin 
       OneBitSignals[0] = IDRegWrite; 
       OneBitSignals[1] = IDMemRead; 
       OneBitSignals[2] = IDMemWrite; 
       OneBitSignals[3] = IDMemtoReg; 
       OneBitSignals[4] = IDPCSrc; 
       OneBitSignals[5] = IDMyCtl1; 
       OneBitSignals[6] = IDRegDst; 
       OneBitSignals[7] = IDReadH; 
       OneBitSignals[8] = IDReadL; 
       OneBitSignals[9] = IDRegWriteH; 
       OneBitSignals[10] = IDRegWriteL; 
    //Two Bit Control Signals 
       TwoBitSignals[0] = IDALUSrc;
       TwoBitSignals[1] = IDHiLoInput;
       TwoBitSignals[2] = IDOutputToWriteData;
       TwoBitSignals[3] = IDOp;
       TwoBitSignals[4] = IDMemData;
       TwoBitSignals[5] = IDReadDMMux;
     //Type Signal
       TypeSignal = IDType; 
     //ALUOp Control Signal 
       ALUOpSignal = IDALUOp; 
      //Register Outputs 
       Output32Bits[0] = IDRD1; 
       Output32Bits[1] = IDRD2; 
       //Sign Extension Output 
       Output32Bits[2] = IDSignOutput; 
       //Instruction Output 
       Output32Bits[3] = IDInstruction; 
       end 
       else begin 
       OneBitSignals[0] = 0; 
       OneBitSignals[1] = 0; 
       OneBitSignals[2] = 0; 
       OneBitSignals[3] = 0; 
       OneBitSignals[4] = 0; 
       OneBitSignals[5] = 0; 
       OneBitSignals[6] = 0; 
       OneBitSignals[7] = 0; 
       OneBitSignals[8] = 0; 
       OneBitSignals[9] = 0; 
       OneBitSignals[10] = 0; 
    //Two Bit Control Signals 
       TwoBitSignals[0] = 2'd0;
       TwoBitSignals[1] = 2'd0;
       TwoBitSignals[2] = 2'd0;
       TwoBitSignals[3] = 2'd0;
       TwoBitSignals[4] = 2'd0;
       TwoBitSignals[5] = 2'd0;
     //Type Signal
       TypeSignal = 4'd0; 
     //ALUOp Control Signal 
       ALUOpSignal = 6'd0; 
      //Register Outputs 
       Output32Bits[0] = 32'd0; 
       Output32Bits[1] = 32'd0; 
       //Sign Extension Output 
       Output32Bits[2] = 32'd0; 
       //Instruction Output 
       Output32Bits[3] = 32'd0; 
       end
    end
    
    always@(negedge Clk)begin
   //One Bit Signals 
        EXRegWrite =  OneBitSignals[0];
        EXMemRead  =  OneBitSignals[1];
        EXMemWrite =  OneBitSignals[2];
        EXMemtoReg =  OneBitSignals[3];
        EXPCSrc =     OneBitSignals[4];
        EXMyCtl1 =    OneBitSignals[5]; 
        EXRegDst =    OneBitSignals[6];
        EXReadH =     OneBitSignals[7];
        EXReadL =     OneBitSignals[8];
        EXRegWriteH = OneBitSignals[9]; 
        EXRegWriteL = OneBitSignals[10];
     //Two Bit Control Signals 
        EXALUSrc =    TwoBitSignals[0];
        EXHiLoInput = TwoBitSignals[1];
        EXOutputToWriteData = TwoBitSignals[2];
        EXOp       =  TwoBitSignals[3];
        EXMemData   = TwoBitSignals[4]; 
        EXReadDMMux = TwoBitSignals[5]; 
      //Type Signal
        EXType = TypeSignal; 
      //ALUOp Control Signal 
        EXALUOp = ALUOpSignal; 
       //Register Outputs 
        EXRD1 = Output32Bits[0]; 
        EXRD2 = Output32Bits[1] ; 
        //Sign Extension Output 
        EXSignOutput = Output32Bits[2]; 
        //Instruction Output 
        EXInstruction = Output32Bits[3]; 
    end

endmodule

