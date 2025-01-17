`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2024 10:20:16 PM
// Design Name: 
// Module Name: tb_AES_Datapath
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


module tb_AES_Datapath(

    );
    
    initial begin
        #50 $finish();
    end
    
    reg [127:0] key_mem [0:0];
    reg [127:0] key;
    reg [127:0] block_mem [0:0];
    reg [127:0] block;
    reg [7:0] addition;
    reg [127:0] added;
    
    reg isRound10 = 1;
    reg isRound1 = 1;
    
    initial begin
    
        $readmemh("key128_01.mem", key_mem, 0, 0);
        key = key_mem[0];
        addition = 8'b00000001; // round 1 addition (RC[0])
        
        
        $readmemh("block128_02.mem", block_mem, 0, 0);
        block = block_mem[0];
        added = block ^ key;
    end    
    
    reg clk;
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    
    wire [127:0] o_ciphertext;
    
    AES_Datapath inst(
        .i_plaintext(block),
        .i_initialKey(key),
        .i_isRound10(isRound10),
        .i_isRound1(isRound1),
        .i_addition(addition),
        .i_saveResult(1'b1),
        .clk(clk),
        .o_ciphertext(o_ciphertext)
    );
endmodule
