`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2024 11:00:53 PM
// Design Name: 
// Module Name: tb_AES_Core
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


module tb_AES_Core(

    );
    
    initial begin
        #300 $finish();
    end
    
    reg clk;
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    
    reg i_start = 1;
    initial begin
        #50 i_start = 0;
    end
    
    

    reg [127:0] key_mem [0:0];
    reg [127:0] key;
    reg [127:0] block_mem [0:0];
    reg [127:0] block;
    initial begin
        $readmemh("key128_01.mem", key_mem, 0, 0);
        key = key_mem[0];
        $readmemh("block128_02.mem", block_mem, 0, 0);
        block = block_mem[0];
    end  
    
    wire [127:0] o_ciphertext;
    wire o_finished;
    AES_Core inst(
        .clk(clk),
        .i_start(i_start),
        .i_plaintext(block),
        .i_key(key),
        .o_ciphertext(o_ciphertext),
        .o_finished(o_finished)
    );
endmodule
