`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu
// 
// Module - InstructionMemory.v
// Description - 32-Bit wide instruction memory.
//
// INPUT:-
// Address: 32-Bit address input port.
//
// OUTPUT:-
// Instruction: 32-Bit output port.
//
// FUNCTIONALITY:-
// Similar to the DataMemory, this module should also be byte-addressed
// (i.e., ignore bits 0 and 1 of 'Address'). All of the instructions will be 
// hard-coded into the instruction memory, so there is no need to write to the 
// InstructionMemory.  The contents of the InstructionMemory is the machine 
// language program to be run on your processor.
//
//
//we will store the machine code for a C function later. for now initialize 
//each entry to be its index * 4 (memory[i] = i * 4;)
//all you need to do is give an address as input and read the contents of the 
//address on your output port. 
// 
//Using a 32bit address you will index into the memory, output the contents of that specific 
//address. for data memory we are using 1K word of storage space. for the instruction memory 
//you may assume smaller size for practical purpose. you can use 128 words as the size and 
//hardcode the values.  in this case you need 7 bits to index into the memory. 
//
//be careful with the least two significant bits of the 32bit address. those help us index 
//into one of the 4 bytes in a word. therefore you will need to use bit [8-2] of the input address. 


////////////////////////////////////////////////////////////////////////////////

module InstructionMemory(Address, Instruction, InstructionDebug); 
    integer Instruction_memory; 
    input [31:0] Address;        // Input Address 

   (* mark_debug = "true" *) output reg [31:0] Instruction;    // Instruction at memory location Address
    output [31:0] InstructionDebug; 
   //Create 2D array for memory with 128 32-bit elements here
        reg [31:0] memory [0:600];
        
         
        initial begin  
        memory[0] <= 32'h23bdfffc;	//	main:			addi	$sp, $sp, -4
        memory[1] <= 32'hafbf0000;    //                sw    $ra, 0($sp)
        memory[2] <= 32'h34040000;    //                ori    $a0, $zero, 0
        memory[3] <= 32'h34050010;    //                ori    $a1, $zero, 16
        memory[4] <= 32'h34060410;    //                ori    $a2, $zero, 1040
        memory[5] <= 32'h0c000009;    //                jal    vbsme
        memory[6] <= 32'h8fbf0000;    //                lw    $ra, 0($sp)
        memory[7] <= 32'h23bd0004;    //                addi    $sp, $sp, 4
        memory[8] <= 32'h03e00008;    //                jr    $ra
        memory[9] <= 32'h34020000;    //    vbsme:            ori    $v0, $zero, 0
        memory[10] <= 32'h34030000;    //                ori    $v1, $zero, 0
        memory[11] <= 32'h34180000;    //                ori    $t8, $zero, 0
        memory[12] <= 32'h34190000;    //                ori    $t9, $zero, 0
        memory[13] <= 32'h20080010;    //                addi    $t0, $zero, 16
        memory[14] <= 32'h8c890004;    //                lw    $t1, 4($a0)
        memory[15] <= 32'h8c8a0008;    //                lw    $t2, 8($a0)
        memory[16] <= 32'h8c8b000c;    //                lw    $t3, 12($a0)
        memory[17] <= 32'h010a6022;    //                sub    $t4, $t0, $t2
        memory[18] <= 32'h012b6822;    //                sub    $t5, $t1, $t3
        memory[19] <= 32'h340e0000;    //                ori    $t6, $zero, 0
        memory[20] <= 32'h340f0000;    //                ori    $t7, $zero, 0
        memory[21] <= 32'h340803e8;    //                ori    $t0, $zero, 1000
        memory[22] <= 32'h23bdfffc;    //                addi    $sp, $sp, -4
        memory[23] <= 32'hafbf0000;    //                sw    $ra, 0($sp)
        memory[24] <= 32'h0c00008a;    //                jal    sadroutine
        memory[25] <= 32'h02004020;    //                add    $t0, $s0, $zero
        memory[26] <= 32'h122e0002;    //    StartWhile:        beq    $s1, $t6, Equal
        memory[27] <= 32'h34110001;    //                ori    $s1, $zero, 1
        memory[28] <= 32'h10000001;    //                beq    $zero, $zero, Skip
        memory[29] <= 32'h34110000;    //    Equal:            ori    $s1, $zero, 0
        memory[30] <= 32'h11ed0002;    //    Skip:            beq    $t7, $t5, Equal1
        memory[31] <= 32'h34120001;    //                ori    $s2, $zero, 1
        memory[32] <= 32'h10000001;    //                beq    $zero, $zero, Skip1
        memory[33] <= 32'h34110000;    //    Equal1:            ori    $s1, $zero, 0
        memory[34] <= 32'h02328825;    //    Skip1:            or    $s1, $s1, $s2
        memory[35] <= 32'h16200005;    //                bne    $s1, $zero, While
        memory[36] <= 32'h03001020;    //                add    $v0, $t8, $zero
        memory[37] <= 32'h03201820;    //                add    $v1, $t9, $zero
        memory[38] <= 32'h8fbf0000;    //                lw    $ra, 0($sp)
        memory[39] <= 32'h23bd0004;    //                addi    $sp, $sp, 4
        memory[40] <= 32'h03e00008;    //                jr    $ra
        memory[41] <= 32'h11ed0002;    //    While:            beq    $t7, $t5, Equal2
        memory[42] <= 32'h34110000;    //                ori    $s1, $zero, 0
        memory[43] <= 32'h10000001;    //                beq    $zero, $zero, Skip2
        memory[44] <= 32'h34110001;    //    Equal2:            ori    $s1, $zero, 1
        memory[45] <= 32'h16200001;    //    Skip2:            bne    $s1, $zero, ymaxif
        memory[46] <= 32'h08000041;    //                j    ymaxelse
        memory[47] <= 32'h21ce0001;    //    ymaxif:            addi    $t6, $t6, 1
        memory[48] <= 32'h11cc0002;    //                beq    $t6, $t4, Equal3
        memory[49] <= 32'h34110000;    //                ori    $s1, $zero, 0
        memory[50] <= 32'h10000001;    //                beq    $zero, $zero, Skip3
        memory[51] <= 32'h34110001;    //    Equal3:            ori    $s1, $zero, 1
        memory[52] <= 32'h11ed0002;    //    Skip3:            beq    $t7, $t5, Equal4
        memory[53] <= 32'h34130000;    //                ori    $s3, $zero, 0
        memory[54] <= 32'h10000001;    //                beq    $zero, $zero, Skip4
        memory[55] <= 32'h34130001;    //    Equal4:            ori    $s3, $zero, 1
        memory[56] <= 32'h02338824;    //    Skip4:            and    $s1, $s1, $s3
        memory[57] <= 32'h12200008;    //                beq    $s1, $zero, continue
        memory[58] <= 32'h0c00008a;    //                jal    sadroutine
        memory[59] <= 32'h0c0000b8;    //                jal    UpdateSad
        memory[60] <= 32'h03001020;    //                add    $v0, $t8, $zero
        memory[61] <= 32'h03201820;    //                add    $v1, $t9, $zero
        memory[62] <= 32'h8fbf0000;    //                lw    $ra, 0($sp)
        memory[63] <= 32'h23bd0004;    //                addi    $sp, $sp, 4
        memory[64] <= 32'h03e00008;    //                jr    $ra
        memory[65] <= 32'h21ef0001;    //    ymaxelse:        addi    $t7, $t7, 1
        memory[66] <= 32'h0c00008a;    //    continue:        jal    sadroutine
        memory[67] <= 32'h0c0000b8;    //                jal    UpdateSad
        memory[68] <= 32'h01ee9822;    //                sub    $s3, $t7, $t6
        memory[69] <= 32'h0013882a;    //                slt    $s1, $zero, $s3
        memory[70] <= 32'h00000000;    //                nop
        memory[71] <= 32'h00000000;    //                nop
        memory[72] <= 32'h16200000;    //                bne    $s1, $zero, DiagonalLeftfor
        memory[73] <= 32'h21ce0001;    //    DiagonalLeftfor:    addi    $t6, $t6, 1
        memory[74] <= 32'h21efffff;    //                addi    $t7, $t7, -1
        memory[75] <= 32'h0c00008a;    //                jal    sadroutine
        memory[76] <= 32'h0c0000b8;    //                jal    UpdateSad
        memory[77] <= 32'h2273ffff;    //                addi    $s3, $s3, -1
        memory[78] <= 32'h0013882a;    //                slt    $s1, $zero, $s3
        memory[79] <= 32'h00000000;    //                nop
        memory[80] <= 32'h00000000;    //                nop
        memory[81] <= 32'h00000000;    //                nop
        memory[82] <= 32'h1620fff6;    //                bne    $s1, $zero, DiagonalLeftfor
        memory[83] <= 32'h100f0002;    //                beq    $zero, $t7, Equal5
        memory[84] <= 32'h34120000;    //                ori    $s2, $zero, 0
        memory[85] <= 32'h10000001;    //                beq    $zero, $zero, Skip5
        memory[86] <= 32'h34120001;    //    Equal5:            ori    $s2, $zero, 1
        memory[87] <= 32'h11cc0002;    //    Skip5:            beq    $t6, $t4, Equal6
        memory[88] <= 32'h34110000;    //                ori    $s1, $zero, 0
        memory[89] <= 32'h10000001;    //                beq    $zero, $zero, Skip6
        memory[90] <= 32'h34110001;    //    Equal6:            ori    $s1, $zero, 1
        memory[91] <= 32'h02328825;    //    Skip6:            or    $s1, $s1, $s2
        memory[92] <= 32'h1220ffec;    //                beq    $s1, $zero, DiagonalLeftfor
        memory[93] <= 32'h11cc0002;    //                beq    $t6, $t4, Equal7
        memory[94] <= 32'h34110000;    //                ori    $s1, $zero, 0
        memory[95] <= 32'h10000001;    //                beq    $zero, $zero, Skip7
        memory[96] <= 32'h34110001;    //    Equal7:            ori    $s1, $zero, 1
        memory[97] <= 32'h16200002;    //    Skip7:            bne    $s1, $zero, xmaxif
        memory[98] <= 32'h21ce0001;    //    xmaxelse:        addi    $t6, $t6, 1
        memory[99] <= 32'h08000072;    //                j    continue1
        memory[100] <= 32'h21ef0001;    //    xmaxif:            addi    $t7, $t7, 1
        memory[101] <= 32'h11ed0002;    //                beq    $t7, $t5, Equal9
        memory[102] <= 32'h34130000;    //                ori    $s3, $zero, 0
        memory[103] <= 32'h10000001;    //                beq    $zero, $zero, Skip9
        memory[104] <= 32'h34130001;    //    Equal9:            ori    $s3, $zero, 1
        memory[105] <= 32'h02338824;    //    Skip9:            and    $s1, $s1, $s3
        memory[106] <= 32'h12200007;    //                beq    $s1, $zero, continue1
        memory[107] <= 32'h0c00008a;    //                jal    sadroutine
        memory[108] <= 32'h0c0000b8;    //                jal    UpdateSad
        memory[109] <= 32'h03001020;    //                add    $v0, $t8, $zero
        memory[110] <= 32'h03201820;    //                add    $v1, $t9, $zero
        memory[111] <= 32'h8fbf0000;    //                lw    $ra, 0($sp)
        memory[112] <= 32'h23bd0004;    //                addi    $sp, $sp, 4
        memory[113] <= 32'h03e00008;    //                jr    $ra
        memory[114] <= 32'h0c00008a;    //    continue1:        jal    sadroutine
        memory[115] <= 32'h0c0000b8;    //                jal    UpdateSad
        memory[116] <= 32'h01cf9822;    //                sub    $s3, $t6, $t7
        memory[117] <= 32'h0013882a;    //                slt    $s1, $zero, $s3
        memory[118] <= 32'h00000000;    //                nop
        memory[119] <= 32'h00000000;    //                nop
        memory[120] <= 32'h16200000;    //                bne    $s1, $zero, DiagonalRightfor
        memory[121] <= 32'h21ceffff;    //    DiagonalRightfor:    addi    $t6, $t6, -1
        memory[122] <= 32'h21ef0001;    //                addi    $t7, $t7, 1
        memory[123] <= 32'h0c00008a;    //                jal    sadroutine
        memory[124] <= 32'h0c0000b8;    //                jal    UpdateSad
        memory[125] <= 32'h2273ffff;    //                addi    $s3, $s3, -1
        memory[126] <= 32'h0013882a;    //                slt    $s1, $zero, $s3
        memory[127] <= 32'h11ed0002;    //                beq    $t7, $t5, Equal10
        memory[128] <= 32'h34110000;    //                ori    $s1, $zero, 0
        memory[129] <= 32'h10000001;    //                beq    $zero, $zero, Skip10
        memory[130] <= 32'h34110001;    //    Equal10:        ori    $s1, $zero, 1
        memory[131] <= 32'h100e0002;    //    Skip10:            beq    $zero, $t6, Equal11
        memory[132] <= 32'h34120000;    //                ori    $s2, $zero, 0
        memory[133] <= 32'h10000001;    //                beq    $zero, $zero, Skip11
        memory[134] <= 32'h34120001;    //    Equal11:        ori    $s2, $zero, 1
        memory[135] <= 32'h02518825;    //    Skip11:            or    $s1, $s2, $s1
        memory[136] <= 32'h1220fff0;    //                beq    $s1, $zero, DiagonalRightfor
        memory[137] <= 32'h0800001a;    //                j    StartWhile
        memory[138] <= 32'h34100000;    //    sadroutine:        ori    $s0, $zero, 0
        memory[139] <= 32'h34110000;    //                ori    $s1, $zero, 0
        memory[140] <= 32'h34120000;    //                ori    $s2, $zero, 0
        memory[141] <= 32'h022ab02a;    //    for:            slt    $s6, $s1, $t2
        memory[142] <= 32'h00000000;    //                nop
        memory[143] <= 32'h00000000;    //                nop
        memory[144] <= 32'h16c00001;    //                bne    $s6, $zero, for1
        memory[145] <= 32'h03e00008;    //                jr    $ra
        memory[146] <= 32'h024bb02a;    //    for1:            slt    $s6, $s2, $t3
        memory[147] <= 32'h00000000;    //                nop
        memory[148] <= 32'h00000000;    //                nop
        memory[149] <= 32'h16c00003;    //                bne    $s6, $zero, Insidefor
        memory[150] <= 32'h22310001;    //                addi    $s1, $s1, 1
        memory[151] <= 32'h00009020;    //                add    $s2, $zero, $zero
        memory[152] <= 32'h0800008d;    //                j    for
        memory[153] <= 32'h022ea020;    //    Insidefor:        add    $s4, $s1, $t6
        memory[154] <= 32'h024fa820;    //                add    $s5, $s2, $t7
        memory[155] <= 32'h21360000;    //                addi    $s6, $t1, 0
        memory[156] <= 32'h02d40018;    //                mult    $s6, $s4
        memory[157] <= 32'h0000b012;    //                mflo    $s6
        memory[158] <= 32'h02b6b020;    //                add    $s6, $s5, $s6
        memory[159] <= 32'h0016b080;    //                sll    $s6, $s6, 2
        memory[160] <= 32'h02c5b020;    //                add    $s6, $s6, $a1
        memory[161] <= 32'h00000000;    //                nop
        memory[162] <= 32'h00000000;    //                nop
        memory[163] <= 32'h00000000;    //                nop
        memory[164] <= 32'h8ed50000;    //                lw    $s5, 0($s6)
        memory[165] <= 32'h21760000;    //                addi    $s6, $t3, 0
        memory[166] <= 32'h02d10018;    //                mult    $s6, $s1
        memory[167] <= 32'h0000b012;    //                mflo    $s6
        memory[168] <= 32'h0256b020;    //                add    $s6, $s2, $s6
        memory[169] <= 32'h0016b080;    //                sll    $s6, $s6, 2
        memory[170] <= 32'h02c6b020;    //                add    $s6, $s6, $a2
        memory[171] <= 32'h00000000;    //                nop
        memory[172] <= 32'h00000000;    //                nop
        memory[173] <= 32'h00000000;    //                nop
        memory[174] <= 32'h8ed70000;    //                lw    $s7, 0($s6)
        memory[175] <= 32'h02f5b022;    //                sub    $s6, $s7, $s5
        memory[176] <= 32'h02c0b82a;    //                slt    $s7, $s6, $zero
        memory[177] <= 32'h00000000;    //                nop
        memory[178] <= 32'h00000000;    //                nop
        memory[179] <= 32'h12e00001;    //                beq    $s7, $zero, Insidefor1
        memory[180] <= 32'h0016b022;    //                sub    $s6, $zero, $s6
        memory[181] <= 32'h02d08020;    //    Insidefor1:        add    $s0, $s6, $s0
        memory[182] <= 32'h22520001;    //                addi    $s2, $s2, 1
        memory[183] <= 32'h08000092;    //                j    for1
        memory[184] <= 32'h0208882a;    //    UpdateSad:        slt    $s1, $s0, $t0
        memory[185] <= 32'h00000000;    //                nop
        memory[186] <= 32'h00000000;    //                nop
        memory[187] <= 32'h12200003;    //                beq    $s1, $zero, End
        memory[188] <= 32'h02004020;    //                add    $t0, $s0, $zero
        memory[189] <= 32'h01c0c020;    //                add    $t8, $t6, $zero
        memory[190] <= 32'h01e0c820;    //                add    $t9, $t7, $zero
        memory[191] <= 32'h03e00008;    //    End:            jr    $ra
        memory[192] <= 32'h27bd0004;    //    end:            addiu    $sp, $sp, 4
        memory[193] <= 32'h03e00008;    //                jr    $ra




             
//memory[0] <= 32'h20120000;	//	main:	addi	$s2, $zero, 0
//        memory[1] <= 32'h20130000;    //        addi    $s3, $zero, 0
//        memory[2] <= 32'h20110000;    //        addi    $s1, $zero, 0
//        memory[3] <= 32'h20140064;    //        addi    $s4, $zero, 100
//        memory[4] <= 32'h20150000;    //        addi    $s5, $zero, 0
//        memory[5] <= 32'h00000000;    //        nop
//        memory[6] <= 32'h00000000;    //        nop
//        memory[7] <= 32'h00000000;    //        nop
//        memory[8] <= 32'h00000000;    //        nop
//        memory[9] <= 32'h20130004;    //        addi    $s3, $zero, 4
//        memory[10] <= 32'h8e750000;    //        lw    $s5, 0($s3)
//        memory[11] <= 32'h00000000;    //        nop
//        memory[12] <= 32'h00000000;    //        nop
//        memory[13] <= 32'h00000000;    //        nop
//        memory[14] <= 32'h00000000;    //        nop
//        memory[15] <= 32'h00000000;    //        nop
//        memory[16] <= 32'h8e510000;    //        lw    $s1, 0($s2)
//        memory[17] <= 32'h12910005;    //        beq    $s4, $s1, branch
//        memory[18] <= 32'h00000000;    //        nop
//        memory[19] <= 32'h00000000;    //        nop
//        memory[20] <= 32'h00000000;    //        nop
//        memory[21] <= 32'h00000000;    //        nop
//        memory[22] <= 32'h00000000;    //        nop
//        memory[23] <= 32'h20110000;    //    branch:    addi    $s1, $zero, 0
//        memory[24] <= 32'h00000000;    //        nop
//        memory[25] <= 32'h00000000;    //        nop
//        memory[26] <= 32'h00000000;    //        nop
//        memory[27] <= 32'h00000000;    //        nop
//        memory[28] <= 32'h00000000;    //        nop
//        memory[29] <= 32'h8e510000;    //        lw    $s1, 0($s2)
//        memory[30] <= 32'h02339020;    //        add    $s2, $s1, $s3



        
 //       $readmemh ("private_instruction_memory.txt", memory); 
        
        
        
        
  /*         
memory[0] <= 32'h20100001;	//	main:	addi	$s0, $zero, 1
        memory[1] <= 32'h20110001;    //        addi    $s1, $zero, 1
        memory[2] <= 32'h00000000;    //        nop
        memory[3] <= 32'h00000000;    //        nop
        memory[4] <= 32'h00000000;    //        nop
        memory[5] <= 32'h20100002;    //        addi    $s0, $zero, 2
        memory[6] <= 32'h02000011;    //        mthi    $s0
        memory[7] <= 32'h00000000;    //        nop
        memory[8] <= 32'h00000000;    //        nop
        memory[9] <= 32'h00000000;    //        nop
        memory[10] <= 32'h20110003;    //        addi    $s1, $zero, 3
        memory[11] <= 32'h20100000;    //        addi    $s0, $zero, 0
        memory[12] <= 32'h02200013;    //        mtlo    $s1 */











/*    
memory[0] <= 32'h20140000;	//	main:	addi	$s4, $zero, 0
        memory[1] <= 32'h20160004;    //        addi    $s6, $zero, 4
        memory[2] <= 32'h20120005;    //        addi    $s2, $zero, 5
        memory[3] <= 32'h2011000b;    //        addi    $s1, $zero, 11
        memory[4] <= 32'h20130003;    //        addi    $s3, $zero, 3
        memory[5] <= 32'h20150007;    //        addi    $s5, $zero, 7
        memory[6] <= 32'h00000000;    //        nop
        memory[7] <= 32'h00000000;    //        nop
        memory[8] <= 32'h00000000;    //        nop
        memory[9] <= 32'h00000000;    //        nop
        memory[10] <= 32'h00000000;    //        nop
        memory[11] <= 32'h02339022;    //        sub    $s2, $s1, $s3
        memory[12] <= 32'h02554024;    //        and    $t0, $s2, $s5
        memory[13] <= 32'h02d24825;    //        or    $t1, $s6, $s2
        memory[14] <= 32'h02525020;    //        add    $t2, $s2, $s2*/



















      /*  memory[0] <= 32'h34040000;	//	main:		ori	$a0, $zero, 0
        memory[1] <= 32'h00000000;    //            nop
        memory[2] <= 32'h00000000;    //            nop
        memory[3] <= 32'h00000000;    //            nop
        memory[4] <= 32'h00000000;    //            nop
        memory[5] <= 32'h00000000;    //            nop
        
        memory[6] <= 32'h08000018;    //            j    start
        memory[7] <= 32'h00000000;    //            nop
        memory[8] <= 32'h00000000;    //            nop
        memory[9] <= 32'h00000000;    //            nop
        memory[10] <= 32'h00000000;    //            nop
        memory[11] <= 32'h00000000;    //            nop
        memory[12] <= 32'h2004000a;    //            addi    $a0, $zero, 10
        memory[13] <= 32'h00000000;    //            nop
        memory[14] <= 32'h00000000;    //            nop
        memory[15] <= 32'h00000000;    //            nop
        memory[16] <= 32'h00000000;    //            nop
        memory[17] <= 32'h00000000;    //            nop
        memory[18] <= 32'h2004000a;    //            addi    $a0, $zero, 10
        memory[19] <= 32'h00000000;    //            nop
        memory[20] <= 32'h00000000;    //            nop
        memory[21] <= 32'h00000000;    //            nop
        memory[22] <= 32'h00000000;    //            nop
        memory[23] <= 32'h00000000;    //            nop
        memory[24] <= 32'h8c900004;    //    start:        lw    $s0, 4($a0)
        memory[25] <= 32'h00000000;    //            nop
        memory[26] <= 32'h00000000;    //            nop
        memory[27] <= 32'h00000000;    //            nop
        memory[28] <= 32'h00000000;    //            nop
        memory[29] <= 32'h00000000;    //            nop
        memory[30] <= 32'h8c900008;    //            lw    $s0, 8($a0)
        memory[31] <= 32'h00000000;    //            nop
        memory[32] <= 32'h00000000;    //            nop
        memory[33] <= 32'h00000000;    //            nop
        memory[34] <= 32'h00000000;    //            nop
        memory[35] <= 32'h00000000;    //            nop
        memory[36] <= 32'hac900000;    //            sw    $s0, 0($a0)
        memory[37] <= 32'h00000000;    //            nop
        memory[38] <= 32'h00000000;    //            nop
        memory[39] <= 32'h00000000;    //            nop
        memory[40] <= 32'h00000000;    //            nop
        memory[41] <= 32'h00000000;    //            nop
        memory[42] <= 32'hac90000c;    //            sw    $s0, 12($a0)
        memory[43] <= 32'h00000000;    //            nop
        memory[44] <= 32'h00000000;    //            nop
        memory[45] <= 32'h00000000;    //            nop
        memory[46] <= 32'h00000000;    //            nop
        memory[47] <= 32'h00000000;    //            nop
        memory[48] <= 32'h8c910000;    //            lw    $s1, 0($a0)
        memory[49] <= 32'h00000000;    //            nop
        memory[50] <= 32'h00000000;    //            nop
        memory[51] <= 32'h00000000;    //            nop
        memory[52] <= 32'h00000000;    //            nop
        memory[53] <= 32'h00000000;    //            nop
        memory[54] <= 32'h8c92000c;    //            lw    $s2, 12($a0)
        memory[55] <= 32'h00000000;    //            nop
        memory[56] <= 32'h00000000;    //            nop
        memory[57] <= 32'h00000000;    //            nop
        memory[58] <= 32'h00000000;    //            nop
        memory[59] <= 32'h00000000;    //            nop
        memory[60] <= 32'h12000017;    //            beq    $s0, $zero, branch1
        memory[61] <= 32'h00000000;    //            nop
        memory[62] <= 32'h00000000;    //            nop
        memory[63] <= 32'h00000000;    //            nop
        memory[64] <= 32'h00000000;    //            nop
        memory[65] <= 32'h00000000;    //            nop
        memory[66] <= 32'h02008820;    //            add    $s1, $s0, $zero
        memory[67] <= 32'h00000000;    //            nop
        memory[68] <= 32'h00000000;    //            nop
        memory[69] <= 32'h00000000;    //            nop
        memory[70] <= 32'h00000000;    //            nop
        memory[71] <= 32'h00000000;    //            nop
        memory[72] <= 32'h1211000b;    //            beq    $s0, $s1, branch1
        memory[73] <= 32'h00000000;    //            nop
        memory[74] <= 32'h00000000;    //            nop
        memory[75] <= 32'h00000000;    //            nop
        memory[76] <= 32'h00000000;    //            nop
        memory[77] <= 32'h00000000;    //            nop
        memory[78] <= 32'h0800013e;    //            j    error
        memory[79] <= 32'h00000000;    //            nop
        memory[80] <= 32'h00000000;    //            nop
        memory[81] <= 32'h00000000;    //            nop
        memory[82] <= 32'h00000000;    //            nop
        memory[83] <= 32'h00000000;    //            nop
        memory[84] <= 32'h2010ffff;    //    branch1:    addi    $s0, $zero, -1
        memory[85] <= 32'h00000000;    //            nop
        memory[86] <= 32'h00000000;    //            nop
        memory[87] <= 32'h00000000;    //            nop
        memory[88] <= 32'h00000000;    //            nop
        memory[89] <= 32'h00000000;    //            nop
        memory[90] <= 32'h0601ffbd;    //            bgez    $s0, start
        memory[91] <= 32'h00000000;    //            nop
        memory[92] <= 32'h00000000;    //            nop
        memory[93] <= 32'h00000000;    //            nop
        memory[94] <= 32'h00000000;    //            nop
        memory[95] <= 32'h00000000;    //            nop
        memory[96] <= 32'h22100001;    //            addi    $s0, $s0, 1
        memory[97] <= 32'h00000000;    //            nop
        memory[98] <= 32'h00000000;    //            nop
        memory[99] <= 32'h00000000;    //            nop
        memory[100] <= 32'h00000000;    //            nop
        memory[101] <= 32'h00000000;    //            nop
        memory[102] <= 32'h0601000b;    //            bgez    $s0, branch2
        memory[103] <= 32'h00000000;    //            nop
        memory[104] <= 32'h00000000;    //            nop
        memory[105] <= 32'h00000000;    //            nop
        memory[106] <= 32'h00000000;    //            nop
        memory[107] <= 32'h00000000;    //            nop
        memory[108] <= 32'h0800013e;    //            j    error
        memory[109] <= 32'h00000000;    //            nop
        memory[110] <= 32'h00000000;    //            nop
        memory[111] <= 32'h00000000;    //            nop
        memory[112] <= 32'h00000000;    //            nop
        memory[113] <= 32'h00000000;    //            nop
        memory[114] <= 32'h2010ffff;    //    branch2:    addi    $s0, $zero, -1
        memory[115] <= 32'h00000000;    //            nop
        memory[116] <= 32'h00000000;    //            nop
        memory[117] <= 32'h00000000;    //            nop
        memory[118] <= 32'h00000000;    //            nop
        memory[119] <= 32'h00000000;    //            nop
        memory[120] <= 32'h1e000017;    //            bgtz    $s0, branch3
        memory[121] <= 32'h00000000;    //            nop
        memory[122] <= 32'h00000000;    //            nop
        memory[123] <= 32'h00000000;    //            nop
        memory[124] <= 32'h00000000;    //            nop
        memory[125] <= 32'h00000000;    //            nop
        memory[126] <= 32'h20100001;    //            addi    $s0, $zero, 1
        memory[127] <= 32'h00000000;    //            nop
        memory[128] <= 32'h00000000;    //            nop
        memory[129] <= 32'h00000000;    //            nop
        memory[130] <= 32'h00000000;    //            nop
        memory[131] <= 32'h00000000;    //            nop
        memory[132] <= 32'h1e00000b;    //            bgtz    $s0, branch3
        memory[133] <= 32'h00000000;    //            nop
        memory[134] <= 32'h00000000;    //            nop
        memory[135] <= 32'h00000000;    //            nop
        memory[136] <= 32'h00000000;    //            nop
        memory[137] <= 32'h00000000;    //            nop
        memory[138] <= 32'h0800013e;    //            j    error
        memory[139] <= 32'h00000000;    //            nop
        memory[140] <= 32'h00000000;    //            nop
        memory[141] <= 32'h00000000;    //            nop
        memory[142] <= 32'h00000000;    //            nop
        memory[143] <= 32'h00000000;    //            nop
        memory[144] <= 32'h06000017;    //    branch3:    bltz    $s0, branch4
        memory[145] <= 32'h00000000;    //            nop
        memory[146] <= 32'h00000000;    //            nop
        memory[147] <= 32'h00000000;    //            nop
        memory[148] <= 32'h00000000;    //            nop
        memory[149] <= 32'h00000000;    //            nop
        memory[150] <= 32'h2010ffff;    //            addi    $s0, $zero, -1
        memory[151] <= 32'h00000000;    //            nop
        memory[152] <= 32'h00000000;    //            nop
        memory[153] <= 32'h00000000;    //            nop
        memory[154] <= 32'h00000000;    //            nop
        memory[155] <= 32'h00000000;    //            nop
        memory[156] <= 32'h0600000b;    //            bltz    $s0, branch4
        memory[157] <= 32'h00000000;    //            nop
        memory[158] <= 32'h00000000;    //            nop
        memory[159] <= 32'h00000000;    //            nop
        memory[160] <= 32'h00000000;    //            nop
        memory[161] <= 32'h00000000;    //            nop
        memory[162] <= 32'h0800013e;    //            j    error
        memory[163] <= 32'h00000000;    //            nop
        memory[164] <= 32'h00000000;    //            nop
        memory[165] <= 32'h00000000;    //            nop
        memory[166] <= 32'h00000000;    //            nop
        memory[167] <= 32'h00000000;    //            nop
        memory[168] <= 32'h2011ffff;    //    branch4:    addi    $s1, $zero, -1
        memory[169] <= 32'h00000000;    //            nop
        memory[170] <= 32'h00000000;    //            nop
        memory[171] <= 32'h00000000;    //            nop
        memory[172] <= 32'h00000000;    //            nop
        memory[173] <= 32'h00000000;    //            nop
        memory[174] <= 32'h16110011;    //            bne    $s0, $s1, branch5
        memory[175] <= 32'h00000000;    //            nop
        memory[176] <= 32'h00000000;    //            nop
        memory[177] <= 32'h00000000;    //            nop
        memory[178] <= 32'h00000000;    //            nop
        memory[179] <= 32'h00000000;    //            nop
        memory[180] <= 32'h1600000b;    //            bne    $s0, $zero, branch5
        memory[181] <= 32'h00000000;    //            nop
        memory[182] <= 32'h00000000;    //            nop
        memory[183] <= 32'h00000000;    //            nop
        memory[184] <= 32'h00000000;    //            nop
        memory[185] <= 32'h00000000;    //            nop
        memory[186] <= 32'h0800013e;    //            j    error
        memory[187] <= 32'h00000000;    //            nop
        memory[188] <= 32'h00000000;    //            nop
        memory[189] <= 32'h00000000;    //            nop
        memory[190] <= 32'h00000000;    //            nop
        memory[191] <= 32'h00000000;    //            nop
        memory[192] <= 32'h20100080;    //    branch5:    addi    $s0, $zero, 128
        memory[193] <= 32'h00000000;    //            nop
        memory[194] <= 32'h00000000;    //            nop
        memory[195] <= 32'h00000000;    //            nop
        memory[196] <= 32'h00000000;    //            nop
        memory[197] <= 32'h00000000;    //            nop
        memory[198] <= 32'ha0900000;    //            sb    $s0, 0($a0)
        memory[199] <= 32'h00000000;    //            nop
        memory[200] <= 32'h00000000;    //            nop
        memory[201] <= 32'h00000000;    //            nop
        memory[202] <= 32'h00000000;    //            nop
        memory[203] <= 32'h00000000;    //            nop
        memory[204] <= 32'h80900000;    //            lb    $s0, 0($a0)
        memory[205] <= 32'h00000000;    //            nop
        memory[206] <= 32'h00000000;    //            nop
        memory[207] <= 32'h00000000;    //            nop
        memory[208] <= 32'h00000000;    //            nop
        memory[209] <= 32'h00000000;    //            nop
        memory[210] <= 32'h1a00000b;    //            blez    $s0, branch6
        memory[211] <= 32'h00000000;    //            nop
        memory[212] <= 32'h00000000;    //            nop
        memory[213] <= 32'h00000000;    //            nop
        memory[214] <= 32'h00000000;    //            nop
        memory[215] <= 32'h00000000;    //            nop
        memory[216] <= 32'h0800013e;    //            j    error
        memory[217] <= 32'h00000000;    //            nop
        memory[218] <= 32'h00000000;    //            nop
        memory[219] <= 32'h00000000;    //            nop
        memory[220] <= 32'h00000000;    //            nop
        memory[221] <= 32'h00000000;    //            nop
        memory[222] <= 32'h2010ffff;    //    branch6:    addi    $s0, $zero, -1
        memory[223] <= 32'h00000000;    //            nop
        memory[224] <= 32'h00000000;    //            nop
        memory[225] <= 32'h00000000;    //            nop
        memory[226] <= 32'h00000000;    //            nop
        memory[227] <= 32'h00000000;    //            nop
        memory[228] <= 32'ha4900000;    //            sh    $s0, 0($a0)
        memory[229] <= 32'h00000000;    //            nop
        memory[230] <= 32'h00000000;    //            nop
        memory[231] <= 32'h00000000;    //            nop
        memory[232] <= 32'h00000000;    //            nop
        memory[233] <= 32'h00000000;    //            nop
        memory[234] <= 32'h20100000;    //            addi    $s0, $zero, 0
        memory[235] <= 32'h00000000;    //            nop
        memory[236] <= 32'h00000000;    //            nop
        memory[237] <= 32'h00000000;    //            nop
        memory[238] <= 32'h00000000;    //            nop
        memory[239] <= 32'h00000000;    //            nop
        memory[240] <= 32'h84900000;    //            lh    $s0, 0($a0)
        memory[241] <= 32'h00000000;    //            nop
        memory[242] <= 32'h00000000;    //            nop
        memory[243] <= 32'h00000000;    //            nop
        memory[244] <= 32'h00000000;    //            nop
        memory[245] <= 32'h00000000;    //            nop
        memory[246] <= 32'h1a00000b;    //            blez    $s0, branch7
        memory[247] <= 32'h00000000;    //            nop
        memory[248] <= 32'h00000000;    //            nop
        memory[249] <= 32'h00000000;    //            nop
        memory[250] <= 32'h00000000;    //            nop
        memory[251] <= 32'h00000000;    //            nop
        memory[252] <= 32'h0800013e;    //            j    error
        memory[253] <= 32'h00000000;    //            nop
        memory[254] <= 32'h00000000;    //            nop
        memory[255] <= 32'h00000000;    //            nop
        memory[256] <= 32'h00000000;    //            nop
        memory[257] <= 32'h00000000;    //            nop
        memory[258] <= 32'h2010ffff;    //    branch7:    addi    $s0, $zero, -1
        memory[259] <= 32'h00000000;    //            nop
        memory[260] <= 32'h00000000;    //            nop
        memory[261] <= 32'h00000000;    //            nop
        memory[262] <= 32'h00000000;    //            nop
        memory[263] <= 32'h00000000;    //            nop
        memory[264] <= 32'h3c100001;    //            lui    $s0, 1
        memory[265] <= 32'h00000000;    //            nop
        memory[266] <= 32'h00000000;    //            nop
        memory[267] <= 32'h00000000;    //            nop
        memory[268] <= 32'h00000000;    //            nop
        memory[269] <= 32'h00000000;    //            nop
        memory[270] <= 32'h0601000b;    //            bgez    $s0, branch8
        memory[271] <= 32'h00000000;    //            nop
        memory[272] <= 32'h00000000;    //            nop
        memory[273] <= 32'h00000000;    //            nop
        memory[274] <= 32'h00000000;    //            nop
        memory[275] <= 32'h00000000;    //            nop
        memory[276] <= 32'h0800013e;    //            j    error
        memory[277] <= 32'h00000000;    //            nop
        memory[278] <= 32'h00000000;    //            nop
        memory[279] <= 32'h00000000;    //            nop
        memory[280] <= 32'h00000000;    //            nop
        memory[281] <= 32'h00000000;    //            nop
        memory[282] <= 32'h08000126;    //    branch8:    j    jump1
        memory[283] <= 32'h00000000;    //            nop
        memory[284] <= 32'h00000000;    //            nop
        memory[285] <= 32'h00000000;    //            nop
        memory[286] <= 32'h00000000;    //            nop
        memory[287] <= 32'h00000000;    //            nop
        memory[288] <= 32'h2210fffe;    //            addi    $s0, $s0, -2
        memory[289] <= 32'h00000000;    //            nop
        memory[290] <= 32'h00000000;    //            nop
        memory[291] <= 32'h00000000;    //            nop 
        memory[292] <= 32'h00000000;    //            nop
        memory[293] <= 32'h00000000;    //            nop
        memory[294] <= 32'h0c000132;    //    jump1:        jal    jal1
        memory[295] <= 32'h00000000;    //            nop
        memory[296] <= 32'h00000000;    //            nop
        memory[297] <= 32'h00000000;    //            nop
        memory[298] <= 32'h00000000;    //            nop
        memory[299] <= 32'h00000000;    //            nop
        memory[300] <= 32'h08000018;    //            j    start
        memory[301] <= 32'h00000000;    //            nop
        memory[302] <= 32'h00000000;    //            nop
        memory[303] <= 32'h00000000;    //            nop
        memory[304] <= 32'h00000000;    //            nop
        memory[305] <= 32'h00000000;    //            nop
        memory[306] <= 32'h03e00008;    //    jal1:        jr    $ra
        memory[307] <= 32'h00000000;    //            nop
        memory[308] <= 32'h00000000;    //            nop
        memory[309] <= 32'h00000000;    //            nop
        memory[310] <= 32'h00000000;    //            nop
        memory[311] <= 32'h00000000;    //            nop
        memory[312] <= 32'h0800013e;    //            j    error
        memory[313] <= 32'h00000000;    //            nop
        memory[314] <= 32'h00000000;    //            nop
        memory[315] <= 32'h00000000;    //            nop
        memory[316] <= 32'h00000000;    //            nop
        memory[317] <= 32'h00000000;    //            nop
        memory[318] <= 32'h00000008;    //    error:        jr    $zero
        memory[319] <= 32'h00000000;    //            nop
        memory[320] <= 32'h00000000;    //            nop
        memory[321] <= 32'h00000000;    //            nop
        memory[322] <= 32'h00000000;    //            nop
        memory[323] <= 32'h00000000;    //            nop
        memory[324] <= 32'h3402000a;    //            ori    $v0, $zero, 10
        memory[325] <= 32'h00000000;    //            nop
        memory[326] <= 32'h00000000;    //            nop
        memory[327] <= 32'h00000000;    //            nop
        memory[328] <= 32'h00000000;    //            nop
        memory[329] <= 32'h00000000;    //            nop
        memory[330] <= 32'h00000000;    //            nop
        memory[331] <= 32'h00000000;    //            nop
        memory[332] <= 32'h00000000;    //            nop
        memory[333] <= 32'h00000000;    //            nop
        memory[334] <= 32'h00000000;    //            nop
        memory[335] <= 32'h00000000;    //            nop
*/


/*
        //Phase one set of instructions that pass :) 
        memory[0] = 32'h20100001;	//	main:	addi	$s0, $zero, 1
        memory[1] = 32'h00000000;    //        nop
        memory[2] = 32'h00000000;    //        nop
        memory[3] = 32'h00000000;    //        nop
        memory[4] = 32'h00000000;    //        nop
        memory[5] = 32'h00000000;    //        nop
        memory[6] = 32'h20110001;    //        addi    $s1, $zero, 1
        memory[7] = 32'h00000000;    //        nop
        memory[8] = 32'h00000000;    //        nop
        memory[9] = 32'h00000000;    //        nop
        memory[10] = 32'h00000000;    //        nop
        memory[11] = 32'h00000000;    //        nop
        memory[12] = 32'h02118024;    //        and    $s0, $s0, $s1
        memory[13] = 32'h00000000;    //        nop
        memory[14] = 32'h00000000;    //        nop
        memory[15] = 32'h00000000;    //        nop
        memory[16] = 32'h00000000;    //        nop
        memory[17] = 32'h00000000;    //        nop
        memory[18] = 32'h02008024;    //        and    $s0, $s0, $zero
        memory[19] = 32'h00000000;    //        nop
        memory[20] = 32'h00000000;    //        nop
        memory[21] = 32'h00000000;    //        nop
        memory[22] = 32'h00000000;    //        nop
        memory[23] = 32'h00000000;    //        nop
        memory[24] = 32'h02308022;    //        sub    $s0, $s1, $s0
        memory[25] = 32'h00000000;    //        nop
        memory[26] = 32'h00000000;    //        nop
        memory[27] = 32'h00000000;    //        nop
        memory[28] = 32'h00000000;    //        nop
        memory[29] = 32'h00000000;    //        nop
        memory[30] = 32'h02008027;    //        nor    $s0, $s0, $zero
        memory[31] = 32'h00000000;    //        nop
        memory[32] = 32'h00000000;    //        nop
        memory[33] = 32'h00000000;    //        nop
        memory[34] = 32'h00000000;    //        nop
        memory[35] = 32'h00000000;    //        nop
        memory[36] = 32'h02008027;    //        nor    $s0, $s0, $zero
        memory[37] = 32'h00000000;    //        nop
        memory[38] = 32'h00000000;    //        nop
        memory[39] = 32'h00000000;    //        nop
        memory[40] = 32'h00000000;    //        nop
        memory[41] = 32'h00000000;    //        nop
        memory[42] = 32'h00008025;    //        or    $s0, $zero, $zero
        memory[43] = 32'h00000000;    //        nop
        memory[44] = 32'h00000000;    //        nop
        memory[45] = 32'h00000000;    //        nop
        memory[46] = 32'h00000000;    //        nop
        memory[47] = 32'h00000000;    //        nop
        memory[48] = 32'h02208025;    //        or    $s0, $s1, $zero
        memory[49] = 32'h00000000;    //        nop
        memory[50] = 32'h00000000;    //        nop
        memory[51] = 32'h00000000;    //        nop
        memory[52] = 32'h00000000;    //        nop
        memory[53] = 32'h00000000;    //        nop
        memory[54] = 32'h00108080;    //        sll    $s0, $s0, 2
        memory[55] = 32'h00000000;    //        nop
        memory[56] = 32'h00000000;    //        nop
        memory[57] = 32'h00000000;    //        nop
        memory[58] = 32'h00000000;    //        nop
        memory[59] = 32'h00000000;    //        nop
        memory[60] = 32'h02308004;    //        sllv    $s0, $s0, $s1
        memory[61] = 32'h00000000;    //        nop
        memory[62] = 32'h00000000;    //        nop
        memory[63] = 32'h00000000;    //        nop
        memory[64] = 32'h00000000;    //        nop
        memory[65] = 32'h00000000;    //        nop
        memory[66] = 32'h0200802a;    //        slt    $s0, $s0, $zero
        memory[67] = 32'h00000000;    //        nop
        memory[68] = 32'h00000000;    //        nop
        memory[69] = 32'h00000000;    //        nop
        memory[70] = 32'h00000000;    //        nop
        memory[71] = 32'h00000000;    //        nop
        memory[72] = 32'h0211802a;    //        slt    $s0, $s0, $s1
        memory[73] = 32'h00000000;    //        nop
        memory[74] = 32'h00000000;    //        nop
        memory[75] = 32'h00000000;    //        nop
        memory[76] = 32'h00000000;    //        nop
        memory[77] = 32'h00000000;    //        nop
        memory[78] = 32'h00118043;    //        sra    $s0, $s1, 1
        memory[79] = 32'h00000000;    //        nop
        memory[80] = 32'h00000000;    //        nop
        memory[81] = 32'h00000000;    //        nop
        memory[82] = 32'h00000000;    //        nop
        memory[83] = 32'h00000000;    //        nop
        memory[84] = 32'h00118007;    //        srav    $s0, $s1, $zero
        memory[85] = 32'h00000000;    //        nop
        memory[86] = 32'h00000000;    //        nop
        memory[87] = 32'h00000000;    //        nop
        memory[88] = 32'h00000000;    //        nop
        memory[89] = 32'h00000000;    //        nop
        memory[90] = 32'h00118042;    //        srl    $s0, $s1, 1
        memory[91] = 32'h00000000;    //        nop
        memory[92] = 32'h00000000;    //        nop
        memory[93] = 32'h00000000;    //        nop
        memory[94] = 32'h00000000;    //        nop
        memory[95] = 32'h00000000;    //        nop
        memory[96] = 32'h001180c0;    //        sll    $s0, $s1, 3
        memory[97] = 32'h00000000;    //        nop
        memory[98] = 32'h00000000;    //        nop
        memory[99] = 32'h00000000;    //        nop
        memory[100] = 32'h00000000;    //        nop
        memory[101] = 32'h00000000;    //        nop
        memory[102] = 32'h001080c2;    //        srl    $s0, $s0, 3
        memory[103] = 32'h00000000;    //        nop
        memory[104] = 32'h00000000;    //        nop
        memory[105] = 32'h00000000;    //        nop
        memory[106] = 32'h00000000;    //        nop
        memory[107] = 32'h00000000;    //        nop
        memory[108] = 32'h02308004;    //        sllv    $s0, $s0, $s1
        memory[109] = 32'h00000000;    //        nop
        memory[110] = 32'h00000000;    //        nop
        memory[111] = 32'h00000000;    //        nop
        memory[112] = 32'h00000000;    //        nop
        memory[113] = 32'h00000000;    //        nop
        memory[114] = 32'h02308006;    //        srlv    $s0, $s0, $s1
        memory[115] = 32'h00000000;    //        nop
        memory[116] = 32'h00000000;    //        nop
        memory[117] = 32'h00000000;    //        nop
        memory[118] = 32'h00000000;    //        nop
        memory[119] = 32'h00000000;    //        nop
        memory[120] = 32'h02118026;    //        xor    $s0, $s0, $s1
        memory[121] = 32'h00000000;    //        nop
        memory[122] = 32'h00000000;    //        nop
        memory[123] = 32'h00000000;    //        nop
        memory[124] = 32'h00000000;    //        nop
        memory[125] = 32'h00000000;    //        nop
        memory[126] = 32'h02118026;    //        xor    $s0, $s0, $s1
        memory[127] = 32'h00000000;    //        nop
        memory[128] = 32'h00000000;    //        nop
        memory[129] = 32'h00000000;    //        nop
        memory[130] = 32'h00000000;    //        nop
        memory[131] = 32'h00000000;    //        nop
        memory[132] = 32'h20120004;    //        addi    $s2, $zero, 4
        memory[133] = 32'h00000000;    //        nop
        memory[134] = 32'h00000000;    //        nop
        memory[135] = 32'h00000000;    //        nop
        memory[136] = 32'h00000000;    //        nop
        memory[137] = 32'h00000000;    //        nop
        memory[138] = 32'h72128002;    //        mul    $s0, $s0, $s2
        memory[139] = 32'h00000000;    //        nop
        memory[140] = 32'h00000000;    //        nop
        memory[141] = 32'h00000000;    //        nop
        memory[142] = 32'h00000000;    //        nop
        memory[143] = 32'h00000000;    //        nop
        memory[144] = 32'h22100004;    //        addi    $s0, $s0, 4
        memory[145] = 32'h00000000;    //        nop
        memory[146] = 32'h00000000;    //        nop
        memory[147] = 32'h00000000;    //        nop
        memory[148] = 32'h00000000;    //        nop
        memory[149] = 32'h00000000;    //        nop
        memory[150] = 32'h32100000;    //        andi    $s0, $s0, 0
        memory[151] = 32'h00000000;    //        nop
        memory[152] = 32'h00000000;    //        nop
        memory[153] = 32'h00000000;    //        nop
        memory[154] = 32'h00000000;    //        nop
        memory[155] = 32'h00000000;    //        nop
        memory[156] = 32'h36100001;    //        ori    $s0, $s0, 1
        memory[157] = 32'h00000000;    //        nop
        memory[158] = 32'h00000000;    //        nop
        memory[159] = 32'h00000000;    //        nop
        memory[160] = 32'h00000000;    //        nop
        memory[161] = 32'h00000000;    //        nop
        memory[162] = 32'h2a100000;    //        slti    $s0, $s0, 0
        memory[163] = 32'h00000000;    //        nop
        memory[164] = 32'h00000000;    //        nop
        memory[165] = 32'h00000000;    //        nop
        memory[166] = 32'h00000000;    //        nop
        memory[167] = 32'h00000000;    //        nop
        memory[168] = 32'h2a100001;    //        slti    $s0, $s0, 1
        memory[169] = 32'h00000000;    //        nop
        memory[170] = 32'h00000000;    //        nop
        memory[171] = 32'h00000000;    //        nop
        memory[172] = 32'h00000000;    //        nop
        memory[173] = 32'h00000000;    //        nop
        memory[174] = 32'h3a100001;    //        xori    $s0, $s0, 1
        memory[175] = 32'h00000000;    //        nop
        memory[176] = 32'h00000000;    //        nop
        memory[177] = 32'h00000000;    //        nop
        memory[178] = 32'h00000000;    //        nop
        memory[179] = 32'h00000000;    //        nop
        memory[180] = 32'h3a100001;    //        xori    $s0, $s0, 1
        memory[181] = 32'h00000000;    //        nop
        memory[182] = 32'h00000000;    //        nop
        memory[183] = 32'h00000000;    //        nop
        memory[184] = 32'h00000000;    //        nop
        memory[185] = 32'h00000000;    //        nop
        memory[186] = 32'h2010fffe;    //        addi    $s0, $zero, -2
        memory[187] = 32'h00000000;    //        nop
        memory[188] = 32'h00000000;    //        nop
        memory[189] = 32'h00000000;    //        nop
        memory[190] = 32'h00000000;    //        nop
        memory[191] = 32'h00000000;    //        nop
        memory[192] = 32'h20110002;    //        addi    $s1, $zero, 2
        memory[193] = 32'h00000000;    //        nop
        memory[194] = 32'h00000000;    //        nop
        memory[195] = 32'h00000000;    //        nop
        memory[196] = 32'h00000000;    //        nop
        memory[197] = 32'h00000000;    //        nop
        memory[198] = 32'h0230902b;    //        sltu    $s2, $s1, $s0
        memory[199] = 32'h00000000;    //        nop
        memory[200] = 32'h00000000;    //        nop
        memory[201] = 32'h00000000;    //        nop
        memory[202] = 32'h00000000;    //        nop
        memory[203] = 32'h00000000;    //        nop
        memory[204] = 32'h2e30fffe;    //        sltiu    $s0, $s1, -2
        memory[205] = 32'h00000000;    //        nop
        memory[206] = 32'h00000000;    //        nop
        memory[207] = 32'h00000000;    //        nop
        memory[208] = 32'h00000000;    //        nop
        memory[209] = 32'h00000000;    //        nop
        memory[210] = 32'h0220800a;    //        movz    $s0, $s1, $zero
        memory[211] = 32'h00000000;    //        nop
        memory[212] = 32'h00000000;    //        nop
        memory[213] = 32'h00000000;    //        nop
        memory[214] = 32'h00000000;    //        nop
        memory[215] = 32'h00000000;    //        nop
        memory[216] = 32'h0011800b;    //        movn    $s0, $zero, $s1
        memory[217] = 32'h00000000;    //        nop
        memory[218] = 32'h00000000;    //        nop
        memory[219] = 32'h00000000;    //        nop
        memory[220] = 32'h00000000;    //        nop
        memory[221] = 32'h00000000;    //        nop
        memory[222] = 32'h02328020;    //        add    $s0, $s1, $s2
        memory[223] = 32'h00000000;    //        nop
        memory[224] = 32'h00000000;    //        nop
        memory[225] = 32'h00000000;    //        nop
        memory[226] = 32'h00000000;    //        nop
        memory[227] = 32'h00000000;    //        nop
        memory[228] = 32'h2010fffe;    //        addi    $s0, $zero, -2
        memory[229] = 32'h00000000;    //        nop
        memory[230] = 32'h00000000;    //        nop
        memory[231] = 32'h00000000;    //        nop
        memory[232] = 32'h00000000;    //        nop
        memory[233] = 32'h00000000;    //        nop
        memory[234] = 32'h02308821;    //        addu    $s1, $s1, $s0
        memory[235] = 32'h00000000;    //        nop
        memory[236] = 32'h00000000;    //        nop
        memory[237] = 32'h00000000;    //        nop
        memory[238] = 32'h00000000;    //        nop
        memory[239] = 32'h00000000;    //        nop
        memory[240] = 32'h2411ffff;    //        addiu    $s1, $zero, -1
        memory[241] = 32'h00000000;    //        nop
        memory[242] = 32'h00000000;    //        nop
        memory[243] = 32'h00000000;    //        nop
        memory[244] = 32'h00000000;    //        nop
        memory[245] = 32'h00000000;    //        nop
        memory[246] = 32'h20120020;    //        addi    $s2, $zero, 32
        memory[247] = 32'h00000000;    //        nop
        memory[248] = 32'h00000000;    //        nop
        memory[249] = 32'h00000000;    //        nop
        memory[250] = 32'h00000000;    //        nop
        memory[251] = 32'h00000000;    //        nop
        memory[252] = 32'h02320018;    //        mult    $s1, $s2
        memory[253] = 32'h00000000;    //        nop
        memory[254] = 32'h00000000;    //        nop
        memory[255] = 32'h00000000;    //        nop
        memory[256] = 32'h00000000;    //        nop
        memory[257] = 32'h00000000;    //        nop
        memory[258] = 32'h0000a010;    //        mfhi    $s4
        memory[259] = 32'h00000000;    //        nop
        memory[260] = 32'h00000000;    //        nop
        memory[261] = 32'h00000000;    //        nop
        memory[262] = 32'h00000000;    //        nop
        memory[263] = 32'h00000000;    //        nop
        memory[264] = 32'h0000a812;    //        mflo    $s5
        memory[265] = 32'h00000000;    //        nop
        memory[266] = 32'h00000000;    //        nop
        memory[267] = 32'h00000000;    //        nop
        memory[268] = 32'h00000000;    //        nop
        memory[269] = 32'h00000000;    //        nop
        memory[270] = 32'h02320019;    //        multu    $s1, $s2
        memory[271] = 32'h00000000;    //        nop
        memory[272] = 32'h00000000;    //        nop
        memory[273] = 32'h00000000;    //        nop
        memory[274] = 32'h00000000;    //        nop
        memory[275] = 32'h00000000;    //        nop
        memory[276] = 32'h0000a010;    //        mfhi    $s4
        memory[277] = 32'h00000000;    //        nop
        memory[278] = 32'h00000000;    //        nop
        memory[279] = 32'h00000000;    //        nop
        memory[280] = 32'h00000000;    //        nop
        memory[281] = 32'h00000000;    //        nop
        memory[282] = 32'h0000a812;    //        mflo    $s5
        memory[283] = 32'h00000000;    //        nop
        memory[284] = 32'h00000000;    //        nop
        memory[285] = 32'h00000000;    //        nop
        memory[286] = 32'h00000000;    //        nop
        memory[287] = 32'h00000000;    //        nop
        memory[288] = 32'h72320000;    //        madd    $s1, $s2
        memory[289] = 32'h00000000;    //        nop
        memory[290] = 32'h00000000;    //        nop
        memory[291] = 32'h00000000;    //        nop
        memory[292] = 32'h00000000;    //        nop
        memory[293] = 32'h00000000;    //        nop
        memory[294] = 32'h0000a010;    //        mfhi    $s4
        memory[295] = 32'h00000000;    //        nop
        memory[296] = 32'h00000000;    //        nop
        memory[297] = 32'h00000000;    //        nop
        memory[298] = 32'h00000000;    //        nop
        memory[299] = 32'h00000000;    //        nop
        memory[300] = 32'h0000a812;    //        mflo    $s5
        memory[301] = 32'h00000000;    //        nop
        memory[302] = 32'h00000000;    //        nop
        memory[303] = 32'h00000000;    //        nop
        memory[304] = 32'h00000000;    //        nop
        memory[305] = 32'h00000000;    //        nop
        memory[306] = 32'h02400011;    //        mthi    $s2
        memory[307] = 32'h00000000;    //        nop
        memory[308] = 32'h00000000;    //        nop
        memory[309] = 32'h00000000;    //        nop
        memory[310] = 32'h00000000;    //        nop
        memory[311] = 32'h00000000;    //        nop
        memory[312] = 32'h02200013;    //        mtlo    $s1
        memory[313] = 32'h00000000;    //        nop
        memory[314] = 32'h00000000;    //        nop
        memory[315] = 32'h00000000;    //        nop
        memory[316] = 32'h00000000;    //        nop
        memory[317] = 32'h00000000;    //        nop
        memory[318] = 32'h0000a010;    //        mfhi    $s4
        memory[319] = 32'h00000000;    //        nop
        memory[320] = 32'h00000000;    //        nop
        memory[321] = 32'h00000000;    //        nop
        memory[322] = 32'h00000000;    //        nop
        memory[323] = 32'h00000000;    //        nop
        memory[324] = 32'h0000a812;    //        mflo    $s5
        memory[325] = 32'h00000000;    //        nop
        memory[326] = 32'h00000000;    //        nop
        memory[327] = 32'h00000000;    //        nop
        memory[328] = 32'h00000000;    //        nop
        memory[329] = 32'h00000000;    //        nop
        memory[330] = 32'h3231ffff;    //        andi    $s1, , $s1, 65535
        memory[331] = 32'h00000000;    //        nop
        memory[332] = 32'h00000000;    //        nop
        memory[333] = 32'h00000000;    //        nop
        memory[334] = 32'h00000000;    //        nop
        memory[335] = 32'h00000000;    //        nop
        memory[336] = 32'h72920004;    //        msub    $s4, , $s2
        memory[337] = 32'h00000000;    //        nop
        memory[338] = 32'h00000000;    //        nop
        memory[339] = 32'h00000000;    //        nop
        memory[340] = 32'h00000000;    //        nop
        memory[341] = 32'h00000000;    //        nop
        memory[342] = 32'h0000a010;    //        mfhi    $s4
        memory[343] = 32'h00000000;    //        nop
        memory[344] = 32'h00000000;    //        nop
        memory[345] = 32'h00000000;    //        nop
        memory[346] = 32'h00000000;    //        nop
        memory[347] = 32'h00000000;    //        nop
        memory[348] = 32'h0000a812;    //        mflo    $s5
        memory[349] = 32'h00000000;    //        nop
        memory[350] = 32'h00000000;    //        nop
        memory[351] = 32'h00000000;    //        nop
        memory[352] = 32'h00000000;    //        nop
        memory[353] = 32'h00000000;    //        nop
        memory[354] = 32'h20120001;    //        addi    $s2, $zero, 1
        memory[355] = 32'h00000000;    //        nop
        memory[356] = 32'h00000000;    //        nop
        memory[357] = 32'h00000000;    //        nop
        memory[358] = 32'h00000000;    //        nop
        memory[359] = 32'h00000000;    //        nop
        memory[360] = 32'h00328fc2;    //        rotr    $s1, $s2, 31
        memory[361] = 32'h00000000;    //        nop
        memory[362] = 32'h00000000;    //        nop
        memory[363] = 32'h00000000;    //        nop
        memory[364] = 32'h00000000;    //        nop
        memory[365] = 32'h00000000;    //        nop
        memory[366] = 32'h2014001f;    //        addi    $s4, $zero, 31
        memory[367] = 32'h00000000;    //        nop
        memory[368] = 32'h00000000;    //        nop
        memory[369] = 32'h00000000;    //        nop
        memory[370] = 32'h00000000;    //        nop
        memory[371] = 32'h00000000;    //        nop
        memory[372] = 32'h02918846;    //        rotrv    $s1, $s1, $s4
        memory[373] = 32'h00000000;    //        nop
        memory[374] = 32'h00000000;    //        nop
        memory[375] = 32'h00000000;    //        nop
        memory[376] = 32'h00000000;    //        nop
        memory[377] = 32'h00000000;    //        nop
        memory[378] = 32'h34110ff0;    //        ori    $s1, , $zero, 4080
        memory[379] = 32'h00000000;    //        nop
        memory[380] = 32'h00000000;    //        nop
        memory[381] = 32'h00000000;    //        nop
        memory[382] = 32'h00000000;    //        nop
        memory[383] = 32'h00000000;    //        nop
        memory[384] = 32'h7c11a420;    //        seb    $s4, $s1
        memory[385] = 32'h00000000;    //        nop
        memory[386] = 32'h00000000;    //        nop
        memory[387] = 32'h00000000;    //        nop
        memory[388] = 32'h00000000;    //        nop
        memory[389] = 32'h00000000;    //        nop
        memory[390] = 32'h7c11a620;    //        seh    $s4, , $s1
        memory[391] = 32'h00000000;    //        nop
        memory[392] = 32'h00000000;    //        nop
        memory[393] = 32'h00000000;    //        nop
        memory[394] = 32'h00000000;    //        nop
        memory[395] = 32'h00000000;    //        nop
     
*/





/*
                memory[0] = 32'h34070000;	//	main:		ori	$a3, $zero, 0
                memory[1] = 32'h8ce70000;    //            lw    $a3, 0($a3)
                memory[2] = 32'h34040004;    //            ori    $a0, $zero, 4
                memory[3] = 32'h34054004;    //            ori    $a1, $zero, 16388
                memory[4] = 32'h34068004;    //            ori    $a2, $zero, 32772
                memory[5] = 32'h34100000;    //            ori    $s0, $zero, 0
                memory[6] = 32'h34110000;    //    L1:        ori    $s1, $zero, 0
                memory[7] = 32'h34120000;    //    L2:        ori    $s2, $zero, 0
                memory[8] = 32'h34160000;    //            ori    $s6, $zero, 0
                memory[9] = 32'h36f70000;    //            ori    $s7, $s7, 0
                memory[10] = 32'h72074002;    //    inner:        mul    $t0, $s0, $a3
                memory[11] = 32'h01124820;    //            add    $t1, $t0, $s2
                memory[12] = 32'h00094880;    //            sll    $t1, $t1, 2
                memory[13] = 32'h00895020;    //            add    $t2, $a0, $t1
                memory[14] = 32'h8d530000;    //            lw    $s3, 0($t2)
                memory[15] = 32'h72474002;    //            mul    $t0, $s2, $a3
                memory[16] = 32'h01114820;    //            add    $t1, $t0, $s1
                memory[17] = 32'h00094880;    //            sll    $t1, $t1, 2
                memory[18] = 32'h01255020;    //            add    $t2, $t1, $a1
                memory[19] = 32'h8d540000;    //            lw    $s4, 0($t2)
                memory[20] = 32'h7274a802;    //            mul    $s5, $s3, $s4
                memory[21] = 32'h02d5b020;    //            add    $s6, $s6, $s5
                memory[22] = 32'h22520001;    //            addi    $s2, $s2, 1
                memory[23] = 32'h1647fff2;    //            bne    $s2, $a3, inner
                memory[24] = 32'h72074002;    //            mul    $t0, $s0, $a3
                memory[25] = 32'h01114820;    //            add    $t1, $t0, $s1
                memory[26] = 32'h00094880;    //            sll    $t1, $t1, 2
                memory[27] = 32'h01265020;    //            add    $t2, $t1, $a2
                memory[28] = 32'had560000;    //            sw    $s6, 0($t2)
                memory[29] = 32'h02c0b825;    //            or    $s7, $s6, $zero
                memory[30] = 32'h22310001;    //            addi    $s1, $s1, 1
                memory[31] = 32'h1627ffe7;    //            bne    $s1, $a3, L2
                memory[32] = 32'h22100001;    //            addi    $s0, $s0, 1
                memory[33] = 32'h1607ffe4;    //            bne    $s0, $a3, L1
                memory[34] = 32'h34100001;    //            ori    $s0, $zero, 1
                memory[35] = 32'h34110002;    //            ori    $s1, $zero, 2
                memory[36] = 32'h1611ffff;    //    endhere1:    bne    $s0, $s1, endhere1
                memory[36] = 32'h00000000;    //    
 */ 

         /*       
            memory[0] = 32'h2010000e;    //  main:   addi   $s0, $zero, 14                  #so = RegFile[16] = 14  (0+14)
            memory[1] = 32'h2011000f;    //        addi    $s1, $zero, 15               #s1 = RegFile[17] = 15  (0+15)
            memory[2] = 32'h2012001d;    //        addi    $s2, $zero, 29               #s2 = RegFile[18] = 29  (0+29)
            memory[3] = 32'h2013fff1;    //        addi    $s3, $zero, -15              #s3 = RegFile[19] = -15 (0+-15)
            memory[4] = 32'h02324020;    //        add     $t0, $s1, $s2                #t0 = RegFile[8] = 44  (15+29)
            memory[5] = 32'h02504024;    //        and     $t0, $s2, $s0                #t0 = 12  (29 AND 14 => 11101 AND 01110 = 01100 = 12)
            memory[6] = 32'h72114002;    //        mul     $t0, $s0, $s1                #t0 = 210 (14*15)
            memory[7] = 32'h02504025;    //        or      $t0, $s2, $s0                #t0 = 31  (29 OR 14 => 11101 OR 01110 = 11111 = 31) 
            memory[8] = 32'h36080010;    //        ori     $t0, $s0, 16                 #t0 = 30  (14 OR 16 = 01110 OR 10000 = 11110 = 30)
            memory[9] = 32'h02124022;    //        sub     $t0, $s0, $s2                #t0 = -15 (14-29)  
            memory[10] = 32'h72604021;    //        clo    $t0, $s3                     #t0 = 28  (count leading 1 of s3 = -15 =  1111 1111 1111 1111 1111 1111 1111 0001)
            memory[11] = 32'h72404020;    //        clz    $t0, $s2                     #t0 = 27  (count leading 0 of s2 = 29 = 0000 0000 0000 0000 0000 0000 0001 1101)
            memory[12] = 32'h0211402a;    //        slt    $t0, $s0, $s1                #t0 = 1
            memory[13] = 32'h0230402a;    //        slt    $t0, $s1, $s0                #t0 = 0
            memory[14] = 32'h00114080;    //        sll    $t0, $s1, 2                  #t0 = 60  (15*4)
            memory[15] = 32'h001240c2;    //        srl    $t0, $s2, 3                  #t0 = 3   (29/8)
*/
        end
        
        always @ * begin
            Instruction <= memory[Address[16:2]];    
        end
        
        assign InstructionDebug = Instruction; 
        
    endmodule
