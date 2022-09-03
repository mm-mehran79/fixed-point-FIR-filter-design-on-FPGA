//===========================================================
//
//			asychronus fixed point adder
//
//			Implemented by Mehran Mazaheri
//          
//          
//===========================================================
`define minus(a, b) (a-b)
`define min(a, b) (a<b?a:b)
`define max(a, b) (a<b?b:a)
`define diff(a, b) (`max(a, b)-`min(a,b))
`timescale 1ns/1ns
module fixed_point_adder #(
    parameter A_FRAC_LEN = 8,
    parameter A_WORD_LEN = 9,
    parameter B_FRAC_LEN = 8,
    parameter B_WORD_LEN = 9,
    parameter C_FRAC_LEN = 8,
    parameter C_WORD_LEN = 10,
    parameter A_INT_LEN = A_WORD_LEN - A_FRAC_LEN,
    parameter B_INT_LEN = B_WORD_LEN - B_FRAC_LEN,
    parameter C_INT_LEN = C_WORD_LEN - C_FRAC_LEN
) (
    input wire [A_WORD_LEN-1:0]a,
    input wire [B_WORD_LEN-1:0]b,
    output wire [C_WORD_LEN-1:0]c
);
//--------------------------------------- wire deceleration
    wire signed [C_INT_LEN + `max(A_FRAC_LEN, B_FRAC_LEN) - 1:0] adder_output;
    wire signed [`min(A_WORD_LEN, B_WORD_LEN) - 1:0] input_small;
    wire signed [`max(A_WORD_LEN, B_WORD_LEN) - 1:0] input_large; // greatness isn't based on value, it is based on fraction length. (real life: it is based on morality ;) )
//---------------------------------------------------------
//--------------------------------------- continuous assignment
generate
    if (A_FRAC_LEN < B_FRAC_LEN) begin
        assign input_small = a;
        assign input_large = b;
    end else begin
        assign input_small = b;
        assign input_large = a;
    end
    if (C_FRAC_LEN > `max(A_FRAC_LEN, B_FRAC_LEN)) begin
        assign c = {adder_output[C_INT_LEN + `max(A_FRAC_LEN, B_FRAC_LEN) - 1:0], {`diff(`max(A_FRAC_LEN, B_FRAC_LEN), C_FRAC_LEN){1'b0}}};
    end else begin
        assign c = adder_output[C_INT_LEN + `max(A_FRAC_LEN, B_FRAC_LEN) - 1:C_INT_LEN + `max(A_FRAC_LEN, B_FRAC_LEN) - C_WORD_LEN];
    end
endgenerate
    assign adder_output = input_large + {input_small, {(`diff(A_FRAC_LEN, B_FRAC_LEN)){1'b0}}};
//---------------------------------------------------------
endmodule
