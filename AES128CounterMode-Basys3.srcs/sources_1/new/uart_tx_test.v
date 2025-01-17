`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/16/2025 07:28:55 PM
// Design Name: 
// Module Name: uart_tx_test
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


module uart_tx_test(
        input clk100MHz,
        output active,
        output tx,
        output done
    );
    
  parameter c_CLOCK_PERIOD_NS = 100;
  parameter c_CLKS_PER_BIT    = 87;
  parameter c_BIT_PERIOD      = 8600;
    
    reg dv = 1;
    reg [7:0] data = 8'h41;
    
    
    
  uart_tx #(.CLKS_PER_BIT(c_CLKS_PER_BIT)) UART_TX_INST
    (.i_Clock(clk100MHz),
     .i_Tx_DV(dv),
     .i_Tx_Byte(data),
     .o_Tx_Active(active),
     .o_Tx_Serial(tx),
     .o_Tx_Done(done)
     );
endmodule
