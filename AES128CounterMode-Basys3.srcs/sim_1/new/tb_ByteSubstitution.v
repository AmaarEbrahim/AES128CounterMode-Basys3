`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2024 02:20:25 PM
// Design Name: 
// Module Name: tb_ByteSubstitution
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


module tb_ByteSubstitution(

    );
    
    initial begin
        #50 $finish();
    end
    
    
    reg [127:0] di;
    wire [127:0] do;
    
    ByteSubstitution inst(.i_block(di), .o_block(do));
    
    reg [127:0] data[0:0];
    initial begin
        $readmemh("block128_02.mem", data, 0, 0);
        di = data[0];
    end
    
endmodule
