`timescale 1ns / 1ps

module convert_7seg(
    input [3:0] SD0, 
    input [3:0] SD1, 
    input [3:0] SD2, 
    input [3:0] SD3, 
    
    output [6:0] seg0_ip, 
    output [6:0] seg1_ip, 
    output [6:0] seg2_ip, 
    output [6:0] seg3_ip
);


    bcd_to_7seg convert0 (
        .bcd(SD0), 
        .seg7(seg0_ip)
    );  
    
    bcd_to_7seg convert1 (
        .bcd(SD1), 
        .seg7(seg1_ip)
    );     
        
    bcd_to_7seg convert2 (
            .bcd(SD2), 
            .seg7(seg2_ip)
    );     
            
    bcd_to_7seg convert3 (
            .bcd(SD3), 
            .seg7(seg3_ip)
        );        
    

endmodule
