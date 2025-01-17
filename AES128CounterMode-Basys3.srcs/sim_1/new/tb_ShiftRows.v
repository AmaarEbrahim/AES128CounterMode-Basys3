`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2024 09:15:52 PM
// Design Name: 
// Module Name: tb_ShiftRows
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


module tb_ShiftRows(

    );
    
    initial begin
        #50 $finish();
    end
    
    reg [127:0] di;
    
    reg [127:0] data[0:0];
    initial begin
        $readmemh("block128_02.mem", data, 0, 0);
        di = data[0];
    end
    
    wire [127:0] do;
    
    ShiftRows inst(.di(di), .do(do));
   
endmodule
