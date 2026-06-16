// 1. ????????????? ??????? ?? ???????? ????????
module bitsum (A, B, S, Cin, Cout);
    input A, B, Cin;
    output S, Cout;
    wire c1, c2, Res;
    
    xor(Res, A, B);
    and(c1, A, B);
    xor(S, Cin, Res);
    and(c2, Cin, Res);
    or(Cout, c1, c2);
endmodule

// 2. 7-????????? ???????
module my_sum_7bit (Ain, Bin, Ci, Sout, Co);
    input [6:0] Ain, Bin;
    input Ci;
    output [6:0] Sout;
    output Co;
    wire [6:0] C; // ????????? ???????????

    bitsum sum0(Ain[0], Bin[0], Sout[0], Ci,   C[0]);
    bitsum sum1(Ain[1], Bin[1], Sout[1], C[0], C[1]);
    bitsum sum2(Ain[2], Bin[2], Sout[2], C[1], C[2]);
    bitsum sum3(Ain[3], Bin[3], Sout[3], C[2], C[3]);
    bitsum sum4(Ain[4], Bin[4], Sout[4], C[3], C[4]);
    bitsum sum5(Ain[5], Bin[5], Sout[5], C[4], C[5]);
    bitsum sum6(Ain[6], Bin[6], Sout[6], C[5], C[6]);

    assign Co = C[6];
endmodule

// 3. 7-????????? ??????? (???????????? ????)
module ref_sum_7bit (Ain, Bin, Ci, Sout, Co);
    input [6:0] Ain, Bin;
    input Ci;
    output [6:0] Sout;
    output Co;
    reg [7:0] S; // 8 ??? ??? ?????????? ???? + ???????????

    always @(Ain, Bin, Ci)
        S = Ain + Bin + Ci;
        
    assign Sout = S[6:0];
    assign Co = S[7];
endmodule

// 4. testbench
module test_sum_7bit;
    wire Ci, cm, cr;
    wire [6:0] Ain, Bin;
    reg [6:0] Ain_r, Bin_r;
    reg Ci_r;
    wire [6:0] res_my, res_ref;

    // ??????????? ?????? ??????
    my_sum_7bit my_block (Ain, Bin, Ci, res_my, cm);
    ref_sum_7bit ref_block (Ain, Bin, Ci, res_ref, cr);

    initial begin
        $display("\t\t Time Ain Bin Ci res_my cm res_ref cr");
        $monitor($time,,,,,Ain,,,,,Bin,,,,,Ci,,,,,res_my,,,,,,,,cm,,,,,,,res_ref,,,,,,,cr);
        #400 $finish;
    end

    // ????????? 7-????? ????? (??? 0 ?? 127)
    initial begin
        Ain_r = 7'd12;
        #50 Ain_r = 7'd45;
        #50 Ain_r = 7'd100;
        #50 Ain_r = 7'd120;
        #50 Ain_r = 7'd5;
        #50 Ain_r = 7'd127;
        #50 Ain_r = 7'd50;
        #50 Ain_r = 7'd88;
    end

    initial begin
        Bin_r = 7'd8;
        #100 Bin_r = 7'd20;
        #100 Bin_r = 7'd15;
        #100 Bin_r = 7'd100;
    end

    initial begin
        Ci_r = 1'b0;
        #200 Ci_r = 1'b1;
    end

    assign Ain = Ain_r;
    assign Bin = Bin_r;
    assign Ci = Ci_r;
endmodule