`timescale 1ns / 1ps

module clk_mngr(
    input clk, //100MHz 
    input adj, 
    output reg sample_en,
    output reg disp_en,
    output reg cnt_en, //1Hz
    output reg blink_clk  //3Hz
);
    
    localparam NUM_100M = 100000000;
    localparam NUM_200k = 200000;
    
    localparam NUM_50M = 50000000;
    localparam NUM_22M = 25000000;
    localparam NUM_1M = 1000000;
    
    
    wire [26:0] cnt_en_MAX = adj ? NUM_50M : NUM_100M;
    
    reg [26:0] cnt_en_counter; //Counts fom 0 to 100M-1
    reg [17:0] disp_en_counter; //Counts from 0 to 200k-1
    reg [25:0] blink_clk_counter; //counts from 0 to 33M-1
    reg [19:0] sample_en_counter; //Counts from 0 to 1M-1
    
    initial begin
        cnt_en_counter = 0; 
        disp_en_counter = 0;
        blink_clk_counter = 0; 
        blink_clk = 0; 
    end
    
    always @(posedge clk) begin
        disp_en <= 0; 
        cnt_en <= 0; 
        sample_en <= 0; 
        
        if(cnt_en_counter == cnt_en_MAX-1) begin
            cnt_en_counter <= 0; 
            cnt_en <= 1; 
        end
        
        else cnt_en_counter <= cnt_en_counter + 1; 
        
        if(disp_en_counter == NUM_200k-1) begin
            disp_en_counter <= 0;
            disp_en <= 1;  
        end
        else disp_en_counter <= disp_en_counter + 1;   
        
        if(blink_clk_counter == NUM_22M-1) begin
            blink_clk_counter <= 0; 
            blink_clk <= ~blink_clk; 
        end else blink_clk_counter <= blink_clk_counter + 1; 
        
        if(sample_en_counter == NUM_1M-1) begin
            sample_en_counter <= 0; 
            sample_en <= 1; 
        end else sample_en_counter <= sample_en_counter + 1; 
    end
        
endmodule