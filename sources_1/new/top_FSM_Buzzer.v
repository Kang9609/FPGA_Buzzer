`timescale 1ns / 1ps

module top_fsm_buzzer(
    input i_clk,
    input [3:0] i_btn,
    input i_reset,
    output o_freq
    );
    
    wire [15:0] w_freq;
    wire [3:0] w_en;
    
    fsm_buzzer u0(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .i_btn(i_btn),
    .o_freq(w_freq),
    .o_en(w_en)
    );
    
    freq_gen u1(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .i_freq(w_freq),
    .i_en(w_en),
    .o_clk(o_freq)
    );    
    
endmodule

