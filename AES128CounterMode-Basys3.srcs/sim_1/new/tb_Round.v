`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2024 09:00:51 PM
// Design Name: 
// Module Name: tb_Round
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


module tb_Round(

    );
    
    initial begin
        #50 $finish();
    end
    
    reg [127:0] key_mem [0:0];
    reg [127:0] key;
    reg [127:0] block_mem [0:0];
    reg [127:0] block;
    reg [7:0] addition;
    reg [127:0] added;
    
    reg isRound10 = 0;
    
    initial begin
    
    // https://legacy.cryptool.org/en/cto/aes-step-by-step
    // select 1 round
    //          least sig byte <--           --> most sig byte
    // key:     a7091750d3db09338d6d9dc6df70df80
    // block:   26F48833A9447A539671B660F0BEC1AE
    // set is isRound10 to 1
    // the website puts the least sig byte on the left. In Verilog, the most sig byte is on the left.
    // keep this in mind when formatting numbers.
        $readmemh("key128_01.mem", key_mem, 0, 0);
        key = key_mem[0];
        addition = 8'b00000001; // round 1 addition (RC[0])
        
        
        $readmemh("block128_02.mem", block_mem, 0, 0);
        block = block_mem[0];
//        block = "2e1ece2fa62b1c1b60739f7a639ffd81
        // in round 1, xor the block and key... hence this line
        added = block ^ key;
    end
    
    wire [127:0] blockOutput;
    wire [127:0] keyOutput;
        

    Round inst(.i_key(key), .i_block(added), .i_isRound10(isRound10), .o_key(keyOutput), .i_addition(addition), .o_block(blockOutput));
endmodule
