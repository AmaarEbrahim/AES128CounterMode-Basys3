`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2024 10:41:05 PM
// Design Name: 
// Module Name: tb_AES_Control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_AES_Control(

    );
    
    initial begin
        #150 $finish();
    end
    
    reg clk;
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    
    reg start;
    initial begin
        start = 0;
        #3 start = 1;
        
        #20 start = 0;
    end
    
    reg goToNextRound;
    initial begin
        goToNextRound = 1;
    end
    
    wire o_isRound1;
    wire o_isRound10;
    wire [3:0] o_round;
    wire o_done;
    
    
    AES_Control inst(.i_start(start), .clk(clk), .o_isRound1(o_isRound1), .o_isRound10(o_isRound10), .o_round(o_round), .o_done(o_done));
endmodule
