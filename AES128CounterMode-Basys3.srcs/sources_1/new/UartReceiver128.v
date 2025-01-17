`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/16/2025 09:03:47 PM
// Design Name: 
// Module Name: UartReceiver128
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


module UartReceiver128(
        input i_clk100MHz,
        input i_rx,
        input i_reset,
        output o_doneReceiving,
        output [127:0] o_data
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
         
    wire [7:0] data_rx;
    wire data_ready_sig;
    uart_receiver         #(
            .DBITS(DBITS),
            .SB_TICK(SB_TICK)
         )
         i(
            .clk_100MHz(i_clk100MHz),               // basys 3 FPGA
            .reset(i_reset),                    // reset
            .rx(i_rx),                       // receiver data line
            .sample_tick(tick),              // sample tick from baud rate generator
            .data_ready(data_ready_sig),          // signal when new data word is complete (received)
            .data_out(data_rx)     // data to FIFO
        );   
        
    parameter   S_RECEIVING = 0,
                S_DONE = 1;
                
    reg [1:0] state = S_RECEIVING;
    reg [1:0] next_state = S_RECEIVING;
    
    reg [3:0] count = 0;
    reg [3:0] next_count = 0;
    
    reg [127:0] data128 = 0;
    reg [127:0] next_data128 = 0;
    
    reg doneReceiving = 0;
    
        
    always@(i_clk100MHz) begin
        doneReceiving = 0;
        case(state)
            S_RECEIVING: begin 
                if (count == 15)
                    next_state = S_DONE;
                else
                    next_state = S_RECEIVING;
                    
                if (data_ready_sig) begin
                    next_count = count + 1;
                    next_data128 = {data128[123:0], data_rx};
                end else begin
                    next_count = count;
                    next_data128 = data128;
                end

            end
            S_DONE: begin
                next_state = S_RECEIVING;
                next_count = 0;
                next_data128 = 0;
                doneReceiving = 1;
            end
        endcase
    end
    
    assign o_doneReceiving = doneReceiving;
    assign o_data = data128;
//    assign o_state = state;
    
    always@(posedge i_clk100MHz) begin
        if (i_reset) begin
            state <= S_RECEIVING;
            count <= 0;
            data128 <= 0;
        end else begin
            state <= next_state;
            count <= next_count;
            data128 <= next_data128;
        end
    end     
    
endmodule
