`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2024 10:45:14 PM
// Design Name: 
// Module Name: AES_Core
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


module AES_Core(
        input clk,
        input i_start,
        input [127:0] i_plaintext,
        input [127:0] i_key,
        output [127:0] o_ciphertext,
        output o_finished,
        output o_isidle,
        output o_isnotidle,
        output o_isstarting
    );
    
//    reg [7:0] rc[0:9];
//    initial begin
//        $readmemh("round_coeff.mem", rc, 0, 9);
//    end

    
    dist_mem_ROUNDCOEFF in(
        .a(state),
        .spo(addition)
    );
    
    wire isRound10;
    wire isRound0;
    wire [3:0] state;

    wire [7:0] addition;
//    assign addition = rc[state];
    
    wire o_doRound;
    
    AES_Control control(
        .i_start(i_start),
        .clk(clk),
        .o_isRound10(isRound10),
        .o_isRound0(isRound0),
        .o_round(state),
        .o_doRound(o_doRound),
        .o_done(o_finished),
        .o_isidle(o_isidle),
        .o_isnotidle(o_isnotidle),
        .o_isstarting(o_isstarting)
    );

    AES_Datapath datapath(
        .i_plaintext(i_plaintext),
        .i_initialKey(i_key),
        .i_doRound(o_doRound),
        .i_isRound10(isRound10),
        .i_isRound0(isRound0),
        .i_addition(addition),
        .clk(clk),
        .o_ciphertext(o_ciphertext)
    );
    
    
    
    assign o_state = state;
        
    
endmodule
