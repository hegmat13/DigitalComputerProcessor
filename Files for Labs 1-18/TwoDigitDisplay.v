`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Arizona
// Engineer: R. Thamvichai
// 
// Create Date: 09/01/2015 01:15:14 PM
// Design Name: 
// Module Name: TwoDigitDisplay
//////////////////////////////////////////////////////////////////////////////////
module TwoDigitDisplay(Clk, Number1, Number2, out7, en_out);
  input  Clk;
  input  [15:0] Number1, Number2;
  output [6:0] out7; //seg a, b, ... g
  output reg [7:0] en_out;

  reg  [3:0] in4;        
  reg  [3:0] firstdigit;
  reg  [3:0] seconddigit;
  reg  [3:0] thirddigit;
  reg  [3:0] fourthdigit;
  reg  [3:0] fifthdigit;
  reg  [3:0] sixthdigit;
  reg  [3:0] seventhdigit;
  reg  [3:0] eighthdigit;


  //--------- --------- --------- --------- //
  //-- to use the module SevenSegment 
  SevenSegment m1(in4, out7);
  //--------- --------- --------- --------- //

  //-- divider counter for ~95.3Hz refresh rate (with 100MHz main clock)
  reg  [19:0] cnt;
  always @(posedge Clk) begin
    cnt <= cnt + 1;
  end

  //-- to seperate each decimal digit for display
  always @(Number1, Number2) begin
    if (Number1 < 100000)
      begin
        firstdigit <= Number1%10;
        seconddigit <= (Number1/10)%10;
        thirddigit <= (Number1/100)%10;
        fourthdigit <= (Number1/1000)%10;
      end 
    else begin
        firstdigit <= 4'b1111;
        seconddigit <= 4'b1111;
        thirddigit <= 4'b1111;
        fourthdigit <= 4'b1111;
      end
      
      if (Number2 < 100000)
            begin
              fifthdigit <= Number2%10;
              sixthdigit <= (Number2/10)%10;
              seventhdigit <= (Number2/100)%10;
              eighthdigit <= (Number2/1000)%10;
            end 
          else begin;
              fifthdigit <= 4'b1111;
              sixthdigit <= 4'b1111;
              seventhdigit <= 4'b1111;
              eighthdigit <= 4'b1111;
            end
  end

  //-- to display the number in the appropriate 7-segment digit
  always @(cnt) begin
    case(cnt[19:17])  //100MHz/(2^20) = 95.3 Hz
      3'b000: begin en_out <= 8'b11111110; in4 <= firstdigit; end
      3'b001: begin en_out <= 8'b11111101; in4 <= seconddigit; end
      3'b010: begin en_out <= 8'b11111011; in4 <= thirddigit; end
      3'b011: begin en_out <= 8'b11110111; in4 <= fourthdigit; end
      3'b100: begin en_out <= 8'b11101111; in4 <= fifthdigit; end
      3'b101: begin en_out <= 8'b11011111; in4 <= sixthdigit; end
      3'b110: begin en_out <= 8'b10111111; in4 <= seventhdigit; end
      3'b111: begin en_out <= 8'b01111111; in4 <= eighthdigit; end
      default: begin en_out <= 8'b11111111; in4 <= 4'b1111; end 
    endcase
  end
endmodule
