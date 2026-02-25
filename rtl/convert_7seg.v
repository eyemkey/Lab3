`timescale 1ns / 1ps

module convert_7seg(
    input [3:0] S0, 
    input [3:0] S1, 
    input [3:0] M0, 
    input [3:0] M1, 
    
    output [6:0] seg0_ip, 
    output [6:0] seg1_ip, 
    output [6:0] seg2_ip, 
    output [6:0] seg3_ip
);


    bcd_to_7seg convert0 (
        .bcd(S0), 
        .seg7(seg0_ip)
    );  
    
    bcd_to_7seg convert1 (
        .bcd(S1), 
        .seg7(seg1_ip)
    );     
        
    bcd_to_7seg convert2 (
        .bcd(M0), 
        .seg7(seg2_ip)
    );     
            
    bcd_to_7seg convert3 (
        .bcd(M1), 
        .seg7(seg3_ip)
    );        
    

endmodule
