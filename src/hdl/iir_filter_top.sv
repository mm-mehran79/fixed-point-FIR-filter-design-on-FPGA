`timescale 1ns/1ns
module stuff_or_data_top
#(
    parameter WORD_LEN_IN = 17,
    parameter WORD_FRAC_IN = 16,
    parameter WORD_LEN_OUT = 17,
    parameter WORD_FRAC_OUT = 16,
    parameter WORD_LEN_COEF = 17,
    parameter WORD_FRAC_COEF = 16,
    parameter WORD_LEN_INTER = 17,
    parameter WORD_FRAC_INTER = 16
)
(
    input wire clk,
    input wire reset,
    input wire signed [WORD_LEN_IN-1:0]x,
    input wire signed [WORD_LEN_COEF-1:0]a1,b0,b1,
    output wire signed [WORD_LEN_OUT-1:0]y
);
    wire sys_clk;

    IBUF ibufg_inst
    (
        .I(clk),
        .O(sys_clk)
    );

    iir_filter 
    #(  .WORD_LEN_IN(WORD_LEN_IN),
        .WORD_FRAC_IN(WORD_FRAC_IN),
        .WORD_LEN_OUT(WORD_LEN_OUT),
        .WORD_FRAC_OUT(WORD_FRAC_OUT),
        .WORD_LEN_COEF(WORD_LEN_COEF),
        .WORD_FRAC_COEF(WORD_FRAC_COEF),
        .WORD_LEN_INTER(WORD_LEN_INTER),
        .WORD_FRAC_INTER(WORD_LEN_INTER)
        ) uut
    (
        .clk(sys_clk),
        .reset(reset),
        .x(x),
        .a1(a1),
        .b0(b0),
        .b1(b1),
        .y(y)
    );

endmodule