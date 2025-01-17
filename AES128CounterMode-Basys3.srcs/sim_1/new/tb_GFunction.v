`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2024 07:57:36 PM
// Design Name: 
// Module Name: tb_GFunction
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


module tb_GFunction(

    );
    
    initial begin
        #50 $finish();
    end
    
    wire [31:0] o_word;
    
    reg [31:0] i_word;
    reg [7:0] addition;
    initial begin
        i_word = 32'hABCD1234;
        addition = 8'b00000010;
    end
    
    GFunction inst(.i_word(i_word), .o_word(o_word), .i_addition(addition));
endmodule
