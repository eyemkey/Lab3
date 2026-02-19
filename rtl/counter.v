`timescale 1ns / 1ps

module counter(
    input clk,
    input adj,
    input sel,
    input rst_en,
    input cnt_en, 
    input pause_en, 
    output [3:0] SD0, 
    output [3:0] SD1, 
    output [3:0] SD2, 
    output [3:0] SD3
);

    reg [3:0] values [0:3];
    reg pause; 
    
    initial begin
        values[0] = 4'b0000; 
        values[1] = 4'b0000; 
        values[2] = 4'b0000;
        values[3] = 4'b0000;
        
        pause = 0; 
    end
     
    always @(posedge clk) begin
        if(pause_en && !adj) begin
            pause <= ~pause; 
        end
        if(rst_en) begin
            values[0] <= 0; 
            values[1] <= 0; 
            values[2] <= 0; 
            values[3] <= 0; 
        end
        else if (!adj && cnt_en && !pause) begin
            if (values[0] == 9) begin
                values[0] <= 0;    
                
                if(values[1] == 5) begin
                    values[1] <= 0; 
                    
                    if(values[2] == 9) begin
                        values[2] <= 0; 
                        
                        if(values[3] == 5) begin
                            values[3] <= 0;
                        end else values[3] <= values[3] + 1; 
                        
                    end else values[2] <= values[2] + 1; 
                    
                end else values[1] <= values[1] + 1; 
                
            end else values[0] <= values[0] + 1;
        end
        
        else if(adj && cnt_en && !pause) begin
            case(sel)
                0: begin //adj minutes
                    if(values[2] == 9) begin
                        values[2] <= 0; 
                        
                        if(values[3] == 5) begin
                            values[3] <= 0; 
                        end else values[3] <= values[3] + 1; 
                    end else values[2] <= values[2] + 1;
                end
                1: begin //adj seconds
                    if(values[0] == 9) begin
                        values[0] <= 0; 
                        if(values[1] == 5) begin
                            values[1] <= 0; 
                        end else values[1] <= values[1] + 1; 
                    end else values[0] <= values[0] + 1;
                end
            endcase
        end
        
    end
    
    assign SD0 = values[0]; 
    assign SD1 = values[1]; 
    assign SD2 = values[2]; 
    assign SD3 = values[3]; 
endmodule
