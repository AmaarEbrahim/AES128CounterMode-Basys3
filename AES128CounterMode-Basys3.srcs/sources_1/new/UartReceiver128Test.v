`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/16/2025 09:13:30 PM
// Design Name: 
// Module Name: UartReceiver128Test
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


module UartReceiver128Test(
        input i_clk100MHz,
        input i_rx,
        input i_reset,
        output o_doneReceiving
    );
    
    UartReceiver128 i(
            .i_clk100MHz(i_clk100MHz),
            .i_rx(i_rx),
            .i_reset(i_reset),
            .o_doneReceiving(o_doneReceiving)
        );
endmodule
