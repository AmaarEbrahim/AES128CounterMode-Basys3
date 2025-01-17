`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2024 01:05:42 PM
// Design Name: 
// Module Name: uart_transmitter128
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


module uart_transmitter128

    (
        input i_start,
        input i_clk100MHz,
        input [127:0] i_text,
        output reg o_uartFinished,
        output tx,
        output isidle
    );
    
    
    // 32 bytes of text (256 bits) + 1 byte Carriage Return (8 bits) + 1 byte Line Feed (8 bits) = 34 bytes (272 bits)
    wire [271:0] ascii_with_lnbrk = {8'h0A, 8'h0D, ascii_pt};
    wire [255:0] ascii_pt;
    generate
        genvar i;
        for (i = 0; i < 32; i = i+1) begin
//            HexToAscii inst(.hex(i_text[(i*4)+3:i*4]), .ascii(ascii_pt[(i*8)+7:i*8]));
            HexToAscii inst(.hex(i_text[(i*4)+3:i*4]), .ascii(ascii_pt[((31 - i)*8) +: 8]));
        end
    endgenerate
    
    wire [7:0] dataToTransmit = ascii_with_lnbrk[(cnt * 8) +: 8];
    
    wire ss_uartTransmittedByte;
    uart_transmitter_datapath inst(.i_start(cs_transmitByte), .i_clk100MHz(i_clk100MHz), .i_data(dataToTransmit), .o_done(ss_uartTransmittedByte), .tx(tx));
         

        
    localparam IDLE = 2'b00;
    localparam TRANSMIT = 2'b01;
    localparam DONE = 2'b10;
    
    reg cs_transmitByte;
    
    reg [5:0] cnt = 0;
    reg [5:0] next_cnt = 0;
    
    reg [1:0] state = 0;
    reg [1:0] next_state = 0;
    always@(posedge i_clk100MHz) begin
        case(state)
            IDLE: begin 
                if (i_start) begin
                    next_state <= TRANSMIT;
                    cnt <= -1;
                end
            end
            TRANSMIT: begin 
                if (ss_uartTransmittedByte) begin
                    cnt <= cnt + 1;
                    if (cnt == 33) begin
                        next_state <= DONE;
                    end
                    

                end
                
                
            end
            DONE: begin 
                next_state <= IDLE;
//                next_cnt <= 0;
            end
            default: begin
                next_state <= IDLE;
//                next_cnt <= 0;
            end
        endcase
    end
    
    always@(posedge i_clk100MHz) begin
        state <= next_state;
//        cnt <= next_cnt;
    end
    
    always@(state or i_start or ss_uartTransmittedByte) begin
        case(state)
            IDLE: begin 
                o_uartFinished <= 0;
                cs_transmitByte <= 0;
            end
            TRANSMIT: begin 
                o_uartFinished <= 0;
                cs_transmitByte <= 1;
            end
            DONE: begin 
                o_uartFinished <= 1;
                cs_transmitByte <= 0;
            end
        endcase        
    end
    
    assign isidle = state == IDLE ? 1 : 0;
endmodule

module uart_transmitter_datapath
    #(
        parameter   DBITS = 8,          // number of data bits in a word
                    SB_TICK = 16,       // number of stop bit / oversampling ticks
                    BR_LIMIT = 651,     // baud rate generator counter limit
                    BR_BITS = 10,       // number of baud rate generator counter bits
                    FIFO_EXP = 2        // exponent for number of FIFO addresses (2^2 = 4)
    )
(
    input i_start,
    input i_clk100MHz,
    input [7:0] i_data,
    output o_done,
    output tx
);
    wire reset;
    assign reset = ~i_start;
    
    // Instantiate Modules for UART Core
    wire tick;                          // sample tick from baud rate generator
    baud_rate_generator 
        #(
            .M(BR_LIMIT), 
            .N(BR_BITS)
         ) 
        BAUD_RATE_GEN   
        (
            .clk_100MHz(i_clk100MHz), 
            .reset(reset),
            .tick(tick)
         );
    
    wire [7:0] res;
    uart_transmitter
        #(
            .DBITS(DBITS),
            .SB_TICK(SB_TICK)
         )
         UART_TX_UNIT
         (
            .clk_100MHz(i_clk100MHz),
            .reset(reset),
            .tx_start(i_start),
            .sample_tick(tick),
            .data_in(i_data),
            .tx_done(o_done),
            .tx(tx)
         );
endmodule

module HexToAscii(
    input [3:0] hex,
    output [7:0] ascii
);

    assign ascii = (hex < 4'hA)? 8'h30 + hex : 8'h37 + hex;

endmodule
