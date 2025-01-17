`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2024 08:17:09 PM
// Design Name: 
// Module Name: tb_Transform
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


module tb_Transform(

    );
    
    initial begin
        #50 $finish();
    end
    
    reg [127:0] key_mem [0:0];
    reg [127:0] key;
    reg [7:0] addition;
    
    initial begin
        $readmemh("key128_01.mem", key_mem, 0, 0);
        key = key_mem[0];
        addition = 8'b00000001;
        
        
        // verify with slide 2 of https://www.kavaliro.com/wp-content/uploads/2014/03/AES.pdf
//        #5
//        $readmemh("key128_02.mem", key_mem, 0, 0);
//        key = key_mem[0];        
//        addition = 8'b00000001;
        
    end
    
    wire [127:0] keyOutput;
    
    Transform inst(.i_key(key), .o_key(keyOutput), .i_addition(addition));
endmodule
