`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2024 06:21:25 PM
// Design Name: 
// Module Name: tb_Multiplier
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


module tb_Multiplier(

    );
    
    initial begin
        #50 $finish();
    end
    
    reg [31:0] in;
    wire [31:0] out;
    
    Multiplier inst(.i_word(in), .o_word(out));
    
    initial begin
        in = 32'hFB_CD_A9_C5;
    end
endmodule
