`timescale 1ns / 1ps

module bcd_to_7seg(
    input [3:0] bcd, 
    output [6:0] seg7
);
    function automatic [6:0] lut(input [3:0] x); 
        begin
            case (x)
                4'd0: lut = 7'b100_0000;
                4'd1: lut = 7'b111_1001;
                4'd2: lut = 7'b010_0100;
                4'd3: lut = 7'b011_0000;
                4'd4: lut = 7'b001_1001;
                4'd5: lut = 7'b001_0010;
                4'd6: lut = 7'b000_0010;
                4'd7: lut = 7'b111_1000;
                4'd8: lut = 7'b000_0000;
                4'd9: lut = 7'b001_0000;
                default: lut = 7'b000_0001;
            endcase
        end
    endfunction
    
    assign seg7 = lut(bcd); 
endmodule
