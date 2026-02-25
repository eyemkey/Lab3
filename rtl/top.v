`timescale 1ns / 1ps


module top (
    input clk, 
    input btnL,
    input btnU,
    input adj, 
    input sel, 
    output [6:0] seg, 
    output [3:0] an
//    output [7:0] an // for Nexys A7
); 

    wire cnt_en, disp_en, sample_en;
    wire blink_clk; 
    wire rst_en, pause_en;
    wire [3:0] S0, S1, M0, M1; 
    wire [6:0] seg0_ip, seg1_ip, seg2_ip, seg3_ip; 

    
    

    clk_mngr clk_mngr (
        .clk(clk), 
        .adj(adj),
        .cnt_en(cnt_en), 
        .disp_en(disp_en),
        .sample_en(sample_en),
        .blink_clk(blink_clk)
    );
    
    counter counter (
        .clk(clk),
        .adj(adj),
        .sel(sel),
        .rst_en(rst_en),
        .cnt_en(cnt_en),
        .pause_en(pause_en),
        .S0(S0), 
        .S1(S1), 
        .M0(M0), 
        .M1(M1)
    );
    
    debouncing debouncing (
        .clk(clk), 
        .btnL(btnL), 
        .btnU(btnU), 
        .sample_en(sample_en), 
        .pause_en(pause_en), 
        .rst_en(rst_en)
    ); 
    
    convert_7seg converter (
        .S0(S0), 
        .S1(S1), 
        .M0(M0), 
        .M1(M1), 
        
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
        .blink_clk(blink_clk),
        .seg0_ip(seg0_ip), 
        .seg1_ip(seg1_ip), 
        .seg2_ip(seg2_ip), 
        .seg3_ip(seg3_ip), 
        .seg(seg), 
        .an(an)
    ); 
    
//    assign an[7:4] = 4'b1111; //NEXYS A7 ONLY
    
endmodule
