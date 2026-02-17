`timescale 1ns / 1ps

module seg_display7(
    input disp_clk, 
    input [6:0] seg0_ip, 
    input [6:0] seg1_ip, 
    input [6:0] seg2_ip, 
    input [6:0] seg3_ip,

    output [6:0] seg, 
    output [3:0] an
);
    
    reg [1:0] counter; 
    reg [6:0] seg_r; 
    reg [3:0] an_r; 
    
    initial begin
        counter = 0;
        seg_r = 0; 
        an_r = 0;  
    end
    
    always @(posedge disp_clk) begin
        case (counter) 
            0: begin
                seg_r <= seg0_ip;
                an_r <= 4'b1110; 
//                $display("%d%d:%d%d", seg3_ip, seg2_ip, seg1_ip, seg0_ip);
            end
            1: begin
                seg_r <= seg1_ip; 
                an_r <= 4'b1101; 
//                $display("%d%d:%d%d", seg3_ip, seg2_ip, seg1_ip, seg0_ip);
            end
            2: begin
                seg_r <= seg2_ip; 
                an_r <= 4'b1011; 
//                $display("%d%d:%d%d", seg3_ip, seg2_ip, seg1_ip, seg0_ip);
            end
            3: begin
                seg_r <= seg3_ip; 
                an_r <= 4'b0111;
//                $display("%d%d:%d%d", seg3_ip, seg2_ip, seg1_ip, seg0_ip);
            end        
        endcase
        
        if(counter == 3) counter <= 0; 
        else counter <= counter + 1;    
    end
    
    assign an = an_r; 
    assign seg = seg_r; 

endmodule
