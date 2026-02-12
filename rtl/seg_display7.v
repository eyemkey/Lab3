`timescale 1ns / 1ps

module seg_display7(
    input [6:0] seg0_ip, 
    input [6:0] seg1_ip, 
    input [6:0] seg2_ip, 
    input [6:0] seg3_ip,

    output [6:0] seg, 
    output [3:0] an
);

    assign an = 4'b1110; 
    assign seg = 7'b010_1010;    

endmodule
