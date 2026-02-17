`timescale 1ns / 1ps


module top (
    input clk, 
    input btnL,
    output [6:0] seg, 
    output [3:0] an
);
//    reg clk; 
//    initial clk = 0; 
//    always #5 clk = ~clk;     

    wire cnt_clk, disp_clk; 
    reg rst;
    reg [2:0] rst_buff; 
    wire [3:0] SD0, SD1, SD2, SD3; 
    wire [6:0] seg0_ip, seg1_ip, seg2_ip, seg3_ip; 
    
//    initial begin
//        #100000; 
//        $finish; 
//    end

    always @(posedge clk) begin
        rst_buff <= {btnL, rst_buff[2:1]};
        if(rst && ~cnt_clk) begin
        end
        else begin
            rst <= ~rst_buff[0] & rst_buff[1];
        end
    end
    

    clk_mngr clk_mngr (
        .clk(clk), 
        .cnt_clk(cnt_clk), 
        .disp_clk(disp_clk)
    ); 
    
    
    counter counter (
        .cnt_clk(cnt_clk),
        .rst(rst), 
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
        .seg1_ip(seg1_ip), 
        .seg2_ip(seg2_ip), 
        .seg3_ip(seg3_ip)
    ); 
    
    seg_display7 display(
        .disp_clk(disp_clk), 
        .seg0_ip(seg0_ip), 
        .seg1_ip(seg1_ip), 
        .seg2_ip(seg2_ip), 
        .seg3_ip(seg3_ip), 
        .seg(seg), 
        .an(an)
    ); 
    
endmodule
