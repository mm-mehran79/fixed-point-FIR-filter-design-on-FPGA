//===========================================================
//
//			asychronus fixed point IIR filter
//
//			Implemented by Mehran Mazaheri
//          
//          fixed point adder & multiplier must be compiled before
//          
//===========================================================
module iir_filter #(
    parameter WORD_LEN_IN,
    parameter WORD_FRAC_IN,
    parameter WORD_LEN_OUT,
    parameter WORD_FRAC_OUT,
    parameter WORD_LEN_COEF,
    parameter WORD_FRAC_COEF,
    parameter WORD_LEN_INTER,
    parameter WORD_FRAC_INTER
) (
    input wire signed [WORD_LEN_IN-1:0]x,
    input wire signed [WORD_LEN_COEF-1:0]a1,b0,b1,
    output wire signed [WORD_LEN_OUT-1:0]y
);
    
endmodule