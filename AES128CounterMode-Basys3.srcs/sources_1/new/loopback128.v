`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2024 06:03:53 PM
// Design Name: 
// Module Name: loopback128
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


module loopback128(
        input i_start,
        input reset,
        input rx,
        input clk,
        output tx
    );

    wire done;
    wire [128:0] total_data;

    uart_receiver128 receiver(
            .clk(clk),
            .reset(reset),
            .start(i_start),
            .rx(rx),
            .done(done),
            .total_data(total_data)
        );
        

    uart_transmitter128 transmitter(
        .i_start(start_transmit),
        .i_clk100MHz(clk),
        .i_text(total_data),
        .o_uartFinished(),
        .tx(tx),
        .isidle()
    );
    
    reg start_transmit = 0;
    
    always@(posedge clk) begin
        if (done)
            start_transmit = 1;
        else
            start_transmit = 0;
            
    end
        
endmodule
