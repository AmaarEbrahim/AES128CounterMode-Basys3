`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2024 02:16:33 PM
// Design Name: 
// Module Name: AES_Control
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


module AES_Control(
        input i_start,
        input clk,
        output reg o_isRound0,
        output reg o_isRound10,
        output reg [3:0] o_round,
        output reg o_doRound,
        output reg o_done,
        output o_isidle,
        output o_isnotidle,
        output o_isstarting
                
    );
    
    
    localparam [3:0]    idle  = 4'hc,
                        r0 = 4'h0,
                        r1 = 4'h1,
                        r2  = 4'h2,
                        r3  = 4'h3,
                        r4  = 4'h4,
                        r5  = 4'h5,
                        r6  = 4'h6,
                        r7  = 4'h7,
                        r8  = 4'h8,
                        r9  = 4'h9,
                        r10  = 4'ha,
                        rdone  = 4'hb;
    
    reg [3:0] state = idle;
    reg [3:0] next_state = idle;
    
    always@(state or i_start) begin
        case(state)
            idle: begin 
                if (i_start) begin
                    next_state = r0;
                end else begin
                    next_state = idle;
                end
            end
            r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10: begin 
                next_state = state + 1;
            end
            rdone: begin 
                next_state = idle;
            end
        endcase
    end
    
    always@(posedge clk) begin
        state <= next_state;
    end
    
    always@(state or i_start) begin
        o_isRound0 = 0;
        o_doRound = 0;
        o_isRound10 = 0;
        o_round = state - 1;
        o_done = 0;
        case(state)
            idle: begin
                o_done = 0;
            end
            r0: begin
                o_isRound0 = 1;
            end
            r1, r2, r3, r4, r5, r6, r7, r8, r9, r10: begin 
                o_doRound = 1;
                o_isRound10 = (state == r10)? 1 : 0;
            end
            rdone: begin
                o_done = 1;
            end
        endcase  
    end
    
    assign o_isidle = state == idle;
    assign o_isnotidle = state != idle;
    assign o_isstarting = i_start;
//    always@(posedge clk or state) begin
////        o_isRound1 <= 0;
////        o_isRound10 <= 0;
////        o_round <= state - 1;
////        o_saveResult <= 0;
        
//        case(state)
////            r1: o_isRound1 <= 1;
////            r10: begin o_isRound10 <= 1; o_saveResult <= 1; end
//        endcase
//    end
    
endmodule
