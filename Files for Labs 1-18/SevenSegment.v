`timescale 1ns / 1ps

module SevenSegment(numin, segout);
  input	[3:0] numin;
  output	reg [6:0] segout;
  always @(numin)
    begin
      //segment a
      segout[6] <=    (numin[3]& numin[1]) | (numin[3]& numin[2]) | (numin[2]& ~numin[1]& ~numin[0]) | (~numin[3]& ~numin[2]& ~numin[1]& numin[0]);

      //segment b
      segout[5] <=    (numin[3]& numin[1]) | (numin[3]& numin[2]) | (numin[2]& ~numin[1]& numin[0]) | (numin[2]& numin[1]& ~numin[0]);

      //segment c
      segout[4] <=    (numin[3]& numin[1]) | (numin[3]& numin[2]) | (~numin[2]& numin[1]& ~numin[0]);

      //segment d
      segout[3] <=    (numin[2]& ~numin[1]& ~numin[0]) | (numin[2]& numin[1]& numin[0]) | (numin[3]& numin[1]) | (numin[3]& numin[2]) |  (numin[3]& numin[2]) | (~numin[3]& ~numin[2]& ~numin[1]& numin[0]);

      //segment e
      segout[2] <=    (numin[2]& ~numin[1]) | (numin[3]& numin[1]) | (numin[0]) ;

      //segment f
      segout[1] <=    (numin[3]& numin[1]) | (numin[3]& numin[2]) | (numin[1]& numin[0]) | (~numin[3]& ~numin[2]& numin[0]) | (~numin[3]& ~numin[2]& numin[1]);

      //segment g
      segout[0] <=    (numin[3]& numin[1]) | (numin[3]& numin[2]) | (~numin[3]& ~numin[2]& ~numin[1]) | (numin[2]& numin[1]& numin[0]);

    end
endmodule
