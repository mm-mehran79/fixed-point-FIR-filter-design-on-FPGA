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
    input wire clk,
    input wire reset,
    input wire signed [WORD_LEN_IN-1:0]x,
    input wire signed [WORD_LEN_COEF-1:0]a1,b0,b1,
    output wire signed [WORD_LEN_OUT-1:0]y
);
    reg [WORD_LEN_INTER-1:0] w;
    reg [WORD_LEN_INTER-1:0] wa, wb;
    always @(posedge clk) begin
        if (reset) begin
            w <= 0;//assume input is causal
        end else begin
            w <= v;
        end
    end

    fixed_point_multiplier #(    .A_FRAC_LEN(WORD_FRAC_INTER), 
                            .B_FRAC_LEN(WORD_FRAC_COEF),
                            .C_FRAC_LEN(WORD_FRAC_INTER),
                            .A_WORD_LEN(WORD_LEN_INTER),
                            .B_WORD_LEN(WORD_LEN_INTER),
                            .C_WORD_LEN(WORD_LEN_INTER)) wa_cal(
        .a(w),
        .b(a1),
        .c(wa)
    );
    fixed_point_multiplier #(    .A_FRAC_LEN(WORD_FRAC_INTER), 
                            .B_FRAC_LEN(WORD_FRAC_COEF),
                            .C_FRAC_LEN(WORD_FRAC_INTER),
                            .A_WORD_LEN(WORD_LEN_INTER),
                            .B_WORD_LEN(WORD_LEN_INTER),
                            .C_WORD_LEN(WORD_LEN_INTER)) wb1_cal(
        .a(w),
        .b(b1),
        .c(wb)
    );
    fixed_point_multiplier #(    .A_FRAC_LEN(WORD_FRAC_INTER), 
                            .B_FRAC_LEN(WORD_FRAC_COEF),
                            .C_FRAC_LEN(WORD_FRAC_INTER),
                            .A_WORD_LEN(WORD_LEN_INTER),
                            .B_WORD_LEN(WORD_LEN_INTER),
                            .C_WORD_LEN(WORD_LEN_INTER)) wb0_cal(
        .a(v),
        .b(b1),
        .c(vb)
    );

    fixed_point_adder #(    .A_FRAC_LEN(WORD_LEN_IN),
                            .B_FRAC_LEN(WORD_LEN_INTER),
                            .C_FRAC_LEN(WORD_LEN_INTER),
                            .A_WORD_LEN(WORD_FRAC_IN),
                            .B_WORD_LEN(WORD_FRAC_INTER),
                            .C_WORD_LEN(WORD_FRAC_INTER)) v_cal(
                        .a(x),
                        .b(-wa),
                        .c(v));
    fixed_point_adder #(    .A_FRAC_LEN(WORD_LEN_INTER),
                            .B_FRAC_LEN(WORD_LEN_INTER),
                            .C_FRAC_LEN(WORD_LEN_OUT),
                            .A_WORD_LEN(WORD_FRAC_INTER),
                            .B_WORD_LEN(WORD_FRAC_INTER),
                            .C_WORD_LEN(WORD_FRAC_OUT)) y_cal(
                        .a(vb),
                        .b(wb),
                        .c(y));

endmodule