`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2024 02:13:03 PM
// Design Name: 
// Module Name: ByteSubstitution
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


module ByteSubstitution(
        input [127:0] i_block,
        output [127:0] o_block
    );
    
    generate
        genvar i;
        
        for (i = 0; i < 16; i = i + 1) begin
            wire [7:0] sbox_in = i_block[(i*8)+7:(i*8)];
            SBox sbox(.di(sbox_in), .do(o_block[(i*8)+7:(i*8)]));
        end
    
    endgenerate
    
endmodule
