`timescale 1ns / 1ps


module top (
    input clk, 
    output [6:0] seg, 
    output [3:0] an
);


    wire cnt_clk, disp_clk; 
    wire [3:0] SD0, SD1, SD2, SD3; 
    wire [6:0] seg0_ip, seg1_ip, seg2_ip, seg3_ip; 

    clk_mngr clk_mngr (
        .clk(clk), 
        .cnt_clk(cnt_clk), 
        .disp_clk(disp_clk)
    ); 
    
    
    counter counter (
        .cnt_clk(cnt_clk), 
        .SD0(SD0), 
        .SD1(SD1), 
        .SD2(SD2), 
        .SD3(SD3)
    );
    
    convert_7seg converter (
        .SD0(SD0), 
        .SD1(SD1), 
        .SD2(SD2), 
        .SD3(SD3), 
        
        .seg0_ip(seg0_ip), 
        .seg0_ip(seg1_ip), 
        .seg0_ip(seg2_ip), 
        .seg0_ip(seg3_ip)
    ); 
    
endmodule
