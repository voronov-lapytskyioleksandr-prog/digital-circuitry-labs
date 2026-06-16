module encoder_bcd (x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, Q0, Q1, Q2, Q3);
    input x0, x1, x2, x3, x4, x5, x6, x7, x8, x9;
    output Q0, Q1, Q2, Q3;

    // ??????? ???????? ??? ????????? BCD (???? 1, 2, 4, 8)
    assign Q0 = x1 | x3 | x5 | x7 | x9;
    assign Q1 = x2 | x3 | x6 | x7;
    assign Q2 = x4 | x5 | x6 | x7;
    assign Q3 = x8 | x9;

endmodule
