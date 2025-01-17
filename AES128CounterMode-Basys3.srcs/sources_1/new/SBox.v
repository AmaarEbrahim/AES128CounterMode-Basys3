`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2024 08:17:15 PM
// Design Name: 
// Module Name: SBox
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


module SBox(
        input [7:0] di,
        output [7:0] do
        
    );
    
    reg [7:0] sbox_data[0:255];
    
//    initial begin
//        $readmemh("sbox_mem.coe", sbox_data, 0, 255);
//    end
    
    dist_mem_SBOX in(
        .a(di),
        .spo(do)
    );
    
//    assign do = sbox_data[di];
    
    
endmodule

