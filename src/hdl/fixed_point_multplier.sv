//===========================================================
//
//			asychronus fixed point multiplier
//
//			Implemented by Mehran Mazaheri
//          
//          Note that (C_WORD_LEN - C_FRAC_LEN) must be bigger than or equal to (A_WORD_LEN - A_FRAC_LEN) + (B_WORD_LEN - B_FRAC_LEN)
//          this means max(error of truncation) is less than one
//===========================================================
`define min(a, b) (a<b?a:b)
`define max(a, b) (a<b?b:a)
`define diff(a, b) (`max(a, b)-`min(a,b))
module fixed_point_multiplier #(
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
    input wire signed [A_WORD_LEN-1:0]a,
    input wire signed [B_WORD_LEN-1:0]b,
    output wire signed [C_WORD_LEN-1:0]c
);
//--------------------------------------- wire deceleration
    wire signed [C_INT_LEN + A_FRAC_LEN + B_FRAC_LEN - 1:0] multiplier_output;
//---------------------------------------------------------
//--------------------------------------- continuous assignment
    generate
        if (C_FRAC_LEN > A_FRAC_LEN + B_FRAC_LEN) begin
            assign c = {multiplier_output,{`diff(C_FRAC_LEN, A_FRAC_LEN + B_FRAC_LEN){1'b0}}};
        end else begin
            assign c = multiplier_output[C_INT_LEN + A_FRAC_LEN + B_FRAC_LEN - 1:A_FRAC_LEN + B_FRAC_LEN - C_FRAC_LEN];
        end
    endgenerate
    assign multiplier_output = a * b;
//---------------------------------------------------------
    
endmodule