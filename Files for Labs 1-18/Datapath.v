`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2018 03:32:11 PM
// Design Name: 
// Module Name: Datapath
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

//Percent Effort: 50/50
//5 stage pipeline 
//Branch decision and resolution done in DE stage d



module Datapath(Clk, Rst, Reg_writedata, pcresult, Hireg, Loreg);
    //single cycle signals 
    input Clk, Rst;
    output [31:0] Reg_writedata, pcresult, Hireg, Loreg; 
   // output [31:0] WriteDataOutput;
    
//IF Stage: 
         //Inputs to the IFID Register 
    wire [31:0] IFPCAddResult, IFInstruction, InstructionDebug, BranchMuxResult, LinkData;   
    wire [6:0] out7; 
    wire [7:0] en_out;
    wire [3:0] Type;  
    wire PCWrite, ClkOut; 
    wire [1:0] Jump, RD1Haz, RD2Haz;
    wire link, flush;  
//ID Stage:
       //Outputs from IFID Register 
    wire [31:0] IDPCAddResult, IDInstruction; 
       //Inputs to the IDEX Register 
    wire [31:0] IDSignOutput,IDSignOutputToMux, IDRD1, IDRD2, IDRD1Out, IDRD2Out, BranchPCResult; 
        //All Control Signals  
    wire IDRegWrite, IDMemRead, IDMemWrite, IDMemtoReg, IDPCSrc, IDMyCt, IDRTtoRS, IDReadH, IDReadL, IDRegWriteH, IDRegWriteL, IDRegDst, IDAndI, IDCompare, IFIDWrite;
    wire [1:0] IDALUSrc, IDHiLoInput, IDOutputToWriteData, IDOp, IDMemData, IDReadDMMux;
    wire [2:0] CompareOp;
    wire [3:0] IDType; 
    wire [5:0] IDALUOp;
    
//EX Stage: 
         //Outputs from IDEX Register 
    wire [31:0] EXPCAddResult, EXInstruction, EXMemWriteData, EXMemForWriteData; 
    wire [31:0] EXSignOutput, EXRD1, EXRD2, EXResult, EXMyCtOutput; 
        //All Control Signals 
    wire EXRegWrite, EXMemRead, EXMemWrite, EXMemtoReg, EXPCSrc, EXMyCt, EXReadH, EXReadL, EXRegWriteH, EXRegWriteL, EXRegDst, EXZero;
    wire [1:0] EXALUSrc, EXHiLoInput, EXOutputToWriteData, EXOp, EXMemData, EXReadDMMux, EXForAMux, EXForBMux, EXMemFor;
    wire [3:0] EXType; 
    wire [5:0] EXALUOp;
// ME Stage: 
          //Outputs from EX/ME Register 
    wire  MEPCSrc, MEMemtoReg, MEMemRead, MEMemWrite, MEZero, MERegWrite;
    wire [1:0] MEReadDMMux;
    wire [3:0] METype; 
    wire [31:0] MEResult, MERD2, MEWriteReg, MEReadDM, MESignOutputDM, MEEightSignOutputDM, MEReadDMOut, mem0, mem1, mem2, mem3, mem4, mem5; 
// WB Stage: 
        //Control Signals 
    wire WBMemtoReg, WBRegWrite, WBMemWrite; 
        //Output from ME/WB Register 
    wire [31:0] WBResult, WBReadDM;  
    wire [3:0] WBType;  
    wire [4:0] WBWriteReg; 
    
    
    wire [31:0] Address, PCResult, FromZeroSignal; //PCAddResult;
    wire [31:0] EightSignOutput, RD2SignOutput; //Instruction;
    wire [4:0] R1, R2, EXWriteReg;

    wire [31:0] ALUInput2, B, A, ALUR, ALUResultUP, ReadDataH, ReadDataL, ExResult, debugLo, debugHi, DebugA;
    wire [63:0] ALUResult64, ALUResult641, ALUResult64UP, HiLoDataInput, Special64Output, WriteData1;
    wire Zero, Zero1, Unused;
    wire [31:0] OutputWire, s0, s1, s2, s3, s4, s5, s6, s7, t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, v0, v1, a0, a1, a2;
    //Pipelined Signlas   
    
        
    //PCResult wire out
    ClkDiv ClkDiv1(Clk, Rst, ClkOut);
    
    TwoDigitDisplay TwoDigitDisplay1(ClkOut, t8[15:0], t9[15:0], out7, en_out);
      
    ProgramCounter PC(Address, PCResult, PCWrite, Rst, Clk);
    //IFinstruction wire out
    InstructionMemory IM(PCResult, IFInstruction, InstructionDebug);
    //IFID output 
    IFIDRegister IFIDReg(flush, IFIDWrite, IFPCAddResult, IFInstruction, IDPCAddResult, IDInstruction, Clk); 
    //BranchPCResult wire out 
    ALU32Bit BranchALU(0, IDPCAddResult, (IDSignOutputToMux << 2), BranchPCResult, ALUResult641, Zero1);
    //R1 wire out
    Mux32Bit2To1 rsORrt(R1, IDInstruction[25:21], IDInstruction[20:16] , IDRTtoRS);
    //R2 wire out
    Mux32Bit2To1 rtORrs(R2, IDInstruction[20:16], IDInstruction[25:21], IDRTtoRS);
    //WriteReg wire out
    Mux32Bit2To1 rtORrd(EXWriteReg, EXInstruction[20:16], EXInstruction[15:11], EXRegDst);
    //out wire out 
    //Mux32Bit2To1 Halfword(IDSignInput, Instruction[15:0], RD2[15:0], HalfWord);   
    //in wire out 
    SignExtension SignExtendI(IDInstruction[15:0], IDSignOutputToMux);
    //IDSignOutput wire out 
    Mux32Bit2To1 AndiMux(IDSignOutput, IDSignOutputToMux, {16'd0, IDInstruction[15:0]}, IDAndI); 
    //EightSignOutput wire out 
    SignExtension8bit SignExtend8bit1(EXRD2[7:0], EightSignOutput); 
    //RD2SignOutput wire out 
    SignExtension SignExtendRD(EXRD2[15:0], RD2SignOutput);
    //EXMemWriteData wire out
   
    //RD2_out wire out
    Mux32Bit4To1 SignExtendOrRD2(ALUInput2, EXRD2, EXSignOutput, RD2SignOutput, EightSignOutput, EXALUSrc);
    //EXMyCtOutput wire out
    Mux32Bit2To1 MyCtlMux(EXMyCtOutput, ALUInput2, {27'b0, EXInstruction[10:6]}, EXMyCt);
    //A wire out
    Mux32Bit4To1 MuxToAOnALU(A, EXRD1, MEResult, OutputWire, MEReadDMOut, EXForAMux);
    //B wire out  
    Mux32Bit4To1 MuxToBOnALU(B, EXMyCtOutput, MEResult, OutputWire, MEReadDMOut, EXForBMux);    
    //ALUR and ALUResult64 wires out
    ALU32Bit MainALU(EXALUOp, A, B, ALUR, ALUResult64, Zero);
    //HiLoDataInput wire out
    Mux64Bit4To1 MuxtoHiLoRegister(HiLoDataInput, ALUResult64, {A, 32'd0}, {32'd0, A}, 0, EXHiLoInput); 
    //ReadDataH and ReadDataL wires out
    HiLoRegister HiLoRegister1(HiLoDataInput, EXReadH, EXReadL, EXRegWriteH, EXRegWriteL, ReadDataH, ReadDataL, EXOp, Clk, WriteData1, debugLo, debugHi);
    //Special64Output wires out
   // Special64BitAddAndSub Special64BitAddAndSub1({ReadDataH, ReadDataL}, ALUResult64, Special64Output, Op, ReadH, ReadL, RegWriteH, RegWriteL); 
    //ExResult wire out
    Mux32Bit4To1 MuxForExecutionResult(EXResult, ALUR, ReadDataH, ReadDataL, 0, EXOutputToWriteData);
    //ReadDM wire out
    //EX/ME Register 
    EXMERegister EXMERegister1(EXPCSrc, EXMemtoReg, EXMemRead, EXMemWrite, EXZero, EXRegWrite, EXResult, EXMemForWriteData, EXWriteReg, EXReadDMMux, EXType, Clk, MEPCSrc, MEMemtoReg, MEMemRead, MEMemWrite, MEZero, MERegWrite, MEResult, MERD2, MEWriteReg, MEReadDMMux, METype);
    //Output MEResult 
    DataMemory DM(MEResult, MERD2, Clk, MEMemWrite, MEMemRead, MEReadDM, mem0, mem1, mem2, mem3, mem4);
    //RD2SignOutput wire out  
    SignExtension SignExtendDM(MEReadDM[15:0], MESignOutputDM); 
    //EightSignOutput wire out 
    SignExtension8bit SignExtend8bitDM(MEReadDM[7:0], MEEightSignOutputDM); 
    
    // MEReadDMOut 
    Mux32Bit4To1 ReadDMMux(MEReadDMOut, MEReadDM, MESignOutputDM, MEEightSignOutputDM, 0, MEReadDMMux); 
    //ME/WB Register 
    MEWBRegister MEWBRegister1(MEMemtoReg, MERegWrite, MEResult, MEWriteReg, MEReadDMOut, METype, MEMemWrite, Clk, WBMemtoReg, WBRegWrite, WBResult, WBWriteReg, WBReadDM, WBType, WBMemWrite);
    //output wire out
    Mux32Bit2To1 RightMostMux(OutputWire, WBResult, WBReadDM, WBMemtoReg);
    //PCaddResult wire out
    PCAdder ADD4(PCResult, IFPCAddResult);
    //ALUResultUP wire out
    //ALU32Bit TOP_ALU(6'd0, EXPCAddResult, (EXSignOutput << 2), ALUResultUP, ALUResult64UP, Unused);
    // new mux
    //Mux32Bit2To1 ZeroSignal(FromZeroSignal, MEALUResultUP, IFPCAddResult, Zero);
    //BranchMuxResult wire out
    Mux32Bit2To1 PCSrcMux(BranchMuxResult, IFPCAddResult, BranchPCResult, (IDPCSrc & IDCompare));
    // 
    Mux32Bit4To1 JumpMux(Address, BranchMuxResult, {IDPCAddResult[31:28], (IDInstruction[27:0] << 2)}, IDRD1Out, 0, Jump);
    //RD1 & RD2 wire out
    RegisterFile Registers(R1, R2, WBWriteReg, OutputWire, WBRegWrite, IDPCAddResult, link, IDRD1, IDRD2, Clk, s0, s1, s2, s3, s4, s5, s6, s7, t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, v0, v1, a0, a1, a2);
    
    BranchComparator BranchFuckingComparator(CompareOp, IDRD1Out, IDRD2Out, IDCompare, DebugA, Clk); 
    //IDEX Register 
    IDEXRegister IDEXRegister1(IDRegWrite, IDMemRead, IDMemWrite, IDMemtoReg, IDPCSrc, IDMyCt, IDRegDst, IDReadH, IDReadL, IDRegWriteH, IDRegWriteL, IDALUSrc, IDHiLoInput, IDOutputToWriteData, IDOp, IDALUOp, IDMemData, IDReadDMMux, IDRD1Out, IDRD2Out, IDSignOutput, IDInstruction, IDType, IFIDWrite, Clk, EXRegWrite, EXMemRead, EXMemWrite, EXMemtoReg, EXPCSrc, EXMyCt, EXRegDst, EXReadH, EXReadL, EXRegWriteH, EXRegWriteL, EXALUSrc, EXHiLoInput, EXOutputToWriteData, EXOp, EXALUOp, EXMemData, EXReadDMMux, EXRD1, EXRD2, EXSignOutput, EXInstruction, EXType);

    Mux32Bit4To1 MuxToWriteMem(EXMemWriteData, EXRD2, 32'd0, RD2SignOutput, EightSignOutput, EXMemData);
     
    Controller Cont(IDInstruction[31:26], IDInstruction[5:0], IDInstruction[10:6], IDInstruction[25:21], IDInstruction[20:16], IDRegDst, IDRegWrite, IDALUSrc, IDMemRead, IDMemWrite, IDMemtoReg, IDPCSrc, IDMyCt, IDRTtoRS, IDALUOp, IDReadH, IDReadL, IDRegWriteH, IDRegWriteL, IDHiLoInput, IDOutputToWriteData, IDOp, IDAndI, CompareOp, IDMemData, IDReadDMMux, Jump, link, IDType, Clk, Rst);
    
    Mux32Bit4To1 MemForward(EXMemForWriteData, EXMemWriteData, OutputWire, MEResult , 32'd0, EXMemFor);
    
    Forward ForwardingUnit(EXInstruction[25:21], EXInstruction[20:16], MEWriteReg, WBWriteReg, EXType, METype, EXRegDst, EXMemFor, EXMemRead, WBMemWrite, MERegWrite, WBRegWrite, EXForAMux, EXForBMux);
    
    HazardDetection H1(Clk, R1, R2, WBWriteReg, MEWriteReg, EXWriteReg, EXMemRead, MEMemRead, IDType, IDCompare, IDPCSrc, MERegWrite, EXRegWrite, WBRegWrite, IFIDWrite, PCWrite, RD1Haz, RD2Haz, flush);
    
    Mux32Bit4To1 RD1HazardMux(IDRD1Out, IDRD1, OutputWire, MEResult, 32'd0, RD1Haz);
    
    Mux32Bit4To1 RD2HazardMux(IDRD2Out, IDRD2, OutputWire, MEResult, 32'd0, RD2Haz);
        //input [5:0] Opcode, func;
        //input Clk, Rst;
        //output reg RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, PCSrc, MyCtl1, MuxA, RTtoRS;
        //output reg [3:0] ALUOp; 
    // assign OutputWire = WriteDataOutput; 
    
    assign Reg_writedata = OutputWire; 
    assign pcresult = PCResult; 
    assign Hireg = ReadDataH; 
    assign Loreg = ReadDataL; 
    
 
endmodule
