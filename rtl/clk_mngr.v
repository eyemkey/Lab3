`timescale 1ns / 1ps

module clk_mngr(
    input clk, //100MHz 
    input adj, 
    output reg disp_en,
    output reg cnt_en //1Hz
//    output reg blink_en //2.2Hz
);
    
    localparam NUM_100M = 100000000;
    localparam NUM_2000 = 2000;
    
    localparam NUM_50M = 50000000;
//    localparam NUM_33M = 33333333; //creates 3Hz pulse
    
    
    wire [26:0] cnt_en_MAX = adj ? NUM_50M : NUM_100M;
    
    reg [26:0] cnt_en_counter; //Counts fom 0 to 100M-1
    reg [10:0] disp_en_counter; //Counts from 0 to 1999
    reg [25:0] blink_en_counter; 
    
    initial begin
        cnt_en_counter = 0; 
        disp_en_counter = 0;
    end
    
    always @(posedge clk) begin
        disp_en <= 0; 
        cnt_en <= 0; 
//        blink_en <= 0; 
        
        if(cnt_en_counter == cnt_en_MAX-1) begin
            cnt_en_counter <= 0; 
            cnt_en <= 1; 
        end
        
        else cnt_en_counter <= cnt_en_counter + 1; 
        
        if(disp_en_counter == NUM_2000-1) begin
            disp_en_counter <= 0;
            disp_en <= 1;  
        end
        else disp_en_counter <= disp_en_counter + 1;     
    end
        
endmodule