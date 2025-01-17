`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2024 08:51:23 PM
// Design Name: 
// Module Name: tb_SBox
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


module tb_SBox(

    );
    
    initial begin
        #50 $finish();
    end
    
    
    reg [7:0] di;
    wire [7:0] do;
    
    SBox inst(.di(di), .do(do));
    
    initial begin
        di = 8'h00;
        #10 di = 8'h01;
        #10 di = 8'h23;
        #10 di = 8'h6A;
        #10 di = 8'hFF;
    end
endmodule

