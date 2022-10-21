`timescale 1ns / 1ps

module fsm_buzzer(
    input i_clk,
    input i_reset,
    input [3:0] i_btn,
    output [15:0] o_freq,
    output [3:0] o_en
    );
    
    parameter IDLE = 0, SOUND1 = 1, SOUND2 = 2, SOUND3 = 3;
    reg [1:0] state = IDLE, next_state = IDLE;
    reg r_en = 0;
    reg [15:0] r_freq = 0;
    
    reg [31:0] time_counter;
    assign o_en = r_en;
    assign o_freq = r_freq;
    
    always @(posedge i_clk, posedge i_reset) begin
        if (i_reset) begin
            state <= IDLE;
            time_counter <= 0;
        end
        else begin
            if (state == IDLE) begin
                state <= next_state;
            end
            else begin
                if (time_counter == 49_999_999) begin
                    time_counter <= 0;
                    state <= next_state;
                end
                else begin
                    time_counter <= time_counter + 1;
                    state <= state;
                end
            end
            
        end
    end
    
    always @(state, i_btn) begin
        case (state)
            IDLE : begin
               if (i_btn[0]) begin
                    next_state <= SOUND1;
               end

               else if(i_btn[1]) begin
                    next_state <= SOUND2;
               end

               else if(i_btn[2]) begin
                    next_state <= SOUND3;
               end

               else begin
                    next_state <= IDLE;
               end               
            end
            
            // SOUND1 : next_state <= SOUND2;               
           
            // SOUND2 : next_state <= SOUND3;
                            
            // SOUND3 : next_state <= IDLE;
               
        endcase
    end
    
    always @(posedge i_clk) begin
        case (state)
            IDLE : begin
                r_en <= 1'b0;
            end
            SOUND1 : begin
                r_freq <= 1046;
                r_en <= 1'b1;                
            end
            SOUND2 : begin
                r_freq <= 1318;
                r_en <= 1'b1;                
            end
            SOUND3 : begin
                r_freq <= 1569;
                r_en <= 1'b1;                
            end
        endcase
    end
    
endmodule


