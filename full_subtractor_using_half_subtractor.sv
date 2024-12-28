module half_subtractor (
    input1,
    input2,
    sub_hs,
    borrow_hs
);

    input input1;
    input input2;
    output sub_hs;
    output borrow_hs;

    assign sub_hs   = input1 ^ input2;
    assign borrow_hs = !input1 && input2; 
    
endmodule



module full_subtractor (
    in1,
    in2,
    borrow_in,
    sub,
    borrow_out
);

    input in1;
    input in2;
    input borrow_in;
    output sub;
    output borrow_out;

    wire int1,int2,int3;

    half_subtractor half_subtractor_inst_1 (in1,in2,int1,int2);
    half_subtractor half_subtractor_inst_2 (int1,borrow_in,sum,int3);

    assign borrow_out = int3 || int2;
    
endmodule