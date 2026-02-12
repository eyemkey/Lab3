`timescale 1ns / 1ps

module counter(
    input cnt_clk, 
    
    output [3:0] SD0, 
    output [3:0] SD1, 
    output [3:0] SD2, 
    output [3:0] SD3
);

    reg [3:0] values [0:3];
     
    always @(posedge cnt_clk) begin
        if (values[0] == 9) begin
            values[0] <= 0;    
            
            if(values[1] == 5) begin
                values[1] <= 0; 
                
                if(values[2] == 9) begin
                    values[2] <= 0; 
                    
                    if(values[3] == 9) begin
                        values[3] <= 0;
                    end else values[3] <= values[3] + 1; 
                    
                end else values[2] <= values[2] + 1; 
                
            end else values[1] <= values[1] + 1; 
            
        end else values[0] <= values[0] + 1;
        
    end
    
    assign SD0 = values[0]; 
    assign SD1 = values[1]; 
    assign SD2 = values[2]; 
    assign SD3 = values[3]; 
endmodule
