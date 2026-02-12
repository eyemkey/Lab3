`timescale 1ns / 1ps

module bcd_to_7seg(
    input [3:0] bcd, 
    output [6:0] seg7
);
    //takes in bcd, sets the associated segments to 0
    
    wire A, B, C, D; 
    assign {A, B, C, D} = bcd; 
    
    assign seg7[6] = (~A & B & ~C & ~D) | (~A & ~B & ~C & D);
    assign seg7[5] = B & (C ^ D);
    assign seg7[4] = (~A & ~B & C & ~D);
    assign seg7[3] = B & ~(C & D) | (~A & ~B & ~C & D);
    assign seg7[2] = D | (B & ~C);
    assign seg7[1] = (C & D) | (~A & ~B & D) | (~A & ~B & C);
    assign seg7[0] = (~A & ~B & ~C) | (B & C & D);
endmodule
