`timescale 1ns / 1ps

module bcd_to_7seg(
    input [3:0] bcd, 
    output [6:0] seg7
);
    //takes in bcd, sets the associated segments to 0
    reg [6:0] seg7_r; 
    
    always @(*) begin
        case (bcd)
            0: seg7_r = 7'b100_0000;
            1: seg7_r = 7'b111_1001; 
            2: seg7_r = 7'b010_0100;
            3: seg7_r = 7'b011_0000; 
            4: seg7_r = 7'b001_1001;  
            5: seg7_r = 7'b001_0010; 
            6: seg7_r = 7'b000_0010; 
            7: seg7_r = 7'b111_1000; 
            8: seg7_r = 7'b000_0000; 
            9: seg7_r = 7'b001_0000; 
            default: seg7_r = 7'b000_0001; 
        endcase
    end
    
    assign seg7 = seg7_r;
endmodule
