`timescale 1ns / 1ps

module debouncing(
    input clk, 
    input btnL, 
    input btnU,
    input sample_en, 
    output reg pause_en, 
    output reg rst_en
);

    reg sample_en_d; 
    reg [2:0] rst_en_buff, pause_en_buff;
    
    always @(posedge clk) begin
        sample_en_d <= sample_en;     
    end
    
    always @(posedge clk) begin
        if(sample_en) begin
            rst_en_buff <= {btnL, rst_en_buff[2:1]}; 
        end
        rst_en <= rst_en_buff[1] & ~rst_en_buff[0] & sample_en_d;
    end
    
    always @(posedge clk) begin
        if(sample_en) begin
            pause_en_buff <= {btnU, pause_en_buff[2:1]};
        end
        pause_en <= pause_en_buff[1] & ~pause_en_buff[0] & sample_en_d;
    end

endmodule
