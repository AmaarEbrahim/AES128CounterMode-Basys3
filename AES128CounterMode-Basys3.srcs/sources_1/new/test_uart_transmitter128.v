`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2024 02:33:10 PM
// Design Name: 
// Module Name: test_uart_transmitter128
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


module test_uart_transmitter128(
        input clk,
        input start,
        output done,
        output tx,
        output isidle
    );
    
//    reg [127:0] key_mem [0:0];
//    reg [127:0] key;
//    reg [127:0] block_mem [0:0];
//    reg [127:0] block;
//    initial begin
//        $readmemh("key128_01.mem", key_mem, 0, 0);
//        key = key_mem[0];
//        $readmemh("block128_02.mem", block_mem, 0, 0);
//        block = block_mem[0];
//    end   
    
    reg [3:0] address = 0;
    wire [255:0] data;
    reg [255:0] d = 0;
    reg we = 0;
    dist_mem_gen_0 in(
        .a(address),
//        .d(d),
//        .clk(clk),
        .spo(data)
//        .we(we)
    );
    reg [127:0] plaintext = 128'hAEC1BEF060B67196537A44A93388F426;
    uart_transmitter128 inst(.i_start(start), .i_clk100MHz(clk), .i_text(data), .o_uartFinished(done), .tx(tx), .isidle(isidle));
endmodule
