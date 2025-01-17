`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2024 02:11:28 PM
// Design Name: 
// Module Name: Round
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


module Round(
        input [127:0] i_block,
        input [127:0] i_key,
        input i_isRound10,
        input [7:0] i_addition,
        output [127:0] o_block,
        output [127:0] o_key
    );
    
    wire [127:0] after_transform;
    Transform inst0(
        .i_key(i_key),
        .o_key(after_transform),
        .i_addition(i_addition)
    );
    
    
    wire [127:0] after_byte_subs;
    
    ByteSubstitution inst(
        .i_block(i_block),
        .o_block(after_byte_subs)
    );
    
    wire [127:0] after_shift_rows;
    ShiftRows inst2(
        .di(after_byte_subs),
        .do(after_shift_rows)
    );
    
    wire [127:0] after_mix_columns;
    MixColumns inst3(
        .i_block(after_shift_rows),
        .o_block(after_mix_columns)
    );
    
    wire [127:0] before_key_addition;
    assign before_key_addition = i_isRound10 ? after_shift_rows : after_mix_columns;
    
    assign o_block = before_key_addition ^ after_transform;
    assign o_key = after_transform;
endmodule
