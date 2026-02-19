`timescale 1ns / 1ps

module seg_display7(
    input clk,
    input adj, 
    input sel,
    input disp_en, 
    input blink_en, 
    input [6:0] seg0_ip, 
    input [6:0] seg1_ip, 
    input [6:0] seg2_ip, 
    input [6:0] seg3_ip,

    output reg [6:0] seg, 
//    output reg [3:0] an
    output reg [7:0] an //NEXYS A7 only
);
    
    reg [1:0] idx; 
    reg [6:0] seg_r; 
    reg [3:0] an_r; 
    
    initial begin
        idx = 0;
        seg_r = 0; 
        an_r = 0;  
    end
    
    always @(posedge clk) begin
        


//        an <= 4'b1111;
            
        if(disp_en) begin
            seg <= 7'b1111111; 
            an <= 8'b11111111; 
            case (idx) 
                0: begin
                    seg <= seg0_ip;
    //                    an <= 4'b1110;
                    an[3:0] <= 4'b1110;  
                end
                1: begin
                    seg <= seg1_ip; 
    //                    an <= 4'b1101; 
                    an[3:0] <= 4'b1101; 
                
                end
                2: begin
                    seg <= seg2_ip; 
    //                    an <= 4'b1011; 
                    an[3:0] <= 4'b1011; 
                end
                3: begin
                    seg <= seg3_ip; 
    //                    an <= 4'b0111;
                    an[3:0] <= 4'b0111; 
                end
            endcase
            
//            if(blink_en && adj) begin
//                an <= 8'b11111111; 
//            end
            
            idx <= idx + 1; 
            
        end //if(disp_en)
        
    end // always@(posedge clk)

endmodule
