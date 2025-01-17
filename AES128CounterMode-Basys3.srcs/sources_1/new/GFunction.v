`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2024 07:48:21 PM
// Design Name: 
// Module Name: GFunction
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


module GFunction(
        input [31:0] i_word,
        input [7:0] i_addition,
        output [31:0] o_word
    );
//            input [7:0] di,
//        output [7:0] do

    wire [7:0] byte1, byte2, byte3, byte4;
    
    assign {byte1, byte2, byte3, byte4} = i_word;
    
    wire [7:0] byte1_out, byte2_out, byte3_out, byte4_out;
    
    wire [7:0] to_addition;
    
    SBox i1(.di(byte2), .do(to_addition));
    SBox i2(.di(byte3), .do(byte2_out));
    SBox i3(.di(byte4), .do(byte3_out));
    SBox i4(.di(byte1), .do(byte4_out));
    
    assign byte1_out = to_addition ^ i_addition;
    
    assign o_word = {byte1_out, byte2_out, byte3_out, byte4_out};
endmodule
