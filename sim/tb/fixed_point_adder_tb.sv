//===========================================================
//
//			asychronus fixed point adder testbench
//
//			Implemented by Mehran Mazaheri
//          
//          
//===========================================================
`timescale 1ns/1ns
module fixed_point_adder_tb #(
    parameter A_FRAC_LEN = 2,
    parameter A_WORD_LEN = 4,
    parameter B_FRAC_LEN = 3,
    parameter B_WORD_LEN = 7,
    parameter C_FRAC_LEN = 2,
    parameter C_WORD_LEN = 7
);
    reg signed [A_WORD_LEN - 1:0] a;
    reg signed [B_WORD_LEN - 1:0] b;
    
    initial begin
        a = $random();
        b = $random();
        #3;
        $stop;  
    end
    fixed_point_adder #(    .A_FRAC_LEN(A_FRAC_LEN),
                            .B_FRAC_LEN(B_FRAC_LEN),
                            .C_FRAC_LEN(C_FRAC_LEN),
                            .A_WORD_LEN(A_WORD_LEN),
                            .B_WORD_LEN(B_WORD_LEN),
                            .C_WORD_LEN(C_WORD_LEN)) uut(
        .a(a),
        .b(b),
        .c()
    );
endmodule