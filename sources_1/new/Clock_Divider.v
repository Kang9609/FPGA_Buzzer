`timescale 1ns / 1ps


module freq_gen(
    input i_clk,
    input i_reset,
    input [15:0] i_freq,
    input [3:0] i_en,
    output o_clk
    );
    
    reg [31:0] counter = 0;
    reg r_clk = 0;
    
    assign o_clk = r_clk;
    
    always @(posedge i_clk, posedge i_reset, posedge i_en) begin
        if (i_reset) begin
            counter <= 0;
            r_clk <= 0;
        end
        else begin
            if (i_en) begin
                if (counter == (50_000_000 / i_freq) - 1) begin
                    counter <= 0;
                    r_clk <= ~r_clk;
                end
                else begin
                    counter <= counter + 1;
                end
            end
            else begin
                r_clk <= 1'b0;
            end
        end
    end
endmodule

