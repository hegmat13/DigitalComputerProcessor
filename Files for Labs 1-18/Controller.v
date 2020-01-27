`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2018 02:45:06 PM
// Design Name: 
// Module Name: Controller
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
 
module Controller(Opcode, func, Bits10to6, Bits25to21, Bits20to16, RegDst, RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, PCSrc, MyCtl1, RTtoRS, ALUOp, ReadH, ReadL, RegWriteH, RegWriteL, HiLoInput, OutputToWriteData, Op, AndI, CompareOp, MemData, ReadDMMux, Jump, link, Type, Clk, Rst);
    input [5:0] Opcode, func;
    input [4:0] Bits10to6, Bits25to21, Bits20to16;
    input Clk, Rst;
    output reg RegWrite, MemRead, MemWrite, MemtoReg, PCSrc, MyCtl1, RTtoRS, RegDst, ReadH, ReadL, RegWriteH, RegWriteL, AndI, link; //CHANGE
    output reg [1:0] ALUSrc, HiLoInput, OutputToWriteData, Op, MemData, ReadDMMux, Jump; 
    output reg [2:0] CompareOp; 
    (* mark_debug = "true" *) output reg [3:0] Type; 
    output reg [5:0] ALUOp;
    
    always@(Opcode, func) begin
    
    //R-type Instructions 
    if (Opcode == 6'b000000) begin
        if(func == 6'b100000) begin     //add
            RegDst <= 1;
            RegWrite <= 1;
            ALUSrc <= 0;
            ALUOp <= 6'd0;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
            PCSrc <= 0;
            MyCtl1 <= 0;
            RTtoRS <= 0;
            ReadH <= 0; 
            ReadL <= 0; 
            RegWriteH <= 0; 
            RegWriteL <= 0; 
            HiLoInput <= 0; 
            OutputToWriteData <= 0; 
            Op <= 0; 
            AndI <= 0; 
            MemData <= 0; 
            ReadDMMux <= 0; 
            CompareOp <= 0; 
            Jump <= 0; 
            link <= 0; 
            Type <= 0; 
        end
        else if(func == 6'b100010) begin    //sub
            RegDst <= 1;
            RegWrite <= 1;
            ALUSrc <= 0;
            ALUOp <= 6'd1;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
            PCSrc <= 0;
            MyCtl1 <= 0;
            RTtoRS <= 0; 
            ReadH <= 0; 
            ReadL <= 0;
            RegWriteH <= 0; 
            RegWriteL <= 0;
            HiLoInput <= 0; 
            OutputToWriteData <= 0;  
            Op <= 0; 
            AndI <= 0; 
            MemData <= 0; 
            ReadDMMux <= 0; 
            CompareOp <= 0; 
            Jump <= 0; 
            link <= 0; 
            Type <= 0; 
        end        
        else if(func == 6'b100100) begin  //and
            RegDst <= 1;
            RegWrite <= 1;
            ALUSrc <= 0;
            ALUOp <= 6'd3;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
            PCSrc <= 0;
            MyCtl1 <= 0;
            RTtoRS <= 0;
            ReadH <= 0; 
            ReadL <= 0;
            RegWriteH <= 0; 
            RegWriteL <= 0; 
            HiLoInput <= 0; 
            OutputToWriteData <= 0;     
            Op <= 0;     
            AndI <= 0;     
            MemData <= 0; 
            ReadDMMux <= 0; 
            CompareOp <= 0; 
            Jump <= 0; 
            link <= 0; 
            Type <= 0; 
        end        
        else if(func == 6'b100101) begin  //or
            RegDst <= 1;
            RegWrite <= 1;
            ALUSrc <= 0;
            ALUOp <= 6'd4;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
            PCSrc <= 0;
            MyCtl1 <= 0;
            RTtoRS <= 0;
            ReadH <= 0; 
            ReadL <= 0; 
            RegWriteH <= 0; 
            RegWriteL <= 0; 
            HiLoInput <= 0; 
            OutputToWriteData <= 0;    
            Op <= 0; 
            AndI <= 0;     
            MemData <= 0;    
            ReadDMMux <= 0;   
            CompareOp <= 0;  
            Jump <= 0; 
            link <= 0; 
            Type <= 0; 
        end
        else if(func == 6'b101010) begin  //slt
            RegDst <= 1;
            RegWrite <= 1;
            ALUSrc <= 0;
            ALUOp <= 6'd5;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
            PCSrc <= 0;
            MyCtl1 <= 0;
            RTtoRS <= 0;
            ReadH <= 0; 
            ReadL <= 0;
            RegWriteH <= 0; 
            RegWriteL <= 0; 
            HiLoInput <= 0; 
            OutputToWriteData <= 0;   
            Op <= 0;  
            AndI <= 0;    
            MemData <= 0;    
            ReadDMMux <= 0;    
            CompareOp <= 0;  
            Jump <= 0; 
            link <= 0; 
            Type <= 0; 
        end            
        else if(func == 6'b101011) begin  //sltu
            RegDst <= 1;
            RegWrite <= 1;
            ALUSrc <= 0;
            ALUOp <= 6'd5;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
            PCSrc <= 0;
            MyCtl1 <= 0;
            RTtoRS <= 0;
            ReadH <= 0; 
            ReadL <= 0;
            RegWriteH <= 0; 
            RegWriteL <= 0; 
            HiLoInput <= 0; 
            OutputToWriteData <= 0;
            Op <= 0;     
            AndI <= 0;     
            MemData <= 0;    
            ReadDMMux <= 0;    
            CompareOp <= 0; 
            Jump <= 0; 
            link <= 0; 
            Type <= 0; 
        end       
        else if(func == 6'b000000) begin  //sll
            RegDst <= 1;
            RegWrite <= 1;
            ALUSrc <= 0; 
            ALUOp <= 6'd8;  
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
            PCSrc <= 0; 
            MyCtl1 <= 1;
            RTtoRS <= 1; 
            ReadH <= 0; 
            ReadL <= 0;
            RegWriteH <= 0; 
            RegWriteL <= 0; 
            HiLoInput <= 0; 
            OutputToWriteData <= 0; 
            Op <= 0;   
            AndI <= 0;     
            MemData <= 0;     
            ReadDMMux <= 0;    
            CompareOp <= 0; 
            Jump <= 0; 
            link <= 0; 
            Type <= 4; 
        end        
        else if(func == 6'b000100) begin  //sllv
            RegDst <= 1;
            RegWrite <= 1;
            ALUSrc <= 0;
            ALUOp <= 6'd8;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
            PCSrc <= 0;
            MyCtl1 <= 0;
            RTtoRS <= 1;
            ReadH <= 0; 
            ReadL <= 0;
            RegWriteH <= 0; 
            RegWriteL <= 0; 
            HiLoInput <= 0; 
            OutputToWriteData <= 0;   
            Op <= 0;  
            AndI <= 0;     
            MemData <= 0;  
            ReadDMMux <= 0;   
            CompareOp <= 0;    
            Jump <= 0; 
            link <= 0; 
            Type <= 1; 
        end 
        else if(func == 6'b000010) begin  
            if(Bits25to21 == 5'b00000) begin   //srl
            RegDst <= 1;
            RegWrite <= 1;
            ALUSrc <= 0;
            ALUOp <= 6'd9;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
            PCSrc <= 0;
            MyCtl1 <= 1;
            RTtoRS <= 1;
            ReadH <= 0; 
            ReadL <= 0; 
            RegWriteH <= 0; 
            RegWriteL <= 0;
            HiLoInput <= 0; 
            OutputToWriteData <= 0;    
            Op <= 0;       
            AndI <= 0;    
            MemData <= 0;  
            ReadDMMux <= 0; 
            CompareOp <= 0; 
            Jump <= 0; 
            link <= 0; 
            Type <= 4; 
        end        
           else if(Bits25to21 == 5'b00001) begin //rotr
           RegDst <= 1;
           RegWrite <= 1;
           ALUSrc <= 0;
           ALUOp <= 6'd10;
           MemRead <= 0;
           MemWrite <= 0;
           MemtoReg <= 0;
           PCSrc <= 0;
           MyCtl1 <= 1;
           RTtoRS <= 1; 
           ReadH <= 0; 
           ReadL <= 0; 
           RegWriteH <= 0; 
           RegWriteL <= 0; 
           HiLoInput <= 0; 
           OutputToWriteData <= 0; 
           Op <= 0;  
           AndI <= 0;     
           MemData <= 0;      
           ReadDMMux <= 0;   
           CompareOp <= 0; 
           Jump <= 0; 
           link <= 0; 
           Type <= 0;  //unsure
           end 
       end
        else if(func == 6'b000110) begin  
           if(Bits10to6 == 5'b00000) begin   //srlv
            RegDst <= 1;
            RegWrite <= 1;
            ALUSrc <= 0;
            ALUOp <= 6'd9;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
            PCSrc <= 0;
            MyCtl1 <= 0;
            RTtoRS <= 1;
            ReadH <= 0; 
            ReadL <= 0; 
            RegWriteH <= 0; 
            RegWriteL <= 0; 
            HiLoInput <= 0; 
            OutputToWriteData <= 0; 
            Op <= 0;   
            AndI <= 0;      
            MemData <= 0;    
            ReadDMMux <= 0;    
            CompareOp <= 0;
            Jump <= 0;  
            link <= 0; 
            Type <= 1; 
            end
        else if(Bits10to6 == 5'b00001) begin   //rotrv
                RegDst <= 1;
                RegWrite <= 1;
                ALUSrc <= 0;
                ALUOp <= 6'd10; 
                MemRead <= 0;
                MemWrite <= 0;
                MemtoReg <= 0;
                PCSrc <= 0;
                MyCtl1 <= 0;
                RTtoRS <= 1;
                ReadH <= 0; 
                ReadL <= 0;
                RegWriteH <= 0; 
                RegWriteL <= 0; 
                HiLoInput <= 0; 
                OutputToWriteData <= 0;   
                Op <= 0;   
                AndI <= 0;        
                MemData <= 0;   
                ReadDMMux <= 0; 
                CompareOp <= 0;    
                Jump <= 0;  
                link <= 0; 
                Type <= 1; 
            end       
        end        
        else if(func == 6'b000011) begin  //sra
            RegDst <= 1;
            RegWrite <= 1;
            ALUSrc <= 0;
            ALUOp <= 6'd17;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
            PCSrc <= 0;
            MyCtl1 <= 1;
            RTtoRS <= 1;
            ReadH <= 0; 
            ReadL <= 0;
            RegWriteH <= 0; 
            RegWriteL <= 0; 
            HiLoInput <= 0; 
            OutputToWriteData <= 0;    
            Op <= 0;      
            AndI <= 0;     
            MemData <= 0;  
            ReadDMMux <= 0; 
            CompareOp <= 0; 
            Jump <= 0;
            link <= 0;  
            Type <= 4; 
        end        
        else if(func == 6'b000111) begin  //srav
            RegDst <= 1;
            RegWrite <= 1;
            ALUSrc <= 0;
            ALUOp <= 6'd17;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
            PCSrc <= 0;
            MyCtl1 <= 0;
            RTtoRS <= 1;
            ReadH <= 0; 
            ReadL <= 0; 
            RegWriteH <= 0; 
            RegWriteL <= 0;
            HiLoInput <= 0; 
            OutputToWriteData <= 0;     
            Op <= 0;         
            AndI <= 0;   
            MemData <= 0; 
            ReadDMMux <= 0; 
            CompareOp <= 0; 
            Jump <= 0; 
            link <= 0; 
            Type <= 1; 
        end
        else if(func == 6'b100001) begin  //addu
            RegDst <= 1;
            RegWrite <= 1;
            ALUSrc <= 0;
            ALUOp <= 6'd11;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
            PCSrc <= 0;
            MyCtl1 <= 0;
            RTtoRS <= 0;
            ReadH <= 0; 
            ReadL <= 0;
            RegWriteH <= 0; 
            RegWriteL <= 0;
            HiLoInput <= 0; 
            OutputToWriteData <= 0;  
            Op <= 0;     
            AndI <= 0;     
            MemData <= 0;  
            ReadDMMux <= 0;  
            CompareOp <= 0;    
            Jump <= 0; 
            link <= 0; 
            Type <= 0; 
        end       
        else if(func == 6'b100111) begin  //nor
            RegDst <= 1;
            RegWrite <= 1;
            ALUSrc <= 0;
            ALUOp <= 6'd13;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
            PCSrc <= 0;
            MyCtl1 <= 0;
            RTtoRS <= 0; 
            ReadH <= 0; 
            ReadL <= 0;
            RegWriteH <= 0; 
            RegWriteL <= 0; 
            HiLoInput <= 0; 
            OutputToWriteData <= 0;     
            Op <= 0;   
            AndI <= 0;   
            MemData <= 0;   
            ReadDMMux <= 0;    
            CompareOp <= 0; 
            Jump <= 0; 
            link <= 0; 
            Type <= 0; 
        end        
        else if(func == 6'b100110) begin //xor
            RegDst <= 1;
            RegWrite <= 1;
            ALUSrc <= 0;
            ALUOp <= 6'd14;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
            PCSrc <= 0;
            MyCtl1 <= 0;
            RTtoRS <= 0;
            ReadH <= 0; 
            ReadL <= 0;
            RegWriteH <= 0; 
            RegWriteL <= 0; 
            HiLoInput <= 0; 
            OutputToWriteData <= 0; 
            Op <= 0;   
            AndI <= 0;   
            MemData <= 0;       
            ReadDMMux <= 0;   
            CompareOp <= 0;  
            Jump <= 0; 
            link <= 0; 
            Type <= 0; 
        end        
        else if(func == 6'b001010) begin //movz
            RegDst <= 1;
            RegWrite <= 1;
            ALUSrc <= 0;
            ALUOp <= 6'd16;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
            PCSrc <= 0;
            MyCtl1 <= 0;
            RTtoRS <= 0; 
            ReadH <= 0; 
            ReadL <= 0;
            RegWriteH <= 0; 
            RegWriteL <= 0;
            HiLoInput <= 0; 
            OutputToWriteData <= 0;  
            Op <= 0;    
            AndI <= 0;    
            MemData <= 0;    
            ReadDMMux <= 0; 
            CompareOp <= 0;   
            Jump <= 0;   
            link <= 0; 
            Type <= 0; 
        end        
        else if(func == 6'b001011) begin //movn
            RegDst <= 1;
            RegWrite <= 1;
            ALUSrc <= 0;
            ALUOp <= 6'd18;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
            PCSrc <= 0;
            MyCtl1 <= 0;
            RTtoRS <= 0; 
            ReadH <= 0; 
            ReadL <= 0;
            RegWriteH <= 0; 
            RegWriteL <= 0;
            HiLoInput <= 0; 
            OutputToWriteData <= 0;  
            Op <= 0;       
            AndI <= 0;     
            MemData <= 0;    
            ReadDMMux <= 0; 
            CompareOp <= 0; 
            Jump <= 0; 
            link <= 0; 
            Type <= 0; 
        end        
        else if(func == 6'b011000) begin //mult
            RegDst <= 0;
            RegWrite <= 0;
            ALUSrc <= 0;
            ALUOp <= 6'd19;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
            PCSrc <= 0;
            MyCtl1 <= 0;
            RTtoRS <= 0; 
            ReadH <= 0; 
            ReadL <= 0;
            RegWriteH <= 1; 
            RegWriteL <= 1; 
            HiLoInput <= 0; 
            OutputToWriteData <= 0;    
            Op <= 0;     
            AndI <= 0;       
            MemData <= 0; 
            ReadDMMux <= 0; 
            CompareOp <= 0; 
            Jump <= 0; 
            link <= 0; 
            Type <= 5; 
        end        
        else if(func == 6'b011001) begin //multu
            RegDst <= 0;
            RegWrite <= 0;
            ALUSrc <= 0;
            ALUOp <= 6'd20;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
            PCSrc <= 0;
            MyCtl1 <= 0;
            RTtoRS <= 0;  
            ReadH <= 0; 
            ReadL <= 0;
            RegWriteH <= 1; 
            RegWriteL <= 1; 
            HiLoInput <= 0; 
            OutputToWriteData <= 0;    
            Op <= 0;       
            AndI <= 0;     
            MemData <= 0; 
            ReadDMMux <= 0; 
            CompareOp <= 0; 
            Jump <= 0; 
            link <= 0; 
            Type <= 5; 
        end        
        else if(func == 6'b010001) begin //mthi
            RegDst <= 0;
            RegWrite <= 0;
            ALUSrc <= 0;
            ALUOp <= 6'd0;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
            PCSrc <= 0;
            MyCtl1 <= 0;
            RTtoRS <= 0; 
            ReadH <= 0; 
            ReadL <= 0;
            RegWriteH <= 1; 
            RegWriteL <= 0; 
            HiLoInput <= 1; 
            OutputToWriteData <= 0;    
            Op <= 0;     
            AndI <= 0;      
            MemData <= 0;  
            ReadDMMux <= 0; 
            CompareOp <= 0; 
            Jump <= 0; 
            link <= 0; 
            Type <= 8; 
        end        
        else if(func == 6'b010011) begin //mtlo
            RegDst <= 0;
            RegWrite <= 0;
            ALUSrc <= 0;
            ALUOp <= 6'd0;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
            PCSrc <= 0;
            MyCtl1 <= 0;
            RTtoRS <= 0; 
            ReadH <= 0; 
            ReadL <= 0;
            RegWriteH <= 0; 
            RegWriteL <= 1; 
            HiLoInput <= 2; 
            OutputToWriteData <= 0;  
            Op <= 0;    
            AndI <= 0;       
            MemData <= 0;   
            ReadDMMux <= 0;  
            CompareOp <= 0; 
            Jump <= 0; 
            link <= 0; 
            Type <= 8; 
        end              
        else if(func == 6'b010000) begin //mfhi
            RegDst <= 1;
            RegWrite <= 1;
            ALUSrc <= 0;
            ALUOp <= 6'd0;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
            PCSrc <= 0;
            MyCtl1 <= 0;
            RTtoRS <= 0; 
            ReadH <= 1; 
            ReadL <= 0; 
            RegWriteH <= 0; 
            RegWriteL <= 0; 
            HiLoInput <= 0; 
            OutputToWriteData <= 1; 
            Op <= 0;      
            AndI <= 0;       
            MemData <= 0;   
            ReadDMMux <= 0; 
            CompareOp <= 0; 
            Jump <= 0; 
            link <= 0; 
            Type <= 9; 
        end            
        else if(func == 6'b010010) begin //mflo
            RegDst <= 1;
            RegWrite <= 1;
            ALUSrc <= 0;
            ALUOp <= 6'd0;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
            PCSrc <= 0;
            MyCtl1 <= 0;
            RTtoRS <= 0; 
            ReadH <= 0; 
            ReadL <= 1; 
            RegWriteH <= 0; 
            RegWriteL <= 0; 
            HiLoInput <= 0; 
            OutputToWriteData <= 2;    
            Op <= 0;     
            AndI <= 0;      
            MemData <= 0;  
            ReadDMMux <= 0; 
            CompareOp <= 0; 
            Jump <= 0; 
            link <= 0; 
            Type <= 9; 
        end               
         else if(func == 6'b001000) begin //jr
            RegDst <= 0;
            RegWrite <= 0;
            ALUSrc <= 0;
            ALUOp <= 6'd0;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
            PCSrc <= 0;
            MyCtl1 <= 0;
            RTtoRS <= 0; 
            ReadH <= 0; 
            ReadL <= 0; 
            RegWriteH <= 0; 
            RegWriteL <= 0; 
            HiLoInput <= 0; 
            OutputToWriteData <= 0;    
            Op <= 0;     
            AndI <= 0;      
            MemData <= 0;  
            ReadDMMux <= 0; 
            CompareOp <= 0; 
            Jump <= 2; 
            link <= 0; 
            Type <= 8; 
        end        
        else begin       //nop
        RegDst <= 0;
        RegWrite <= 0;
        ALUSrc <= 0;
        ALUOp <= 6'd0;
        MemRead <= 0;
        MemWrite <= 0;
        MemtoReg <= 0;
        PCSrc <= 0;
        MyCtl1 <= 0;
        RTtoRS <= 0;
        ReadH <= 0; 
        ReadL <= 0;
        RegWriteH <= 0; 
        RegWriteL <= 0; 
        HiLoInput <= 0; 
        OutputToWriteData <= 0;        
        Op <= 0;  
        AndI <= 0;  
        MemData <= 0; 
        ReadDMMux <= 0; 
        CompareOp <= 0; 
        Jump <= 0; 
        link <= 0; 
        Type <= 13; 
        end 
        
    end
    else if (Opcode == 6'b011100) begin  
        if(func == 6'b100001) begin   //clo
            RegDst <= 1;
            RegWrite <= 1;
            ALUSrc <= 0;
            ALUOp <= 6'd11;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
            PCSrc <= 0;
            MyCtl1 <= 0;
            RTtoRS <= 0;
            ReadH <= 0; 
            ReadL <= 0;
            RegWriteH <= 0; 
            RegWriteL <= 0;
            HiLoInput <= 0; 
            OutputToWriteData <= 0;     
            Op <= 0;       
            AndI <= 0;     
            MemData <= 0; 
            ReadDMMux <= 0; 
            CompareOp <= 0; 
            Jump <= 0; 
            link <= 0; 
            Type <= 14; 
        end      
        else if(func == 6'b100000) begin //clz
            RegDst <= 1;
            RegWrite <= 1;
            ALUSrc <= 0;
            ALUOp <= 6'd12;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
            PCSrc <= 0;
            MyCtl1 <= 0;
            RTtoRS <= 0; 
            ReadH <= 0; 
            ReadL <= 0;
            RegWriteH <= 0; 
            RegWriteL <= 0;
            HiLoInput <= 0; 
            OutputToWriteData <= 0;    
            Op <= 0;      
            AndI <= 0;       
            MemData <= 0; 
            ReadDMMux <= 0; 
            CompareOp <= 0; 
            Jump <= 0; 
            link <= 0; 
            Type <= 14; 
        end   
        else if(func == 6'b000010) begin   //mul
            RegDst <= 1;
            RegWrite <= 1;
            ALUSrc <= 0;
            ALUOp <= 6'd2;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
            PCSrc <= 0;
            MyCtl1 <= 0;
            RTtoRS <= 0;
            ReadH <= 0; 
            ReadL <= 0;
            RegWriteH <= 0; 
            RegWriteL <= 0; 
            HiLoInput <= 0; 
            OutputToWriteData <= 0;    
            Op <= 0;       
            AndI <= 0;     
            MemData <= 0; 
            ReadDMMux <= 0; 
            CompareOp <= 0; 
            Jump <= 0; 
            link <= 0; 
            Type <= 0; 
        end         
        else if(func == 6'b000000) begin   //madd
            RegDst <= 0;
            RegWrite <= 0;
            ALUSrc <= 0;
            ALUOp <= 6'd19;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
            PCSrc <= 0;
            MyCtl1 <= 0;
            RTtoRS <= 0;
            ReadH <= 0; 
            ReadL <= 0; 
            RegWriteH <= 0; 
            RegWriteL <= 0; 
            HiLoInput <= 0; 
            OutputToWriteData <= 0;     
            Op <= 1;  
            AndI <= 0;       
            MemData <= 0;   
            ReadDMMux <= 0; 
            CompareOp <= 0; 
            Jump <= 0; 
            link <= 0; 
            Type <= 5; 
        end         
        else if(func == 6'b000100) begin   //msub
            RegDst <= 0;
            RegWrite <= 0;
            ALUSrc <= 0;
            ALUOp <= 6'd19;
            MemRead <= 0;
            MemWrite <= 0;
            MemtoReg <= 0;
            PCSrc <= 0;
            MyCtl1 <= 0;
            RTtoRS <= 0;
            ReadH <= 0; 
            ReadL <= 0; 
            RegWriteH <= 0; 
            RegWriteL <= 0; 
            HiLoInput <= 0; 
            OutputToWriteData <= 0;     
            Op <= 2;       
            AndI <= 0;    
            MemData <= 0; 
            ReadDMMux <= 0; 
            CompareOp <= 0; 
            Jump <= 0; 
            link <= 0; 
            Type <= 5; 
        end 
    end
      else if (Opcode == 6'b011111) begin
        if(func == 6'b100000) begin   
         if(Bits10to6 == 5'b11000) begin  //seh 
        RegDst <= 1;
        RegWrite <= 1;
        ALUSrc <= 2;
        ALUOp <= 6'd15;
        MemRead <= 0;
        MemWrite <= 0;
        MemtoReg <= 0;
        PCSrc <= 0;
        MyCtl1 <= 0;     
        RTtoRS <= 0;  
        ReadH <= 0; 
        ReadL <= 0; 
        RegWriteH <= 0; 
        RegWriteL <= 0;   
        HiLoInput <= 0; 
        OutputToWriteData <= 0;   
        Op <= 0;       
        AndI <= 0;  
        MemData <= 0; 
        ReadDMMux <= 0; 
        CompareOp <= 0; 
        Jump <= 0; 
        link <= 0; 
        Type <= 12; 
        end 
         else if(Bits10to6 == 5'b10000)begin //seb 
        RegDst <= 1;
        RegWrite <= 1;
        ALUSrc <= 3;
        ALUOp <= 6'd15;
        MemRead <= 0;
        MemWrite <= 0;
        MemtoReg <= 0;
        PCSrc <= 0;
        MyCtl1 <= 0;  
        RTtoRS <= 0;  
        ReadH <= 0; 
        ReadL <= 0; 
        RegWriteH <= 0; 
        RegWriteL <= 0; 
        HiLoInput <= 0; 
        OutputToWriteData <= 0;   
        Op <= 0;    
        AndI <= 0;      
        MemData <= 0; 
        ReadDMMux <= 0; 
        CompareOp <= 0; 
        Jump <= 0; 
        link <= 0; 
        Type <= 12; 
        end
       end      
     end 
  
    //I-type instructions 
    else if (Opcode == 6'b001000)begin   //addi
        RegDst <= 0;
        RegWrite <= 1;
        ALUSrc <= 1;
        ALUOp <= 6'd0; 
        MemRead <= 0;
        MemWrite <= 0;
        MemtoReg <= 0;
        PCSrc <= 0;
        MyCtl1 <= 0;
        RTtoRS <= 0;
        ReadH <= 0; 
        ReadL <= 0;
        RegWriteH <= 0; 
        RegWriteL <= 0; 
        HiLoInput <= 0; 
        OutputToWriteData <= 0; 
        Op <= 0;      
        AndI <= 0;     
        MemData <= 0; 
        ReadDMMux <= 0; 
        CompareOp <= 0; 
        Jump <= 0; 
        link <= 0; 
        Type <= 2; 
       // IDCompare <= 1; 
    end    else if (Opcode == 6'b001001)begin   //addiu
        RegDst <= 0;
        RegWrite <= 1;
        ALUSrc <= 1;
        ALUOp <= 6'd0;
        MemRead <= 0;
        MemWrite <= 0;
        MemtoReg <= 0;
        PCSrc <= 0;
        MyCtl1 <= 0;
        RTtoRS <= 0;
        ReadH <= 0; 
        ReadL <= 0;
        RegWriteH <= 0; 
        RegWriteL <= 0;
        HiLoInput <= 0; 
        OutputToWriteData <= 0;    
        Op <= 0;     
        AndI <= 0;    
        MemData <= 0; 
        ReadDMMux <= 0; 
        CompareOp <= 0; 
        Jump <= 0; 
        link <= 0; 
        Type <= 2; 
    end
    else if (Opcode == 6'b001101)begin    //ori 
        RegDst <= 0;
        RegWrite <= 1;
        ALUSrc <= 1;
        ALUOp <= 6'd4;
        MemRead <= 0;
        MemWrite <= 0;
        MemtoReg <= 0;
        PCSrc <= 0;
        MyCtl1 <= 0;
        RTtoRS <= 0;
        ReadH <= 0; 
        ReadL <= 0; 
        RegWriteH <= 0; 
        RegWriteL <= 0; 
        HiLoInput <= 0; 
        OutputToWriteData <= 0;     
        Op <= 0;     
        AndI <= 1;   
        MemData <= 0; 
        ReadDMMux <= 0; 
        CompareOp <= 0; 
        Jump <= 0; 
        link <= 0; 
        Type <= 2; 
    end    
    else if (Opcode == 6'b001110)begin    //xori 
        RegDst <= 0;
        RegWrite <= 1;
        ALUSrc <= 1;
        ALUOp <= 6'd14;
        MemRead <= 0;
        MemWrite <= 0;
        MemtoReg <= 0;
        PCSrc <= 0;
        MyCtl1 <= 0;
        RTtoRS <= 0; 
        ReadH <= 0; 
        ReadL <= 0;
        RegWriteH <= 0; 
        RegWriteL <= 0; 
        HiLoInput <= 0; 
        OutputToWriteData <= 0;     
        Op <= 0;     
        AndI <= 1;  
        MemData <= 0; 
        ReadDMMux <= 0; 
        CompareOp <= 0; 
        Jump <= 0; 
        link <= 0; 
        Type <= 2; 
    end
    // new lw
    else if (Opcode == 6'b100011)begin   //lw
        RegDst <= 0;
        RegWrite <= 1;
        ALUSrc <= 1;
        ALUOp <= 6'd0;
        MemRead <= 1;
        MemWrite <= 0;
        MemtoReg <= 1;
        PCSrc <= 0;
        MyCtl1 <= 0;
        RTtoRS <= 0; 
        ReadH <= 0; 
        ReadL <= 0; 
        RegWriteH <= 0; 
        RegWriteL <= 0; 
        HiLoInput <= 0; 
        OutputToWriteData <= 0;
        Op <= 0;          
        AndI <= 0;    
        MemData <= 0; 
        ReadDMMux <= 0; 
        CompareOp <= 0; 
        Jump <= 0; 
        link <= 0; 
        Type <= 6; 
    end
        else if (Opcode == 6'b100001)begin   //lh
        RegDst <= 0;
        RegWrite <= 1;
        ALUSrc <= 1;
        ALUOp <= 6'd0;
        MemRead <= 1;
        MemWrite <= 0;
        MemtoReg <= 1;
        PCSrc <= 0;
        MyCtl1 <= 0;
        RTtoRS <= 0; 
        ReadH <= 0; 
        ReadL <= 0; 
        RegWriteH <= 0; 
        RegWriteL <= 0; 
        HiLoInput <= 0;  
        OutputToWriteData <= 0;
        Op <= 0;          
        AndI <= 0;    
        MemData <= 0; 
        ReadDMMux <= 1;  
        CompareOp <= 0; 
        Jump <= 0; 
        link <= 0; 
        Type <= 6; 
    end        
    else if (Opcode == 6'b100000)begin   //lb
        RegDst <= 0;
        RegWrite <= 1;
        ALUSrc <= 1;
        ALUOp <= 6'd0;
        MemRead <= 1;
        MemWrite <= 0;
        MemtoReg <= 1;
        PCSrc <= 0;
        MyCtl1 <= 0;
        RTtoRS <= 0; 
        ReadH <= 0; 
        ReadL <= 0; 
        RegWriteH <= 0;  
        RegWriteL <= 0; 
        HiLoInput <= 0;  
        OutputToWriteData <= 0;
        Op <= 0;          
        AndI <= 0;    
        MemData <= 0; 
        ReadDMMux <= 2;  
        CompareOp <= 0; 
        Jump <= 0; 
        link <= 0; 
        Type <= 6; 
    end
    
    else if (Opcode == 6'b101011)begin  //sw
        RegDst <= 0;
        RegWrite <= 0;
        ALUSrc <= 1;
        ALUOp <= 6'd0;
        MemRead <= 0;
        MemWrite <= 1;
        MemtoReg <= 0;
        PCSrc <= 0;
        MyCtl1 <= 0;
        RTtoRS <= 0;   
        ReadH <= 0; 
        ReadL <= 0;
        RegWriteH <= 0; 
        RegWriteL <= 0;
        HiLoInput <= 0; 
        OutputToWriteData <= 0;   
        Op <= 0;        
        AndI <= 0;  
        MemData <= 0; 
        ReadDMMux <= 0; 
        CompareOp <= 0; 
        Jump <= 0; 
        link <= 0; 
        Type <= 6; 
    end
  else if (Opcode == 6'b101001)begin  //sh
        RegDst <= 0;
        RegWrite <= 0;
        ALUSrc <= 1;
        ALUOp <= 6'd0;
        MemRead <= 0;
        MemWrite <= 1;
        MemtoReg <= 0;
        PCSrc <= 0;
        MyCtl1 <= 0;
        RTtoRS <= 0;   
        ReadH <= 0; 
        ReadL <= 0;
        RegWriteH <= 0; 
        RegWriteL <= 0;
        HiLoInput <= 0; 
        OutputToWriteData <= 0;   
        Op <= 0;        
        AndI <= 0;  
        MemData <= 2; 
        ReadDMMux <= 0; 
        CompareOp <= 0; 
        Jump <= 0; 
        link <= 0; 
        Type <= 6; 
    end  
    else if (Opcode == 6'b101000)begin  //sb
        RegDst <= 0;
        RegWrite <= 0;
        ALUSrc <= 1;
        ALUOp <= 6'd0;
        MemRead <= 0;
        MemWrite <= 1;
        MemtoReg <= 0;
        PCSrc <= 0;
        MyCtl1 <= 0;
        RTtoRS <= 0;   
        ReadH <= 0; 
        ReadL <= 0;
        RegWriteH <= 0; 
        RegWriteL <= 0;
        HiLoInput <= 0; 
        OutputToWriteData <= 0;   
        Op <= 0;        
        AndI <= 0;  
        MemData <= 3; 
        ReadDMMux <= 0; 
        CompareOp <= 0; 
        Jump <= 0; 
        link <= 0; 
        Type <= 6; 
    end    
    else if (Opcode == 6'b000001)begin  //bgez
       if(Bits20to16 == 5'b00001) begin 
        RegDst <= 0;
        RegWrite <= 0;
        ALUSrc <= 0;
        ALUOp <= 6'd0;
        MemRead <= 0;
        MemWrite <= 0;
        MemtoReg <= 0;
        PCSrc <= 1;
        MyCtl1 <= 0;
        RTtoRS <= 0;   
        ReadH <= 0; 
        ReadL <= 0;
        RegWriteH <= 0; 
        RegWriteL <= 0;
        HiLoInput <= 0; 
        OutputToWriteData <= 0;   
        Op <= 0;        
        AndI <= 0;  
        MemData <= 0; 
        ReadDMMux <= 0; 
        CompareOp <= 1; 
        Jump <= 0; 
        link <= 0; 
        Type <= 7; 
        end        
        else if(Bits20to16 == 5'b00000) begin  //bltz
        RegDst <= 0;
        RegWrite <= 0;
        ALUSrc <= 0;
        ALUOp <= 6'd0;
        MemRead <= 0;
        MemWrite <= 0;
        MemtoReg <= 0;
        PCSrc <= 1;
        MyCtl1 <= 0;
        RTtoRS <= 0;   
        ReadH <= 0; 
        ReadL <= 0; 
        RegWriteH <= 0; 
        RegWriteL <= 0;
        HiLoInput <= 0; 
        OutputToWriteData <= 0;   
        Op <= 0;        
        AndI <= 0;  
        MemData <= 0; 
        ReadDMMux <= 0; 
        CompareOp <= 6; 
        Jump <= 0; 
        link <= 0; 
        Type <= 7; 
        end       
    end    
    else if (Opcode == 6'b000100)begin  //beq
        RegDst <= 0;
        RegWrite <= 0;
        ALUSrc <= 0;
        ALUOp <= 6'd0;
        MemRead <= 0;
        MemWrite <= 0;
        MemtoReg <= 0;
        PCSrc <= 1;
        MyCtl1 <= 0;
        RTtoRS <= 0;   
        ReadH <= 0; 
        ReadL <= 0;
        RegWriteH <= 0; 
        RegWriteL <= 0;
        HiLoInput <= 0; 
        OutputToWriteData <= 0;   
        Op <= 0;        
        AndI <= 0;  
        MemData <= 0; 
        ReadDMMux <= 0; 
        CompareOp <= 2; 
        Jump <= 0; 
        link <= 0; 
        Type <= 3; 
    end   
     else if (Opcode == 6'b000101)begin  //bne
        RegDst <= 0;
        RegWrite <= 0;
        ALUSrc <= 0;
        ALUOp <= 6'd0;
        MemRead <= 0;
        MemWrite <= 0;
        MemtoReg <= 0;
        PCSrc <= 1;
        MyCtl1 <= 0;
        RTtoRS <= 0;   
        ReadH <= 0; 
        ReadL <= 0;
        RegWriteH <= 0; 
        RegWriteL <= 0;
        HiLoInput <= 0; 
        OutputToWriteData <= 0;   
        Op <= 0;        
        AndI <= 0;  
        MemData <= 0; 
        ReadDMMux <= 0; 
        CompareOp <= 3; 
        Jump <= 0; 
        link <= 0; 
        Type <= 3; 
    end     
    else if (Opcode == 6'b000111)begin  //bgtz
      if(Bits20to16 == 5'b00000) begin 
        RegDst <= 0;
        RegWrite <= 0;
        ALUSrc <= 0;
        ALUOp <= 6'd0;
        MemRead <= 0;
        MemWrite <= 0;
        MemtoReg <= 0;
        PCSrc <= 1;
        MyCtl1 <= 0;
        RTtoRS <= 0;   
        ReadH <= 0; 
        ReadL <= 0;
        RegWriteH <= 0; 
        RegWriteL <= 0;
        HiLoInput <= 0; 
        OutputToWriteData <= 0;   
        Op <= 0;        
        AndI <= 0;  
        MemData <= 0; 
        ReadDMMux <= 0; 
        CompareOp <= 4; 
        Jump <= 0; 
        link <= 0; 
        Type <= 7; 
        end
    end    
    else if (Opcode == 6'b000110)begin  //blez
      if(Bits20to16 == 5'b00000) begin 
        RegDst <= 0;
        RegWrite <= 0;
        ALUSrc <= 0;
        ALUOp <= 6'd0;
        MemRead <= 0;
        MemWrite <= 0;
        MemtoReg <= 0;
        PCSrc <= 1;
        MyCtl1 <= 0;
        RTtoRS <= 0;   
        ReadH <= 0; 
        ReadL <= 0;
        RegWriteH <= 0; 
        RegWriteL <= 0;
        HiLoInput <= 0; 
        OutputToWriteData <= 0;   
        Op <= 0;        
        AndI <= 0;  
        MemData <= 0; 
        ReadDMMux <= 0; 
        CompareOp <= 5; 
        Jump <= 0; 
        link <= 0; 
        Type <= 7; 
        end
    end    
    else if (Opcode == 6'b001100) begin         //andi 
        RegDst <= 0;
        RegWrite <= 1;
        ALUSrc <= 1;
        ALUOp <= 6'd3;
        MemRead <= 0;
        MemWrite <= 0;
        MemtoReg <= 0;
        PCSrc <= 0;
        MyCtl1 <= 0;    
        RTtoRS <= 0;
        ReadH <= 0; 
        ReadL <= 0;
        RegWriteH <= 0; 
        RegWriteL <= 0; 
        HiLoInput <= 0; 
        OutputToWriteData <= 0;     
        Op <= 0;     
        AndI <= 1;  
        MemData <= 0; 
        ReadDMMux <= 0; 
        CompareOp <= 0; 
        Jump <= 0; 
        link <= 0; 
        Type <= 2; 
    end        
    else if (Opcode == 6'b001111) begin    //lui
        if (Bits25to21 == 5'b00000) begin         
        RegDst <= 0;
        RegWrite <= 1;
        ALUSrc <= 1; 
        ALUOp <= 6'd21; 
        MemRead <= 0;
        MemWrite <= 0;
        MemtoReg <= 0;
        PCSrc <= 0;
        MyCtl1 <= 0;    
        RTtoRS <= 0;
        ReadH <= 0; 
        ReadL <= 0;
        RegWriteH <= 0; 
        RegWriteL <= 0; 
        HiLoInput <= 0; 
        OutputToWriteData <= 0;     
        Op <= 0;     
        AndI <= 1;  
        MemData <= 0; 
        ReadDMMux <= 0; 
        CompareOp <= 0; 
        Jump <= 0; 
        link <= 0; 
        Type <= 11; 
        end 
    end    
    else if(Opcode == 6'b001010) begin  //slti
       RegDst <= 0;
       RegWrite <= 1;
       ALUSrc <= 1;
       ALUOp <= 6'd5;
       MemRead <= 0;
       MemWrite <= 0;
       MemtoReg <= 0;
       PCSrc <= 0;
       MyCtl1 <= 0;
       RTtoRS <= 0;
       ReadH <= 0; 
       ReadL <= 0; 
       RegWriteH <= 0; 
       RegWriteL <= 0;
       HiLoInput <= 0; 
       OutputToWriteData <= 0;   
       Op <= 0; 
       AndI <= 0;  
       MemData <= 0; 
       ReadDMMux <= 0; 
       CompareOp <= 0; 
       Jump <= 0; 
       link <= 0; 
       Type <= 2; 
   end    
   else if(Opcode == 6'b001011) begin  //sltiu
       RegDst <= 0;
       RegWrite <= 1;
       ALUSrc <= 1; 
       ALUOp <= 6'd5;
       MemRead <= 0;
       MemWrite <= 0;
       MemtoReg <= 0;
       PCSrc <= 0;
       MyCtl1 <= 0; 
       RTtoRS <= 0;
       ReadH <= 0; 
       ReadL <= 0;
       RegWriteH <= 0; 
       RegWriteL <= 0; 
       HiLoInput <= 0; 
       OutputToWriteData <= 0;   
       Op <= 0;    
       AndI <= 0;    
       MemData <= 0; 
       ReadDMMux <= 0; 
       CompareOp <= 0; 
       Jump <= 0; 
       link <= 0; 
       Type <= 2; 
   end   
   else if(Opcode == 6'b000010) begin  //jump
       RegDst <= 0;
       RegWrite <= 0;
       ALUSrc <= 0; 
       ALUOp <= 6'd0;
       MemRead <= 0;
       MemWrite <= 0;
       MemtoReg <= 0;
       PCSrc <= 0;
       MyCtl1 <= 0; 
       RTtoRS <= 0;
       ReadH <= 0; 
       ReadL <= 0;
       RegWriteH <= 0; 
       RegWriteL <= 0; 
       HiLoInput <= 0; 
       OutputToWriteData <= 0;   
       Op <= 0;    
       AndI <= 0;    
       MemData <= 0; 
       ReadDMMux <= 0; 
       CompareOp <= 0; 
       Jump <= 1; 
       link <= 0; 
       Type <= 10; 
   end   
   else if(Opcode == 6'b000011) begin  //jal
       RegDst <= 0;
       RegWrite <= 0;
       ALUSrc <= 0; 
       ALUOp <= 6'd0;
       MemRead <= 0;
       MemWrite <= 0;
       MemtoReg <= 0;
       PCSrc <= 0;
       MyCtl1 <= 0; 
       RTtoRS <= 0;
       ReadH <= 0; 
       ReadL <= 0;
       RegWriteH <= 0; 
       RegWriteL <= 0; 
       HiLoInput <= 0; 
       OutputToWriteData <= 0;   
       Op <= 0;    
       AndI <= 0;    
       MemData <= 0; 
       ReadDMMux <= 0; 
       CompareOp <= 0; 
       Jump <= 1; 
       link <= 1; 
       Type <= 10; 
   end
   
    end
endmodule
