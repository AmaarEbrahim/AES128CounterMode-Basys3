`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2024 02:15:45 PM
// Design Name: 
// Module Name: MixColumns
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


module MixColumns(
        input [127:0] i_block,
        output [127:0] o_block
    );
    
    generate
        genvar i;
        for (i = 0; i < 4; i = i + 1) begin
            Multiplier inst(
                .i_word(i_block[(i*32)+31:(i*32)]),
                .o_word(o_block[(i*32)+31:(i*32)])
            );
        end
    endgenerate
    
    
endmodule

module Multiplier(
        input [31:0] i_word,
        input [31:0] o_word
);

    wire [31:0] row1_word;
    wire [7:0] row1_byte;
    assign row1_word = i_word;
    Row inst(.i_word(row1_word), .o_byte(row1_byte));
    
    wire [31:0] row2_word;
    wire [7:0] row2_byte;
    assign row2_word = {row1_word[7:0], row1_word[31:8]};
    Row inst2(.i_word(row2_word), .o_byte(row2_byte));


    wire [31:0] row3_word;
    wire [7:0] row3_byte;
    assign row3_word = {row2_word[7:0], row2_word[31:8]};
    Row inst3(.i_word(row3_word), .o_byte(row3_byte));

    
    wire [31:0] row4_word;
    wire [7:0] row4_byte;
    assign row4_word = {row3_word[7:0], row3_word[31:8]};
    Row inst4 (.i_word(row4_word), .o_byte(row4_byte));

    assign o_word = {row1_byte, row4_byte, row3_byte, row2_byte};


endmodule

// come up with a better design
module PolynomialReduction(
    input [8:0] i_dividend,
    output [7:0] o_remainder
);

    integer divisor = 9'b100011011; // ireducible polynomial x^8 + x^4 + x^3 + x + 1
    wire [8:0] inter;
    assign inter = i_dividend[8] ? (i_dividend ^ divisor) : i_dividend;
    assign o_remainder = inter[7:0];

endmodule

module Row(
        input [31:0] i_word,
        output [7:0] o_byte
);


    wire [8:0] e1 = i_word[31:24] << 1;
    wire [7:0] e1_out;
    PolynomialReduction p1(.i_dividend(e1), .o_remainder(e1_out));
    
    // 
    wire [8:0] e2 = (i_word[23:16] << 1) ^ i_word[23:16];
    wire [7:0] e2_out;
    PolynomialReduction p2(.i_dividend(e2), .o_remainder(e2_out));
    
    wire [7:0] e3 = i_word[15:8];
    
    wire [7:0] e4 = i_word[7:0];
    
    assign o_byte = (e1_out ^ e2_out) ^ (e3 ^ e4);
    

endmodule
