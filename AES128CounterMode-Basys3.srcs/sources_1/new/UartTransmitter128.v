`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/16/2025 07:21:27 PM
// Design Name: 
// Module Name: UartTransmitter128
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


module UartTransmitter128(
        input i_clk100MHz,
        input [127:0] i_data,
        input i_start,
        input i_reset,
        output o_doneTransmitting,
        output o_tx
//        output [1:0] o_state,
//        output [7:0] o_data
    );
    
    parameter   DBITS = 8,          // number of data bits in a word
                SB_TICK = 16,       // number of stop bit / oversampling ticks
                BR_LIMIT = 651,     // baud rate generator counter limit
                BR_BITS = 10;       // number of baud rate generator counter bits
    
    wire tick;                          // sample tick from baud rate generator
    baud_rate_generator 
        #(
            .M(BR_LIMIT), 
            .N(BR_BITS)
         ) 
        BAUD_RATE_GEN   
        (
            .clk_100MHz(i_clk100MHz), 
            .reset(i_reset),
            .tick(tick)
         );
    
    wire doneTransmittingByte;
    wire [7:0] res;
    uart_transmitter
        #(
            .DBITS(DBITS),
            .SB_TICK(SB_TICK)
         )
         UART_TX_UNIT
         (
            .clk_100MHz(i_clk100MHz),
            .reset(i_reset),
            .tx_start(startTransmittingByte),
            .sample_tick(tick),
            .data_in(byteToTransmit),
            .tx_done(doneTransmittingByte),
            .tx(o_tx)
         );
    
    parameter   S_IDLE = 0,
                S_TRANSMITTING = 1,
                S_DONE = 2;
                
    reg [1:0] state = S_IDLE;
    reg [1:0] next_state = S_IDLE;
    
    reg [3:0] count = 0;
    reg [3:0] next_count = 0;
    
    reg [7:0] byteToTransmit = 0;
    reg startTransmittingByte = 0;
    reg doneTransmitting = 0;
    
    always@(i_clk100MHz or i_start) begin
        byteToTransmit = 0;
        startTransmittingByte = 0;
        doneTransmitting = 0;
        case(state)
            S_IDLE: begin 
                if (i_start)
                    next_state = S_TRANSMITTING;
                else
                    next_state = S_IDLE;
            end
            S_TRANSMITTING: begin 
                if (count == 15)
                    next_state = S_DONE;
                else
                    next_state = S_TRANSMITTING;
                    
                if (doneTransmittingByte)
                    next_count = count + 1;
                else
                    next_count = count;
                
                byteToTransmit = i_data[count * 8 +: 8];
                startTransmittingByte = 1;
            end
            S_DONE: begin
                next_state = S_IDLE;
                next_count = 0;
                doneTransmitting = 1;
            end
        endcase
    end
    
    assign o_doneTransmitting = doneTransmitting;
//    assign o_state = state;
    
    always@(posedge i_clk100MHz) begin
        if (i_reset) begin
            state <= S_IDLE;
            count <= 0;
        end else begin
            state <= next_state;
            count <= next_count;
        end
    end
    
endmodule
