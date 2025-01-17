`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/16/2025 08:25:48 PM
// Design Name: 
// Module Name: UartTransmitter128Test
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


module UartTransmitter128Test(
        input i_clk100MHz,
        input i_start,
        input i_reset,
        output o_doneTransmitting,
        output o_tx
//        output [1:0] o_state,
//        output [7:0] o_data
    );
    
    reg [127:0] i_data = 128'h4142434445464748494A4B4C4D4E4F;
    UartTransmitter128 inst(.i_start(i_start), .i_clk100MHz(i_clk100MHz), .i_data(i_data), .o_doneTransmitting(o_doneTransmitting), .o_tx(o_tx), .i_reset(i_reset));
endmodule
