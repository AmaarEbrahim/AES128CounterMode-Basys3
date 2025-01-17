`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2024 02:15:58 PM
// Design Name: 
// Module Name: Transform
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


module Transform(
        input [127:0] i_key,
        output [127:0] o_key,
        input [7:0] i_addition
    );
    
    wire [31:0] word1, word2, word3, word4;
    
    assign {word1, word2, word3, word4} = i_key;
    
    wire [31:0] word1_out, word2_out, word3_out, word4_out;
    
    wire [31:0] out_g;
    GFunction inst(.i_word(word4), .o_word(out_g), .i_addition(i_addition));
    assign word1_out = word1 ^ out_g;
    assign word2_out = word2 ^ word1_out;
    assign word3_out = word3 ^ word2_out;
    assign word4_out = word4 ^ word3_out;
    
    assign o_key = {word1_out, word2_out, word3_out, word4_out};
endmodule
