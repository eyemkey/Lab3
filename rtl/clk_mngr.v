`timescale 1ns / 1ps

module clk_mngr(
    input clk, //100MHz 
    output disp_clk,
    output cnt_clk //1Hz
);
    
    localparam NUM_100M = 100000000;
    localparam NUM_2000 = 2000;
    
    
    reg [26:0] cnt_clk_counter; //Counts fom 0 to 1M-1
    reg [10:0] disp_clk_counter; //Counts from 0 to 1999
    reg disp_clk_r; 
    reg cnt_clk_r; 
    
    always @(posedge clk) begin
        if(cnt_clk_counter == NUM_100M) begin
            cnt_clk_counter <= 1; 
            cnt_clk_r <= ~cnt_clk_r;
        end
        else cnt_clk_counter <= cnt_clk_counter + 1; 
        
        if(disp_clk_counter == 2000) begin
            disp_clk_counter <= 1; 
            disp_clk_r <= ~disp_clk_r; 
        end
        else disp_clk_counter <= disp_clk_counter + 1;        
    end
        
        
    assign disp_clk = disp_clk_r; 
    assign cnt_clk = cnt_clk_r; 
endmodule
