`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2024 05:18:37 PM
// Design Name: 
// Module Name: tb_Row
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


module tb_Row(

    );
    
    initial begin
        #50 $finish();
    end

    reg [31:0] i_word;
    wire [7:0] o_byte;
    
    Row inst(.i_word(i_word), .o_byte(o_byte));
    
    initial begin
        i_word = 32'hFB_CD_A9_C5;
    end
    
endmodule
