`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2024 02:16:21 PM
// Design Name: 
// Module Name: AES_Datapath
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


module AES_Datapath(
        input [127:0] i_plaintext,
        input [127:0] i_initialKey,
        input i_isRound10,
        input i_isRound0,
        input i_doRound,
        input [7:0] i_addition,
        input clk,
        output [127:0] o_ciphertext
        
    );
    
    
    reg [127:0] block;
    reg [127:0] key;
    reg [127:0] latched_output;
    
    wire [127:0] block_next;
    wire [127:0] key_next;
    
    assign o_ciphertext = block;//128'h12345;    
    Round inst(.i_key(key), .i_block(block), .i_isRound10(i_isRound10), .o_key(key_next), .i_addition(i_addition), .o_block(block_next));

    
    always@(posedge clk) begin
//        block <= 127'h0123456789ABCDEF;// i_plaintext ^ i_initialKey;

        case (i_isRound0) 
            1'b1: begin
                block <=  i_plaintext ^ i_initialKey;
                key <= i_initialKey;
//                isRound10Reg <= i_isRound10;
//                addition <= i_addition;
            end  
            1'b0: begin
                if (i_doRound) begin
                    block <= block_next;
                    key <= key_next;
                    // takes in the old value of i_isRound10 on the clk edge
//                    isRound10Reg <= i_isRound10;
                    
                    
//                    addition <= i_addition;
                end
            end            
        endcase
        

        
    end
    
//    assign o_ciphertext = block;
    
endmodule
