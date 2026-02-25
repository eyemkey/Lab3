`timescale 1ns / 1ps

module top_tb;
    
    //DUT inputs
    reg clk; 
    reg btnL; 
    reg btnU; 
    reg adj; 
    reg sel; 
    
    wire [6:0] seg; 
    wire [7:0] an; 
    
    top dut(
        .clk(clk), 
        .btnL(btnL),
        .btnU(btnU),
        .adj(adj),
        .sel(sel),
        .seg(seg),
        .an(an)
    ); 
    
    initial clk = 0; 
    always #5 clk = ~clk; //100MHz
    
    reg cnt_en_tb, sample_en_tb; 
    
    initial begin
        
        cnt_en_tb = 0; 
        sample_en_tb = 0;
        
        force dut.cnt_en = cnt_en_tb; 
        force dut.sample_en = sample_en_tb;
    end
    
    task cnt_pulse; 
        begin
            @(negedge clk); 
            cnt_en_tb = 1'b1; 
            @(negedge clk); 
            cnt_en_tb = 1'b0;
        end
    endtask
    
    
    task sample_pulse; 
        begin
            @(negedge clk); 
            sample_en_tb = 1'b1; 
            @(negedge clk); 
            sample_en_tb = 1'b0;
        end
    endtask
    
    
    task press_reset; 
        integer i; 
        begin
            btnL = 1'b1; 
            for(i = 0; i < 3; i = i + 1) sample_pulse(); 
            btnL = 1'b0; 
            for(i = 0; i < 2; i = i + 1) sample_pulse();
        end
    endtask
    
    task press_pause; 
        integer i;
        begin
            btnU = 1'b1; 
            for(i = 0; i < 3; i = i + 1) sample_pulse(); 
            btnU = 1'b0; 
            for(i = 0; i < 2; i = i + 1) sample_pulse();
        end
    endtask
    
    task force_time_5958_then_overflow;
        begin
          // Adjust path to your actual counter instance name
          force dut.counter.values[3] = 4'd5; // minutes tens
          force dut.counter.values[2] = 4'd9; // minutes ones
          force dut.counter.values[1] = 4'd5; // seconds tens
          force dut.counter.values[0] = 4'd8; // seconds ones
        
          // let it settle one clock
          @(posedge clk);
        
          // IMPORTANT: release so the counter logic can update them
          release dut.counter.values[3]; // minutes tens
          release dut.counter.values[2]; // minutes ones
          release dut.counter.values[1]; // seconds tens
          release dut.counter.values[0]; // seconds ones
        
        
          // now tick 2 seconds: 59:58 -> 59:59 -> 00:00
          print_time();
          cnt_pulse();
          print_time(); 
          cnt_pulse();
          print_time(); 
          cnt_pulse(); 
          print_time(); 
        end
    endtask
    
    task print_time; 
        begin
            $display("TIME = %0d%0d:%0d%0d",
             dut.M1, dut.M0, dut.S1, dut.S0);
        end
    endtask
    
    integer k; 
    initial begin
        btnL = 0; 
        btnU = 0; 
        adj = 0; 
        sel = 0; 
        
        repeat (5) @(posedge clk); 
        
        $display("TEST 1: RESET"); 
        press_reset(); 
        repeat(2) @(posedge clk); 
        print_time(); 
        
        $display("TEST 2: NORMAL COUNTING (12 pulses)"); 
        adj = 0; 
        for(k = 0; k < 12; k = k + 1) cnt_pulse(); 
        print_time(); 
    
    
        $display("TEST 3: PAUSE (5 pulses)"); 
        press_pause(); 
        for(k = 0; k < 5; k = k + 1) cnt_pulse(); 
        print_time(); 
        
        $display("TEST 3: RESUME (5 pulses)"); 
        press_pause(); 
        for(k = 0; k < 5; k = k + 1) cnt_pulse(); 
        print_time(); 
        
        $display("TEST 4: ADJUST MINUTES (5 pulses)"); 
        adj = 1; 
        sel = 0; 
        for(k = 0; k < 5; k = k + 1) cnt_pulse(); 
        print_time(); 
        
        $display("TEST 5: ADJUST SECONDS (5 pulses)"); 
        sel = 1; 
        for(k = 0; k < 5; k = k + 1) cnt_pulse(); 
        print_time(); 
        
        $display("TEST 6: RESET"); 
        press_reset(); 
        repeat (2) @(posedge clk); 
        print_time(); 
        
        $display("TEST 7: OVERFLOW");
        adj = 0; 
        sel = 0; 
        force_time_5958_then_overflow();
        
        $display("[DONE]"); 
        #50; 
        $finish; 
    end
    
endmodule
