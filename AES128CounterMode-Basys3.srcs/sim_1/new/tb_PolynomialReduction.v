`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2024 02:59:09 PM
// Design Name: 
// Module Name: tb_PolynomialReduction
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


module tb_PolynomialReduction(

    );
    
    initial begin
        #50 $finish();
    end
    
    reg [8:0] dividend;
    wire [7:0] result;
    
    PolynomialReduction inst(.i_dividend(dividend), .o_remainder(result));
    
    initial begin
        dividend = 9'b101011111;
    end
endmodule
