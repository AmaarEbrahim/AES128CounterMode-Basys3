`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/16/2025 09:26:23 PM
// Design Name: 
// Module Name: UartLoopback128
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


module UartLoopback128(
        input i_clk100MHz,
        input i_rx,
        input i_reset,
        output o_tx
    );
    
    wire doneReceiving;
    wire [127:0] data128;
    reg startTransmitting = 0;
    reg [127:0] dataToSend;
    
    UartReceiver128 i(
            .i_clk100MHz(i_clk100MHz),
            .i_rx(i_rx),
            .i_reset(i_reset),
            .o_doneReceiving(doneReceiving),
            .o_data(data128)
        );
        
    wire doneTransmitting;
    UartTransmitter128 inst(
            .i_start(startTransmitting), 
            .i_clk100MHz(i_clk100MHz), 
            .i_data(dataToSend), 
            .o_doneTransmitting(doneTransmitting), 
            .o_tx(o_tx), 
            .i_reset(i_reset)
         );

        
    always@(posedge i_clk100MHz) begin
        if (doneReceiving) begin
            dataToSend = data128;
            startTransmitting = 1;
        end else
            startTransmitting = 0;
    end
endmodule
