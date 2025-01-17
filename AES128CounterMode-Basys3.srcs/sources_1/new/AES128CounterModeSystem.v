module AES128CounterModeSystem(
    input i_rx,
    input i_clk_100MHz,
    input i_reset,
    input i_start,
    input i_mode,
    output o_tx
);

    parameter E_MODE_ENCRYPT = 0;
    parameter E_MODE_DECRYPT = 1;

    wire ss_finishedReceiving128bitData;
    wire ss_finishedTransmitting128bitData;
    wire ss_finishedEncrypting;
    wire ss_finishedDecrypting;

    parameter   S_IDLE = 0, 
                S_RX_NONCE = 1, 
                S_RX_KEY = 2, 
                S_RX_BLOCK = 3, 
                S_ENCRYPTING = 4, 
                S_DECRYPTING = 5, 
                S_TX_BLOCK = 6;

    reg [2:0] state;
    reg [2:0] next_state;

    always@(state) begin
        case(state)
            S_IDLE: begin 
                if (i_start)
                    next_state = S_RX_NONCE;
                else
                    next_state = S_IDLE;
            end
            S_RX_NONCE: begin 
                if (ss_finishedReceiving128bitData)
                    next_state = S_RX_KEY;
                else
                    next_state = S_RX_NONCE;
            end
            S_RX_KEY: begin 
                if (ss_finishedReceiving128bitData)
                    next_state = S_RX_BLOCK;
                else
                    next_state = S_RX_KEY;
            end
            S_RX_BLOCK: begin
                if (ss_finishedReceiving128bitData)
                    if (mode == E_MODE_ENCRYPT)
                        next_state = S_RX_IV;
                    else
                        next_state = S_RX_IV;
                        
                else
                    next_state = S_RX_BLOCK;                
            end

            S_ENCRYPTING: begin end
            S_DECRYPTING: begin end
            S_TX_BLOCK: begin end
        endcase     
    end

endmodule