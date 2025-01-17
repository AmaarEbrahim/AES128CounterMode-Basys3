`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2024 02:30:08 PM
// Design Name: 
// Module Name: uart_receiver_test
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


module uart_receiver_test
    #(
        parameter   DBITS = 8,          // number of data bits in a word
                    SB_TICK = 16,       // number of stop bit / oversampling ticks
                    BR_LIMIT = 651,     // baud rate generator counter limit
                    BR_BITS = 10,       // number of baud rate generator counter bits
                    FIFO_EXP = 2        // exponent for number of FIFO addresses (2^2 = 4)
    )
(
        input rx,
        input clk,
        input reset,
        output [7:0] received,
        output is_idle,
        output rx_done,
        output [4:0] count,
        output [4:0] count2
    );
    
    wire tick;                          // sample tick from baud rate generator
    baud_rate_generator 
        #(
            .M(BR_LIMIT), 
            .N(BR_BITS)
         ) 
        BAUD_RATE_GEN   
        (
            .clk_100MHz(clk), 
            .reset(reset),
            .tick(tick)
         );    
    
    wire rx_done1;
    assign rx_done = rx_done1;
    uart_receiver 
#(
            .DBITS(DBITS),
            .SB_TICK(SB_TICK)
         )
    inst2(
        .clk_100MHz(clk),               // basys 3 FPGA
        .reset(reset),                    // reset
        .rx(rx),                       // receiver data line
        .sample_tick(tick),              // sample tick from baud rate generator
        .data_ready(rx_done1),          // signal when new data word is complete (received)
        .data_out(received),     // data to FIFO
        .is_idle(is_idle)
    );
    
    wire [7:0] received;
    reg [4:0] count = 0;
    reg [4:0] count_next = 0;
    always@(posedge clk) begin
        if (rx_done1)
            count_next = count + 1;
    end

    // *** V2
//    always@(rx_done1) begin
//        if (rx_done1)
//            count_next = count + 1;
//    end

    // *** V3
//    reg true_rx_done1;
//    always@(posedge clk) begin
//            true_rx_done1 <= rx_done1;
//    end
    
//    reg [4:0] count2 = 0;
//    reg [4:0] count_next2 = 0;
//    always@(true_rx_done1) begin
//        if (true_rx_done1)
//            count_next2 = count2 + 1;
//    end
            
    
//    always@(posedge clk) begin
//        count <= count_next;
//        count2 <= count_next2;
//    end
endmodule
