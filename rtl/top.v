`timescale 1ns / 1ps


module top (
    input clk, 
    input btnL,
    input btnC,
    input adj, 
    input sel, 
    output [6:0] seg, 
//    output [3:0] an
    output [7:0] an // for Nexys A7
); 

    wire cnt_en, disp_en, blink_en; 
    reg rst_en, pause_en;
    reg [2:0] rst_en_buff, pause_en_buff; 
    wire [3:0] SD0, SD1, SD2, SD3; 
    wire [6:0] seg0_ip, seg1_ip, seg2_ip, seg3_ip; 

    always @(posedge clk) begin
        rst_en_buff <= {btnL, rst_en_buff[2:1]};
        rst_en <= ~rst_en_buff[0] & rst_en_buff[1];
    end
    
    always @(posedge clk) begin
         pause_en_buff <= {btnC, pause_en_buff[2:1]}; 
         pause_en <= ~pause_en_buff[0] & pause_en_buff[1];
    end
    

    clk_mngr clk_mngr (
        .clk(clk), 
        .adj(adj),
        .cnt_en(cnt_en), 
        .disp_en(disp_en)
//        .blink_en(blink_en)
    );
    
    counter counter (
        .clk(clk),
        .adj(adj),
        .sel(sel),
        .rst_en(rst_en),
        .cnt_en(cnt_en),
        .pause_en(pause_en),
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
        .clk(clk), 
        .adj(adj), 
        .sel(sel),
        .disp_en(disp_en),
//        .blink_en(blink_en),
        .seg0_ip(seg0_ip), 
        .seg1_ip(seg1_ip), 
        .seg2_ip(seg2_ip), 
        .seg3_ip(seg3_ip), 
        .seg(seg), 
        .an(an)
    ); 
    
//    assign an[7:4] = 4'b1111; //NEXYS A7 ONLY
    
endmodule
