`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu

// Module - register_file.v
// Description - Implements a register file with 32 32-Bit wide registers.
//                          (a 32x32 regsiter file with two read ports and one write port)
// INPUTS:-
// ReadRegister1: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister1'.
// ReadRegister2: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister2'.
// WriteRegister: 5-Bit address to select a register to be written through 32-Bit
//                input port 'WriteRegister'.
// WriteData: 32-Bit write input port.
// RegWrite: 1-Bit control input signal.
//
// OUTPUTS:-
// ReadData1: 32-Bit registered output. 
// ReadData2: 32-Bit registered output. 
//
// FUNCTIONALITY:-
// 'ReadRegister1' and 'ReadRegister2' are two 5-bit addresses to read two 
// registers simultaneously. The two 32-bit data sets are available on ports 
// 'ReadData1' and 'ReadData2', respectively. 'ReadData1' and 'ReadData2' are 
// registered outputs (output of register file is written into these registers 
// at the falling edge of the clock). You can view it as if outputs of registers
// specified by ReadRegister1 and ReadRegister2 are written into output 
// registers ReadData1 and ReadData2 at the falling edge of the clock. 
//
// 'RegWrite' signal is high during the rising edge of the clock if the input 
// data is to be written into the register file. The contents of the register 
// specified by address 'WriteRegister' in the register file are modified at the 
// rising edge of the clock if 'RegWrite' signal is high. The D-flip flops in 
// the register file are positive-edge (rising-edge) triggered. (You have to use 
// this information to generate the write-clock properly.) 
//
// NOTE:-
// We will design the register file such that the contents of registers do not 
// change for a pre-specified time before the falling edge of the clock arrives 
// to allow for data multiplexing and setup time.
////////////////////////////////////////////////////////////////////////////////

module RegisterFile(ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, LinkData, link, ReadData1, ReadData2, Clk, s0, s1, s2, s3, s4, s5, s6, s7, t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, v0, v1, a0, a1, a2);

    input [4:0] ReadRegister1, ReadRegister2, WriteRegister;
    input [31:0] WriteData, LinkData;
    input RegWrite, link, Clk;
    output reg [31:0] ReadData1;
    output reg [31:0] ReadData2;
    (* mark_debug = "true" *)  reg [31:0] regFile[0:31];
     output [31:0] s0, s1, s2, s3, s4, s5, s6, s7, t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, v0, v1, a0, a1, a2; 
      
    initial begin
        regFile[0] <= 32'h0;
    end 

    always@(posedge Clk)begin
        if (RegWrite == 1) begin
            regFile[WriteRegister] = WriteData;
        end
        if (link == 1) begin 
            regFile[31] = LinkData; 
       end
    end
    
    always@(*)begin 
        ReadData1 = regFile[ReadRegister1];
        ReadData2 = regFile[ReadRegister2];
    end


   
       //below is for post-synthesis simulation
       assign s0 = regFile[16];
       assign s1 = regFile[17];
       assign s2 = regFile[18];
       assign s3 = regFile[19];
       assign s4 = regFile[20];
       assign s5 = regFile[21];
       assign s6 = regFile[22];
       assign s7 = regFile[23];
       assign t0 = regFile[8];
       assign t1 = regFile[9];
       assign t2 = regFile[10];
       assign t3 = regFile[11];
       assign t4 = regFile[12];
       assign t5 = regFile[13];
       assign t6 = regFile[14];
       assign t7 = regFile[15];
       assign t8 = regFile[24];
       assign t9 = regFile[25];
       assign v0 = regFile[2];
       assign v1 = regFile[3];
       assign a0 = regFile[4];
       assign a1 = regFile[5];
       assign a2 = regFile[6]; 
       
endmodule
