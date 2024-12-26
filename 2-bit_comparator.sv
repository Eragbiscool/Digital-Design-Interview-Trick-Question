module twobitcomparator (
    in1,
    in2,
    in1greater,
    in2greater,
    equal
);

    input [1:0] in1;
    input [1:0] in2;
    output in1greater;
    output in2greater;
    output equal;

    assign in1greater = (!in1[0] && in2[0]) + (!in1[0] && in2[1] && in2[0]) + (!in1[1] && !in1[0] && in2[0]) ;
    assign in2greater = (in1[0] && !in2[0]) + (in1[0] && !in2[1] && !in2[0]) + (in1[1] && in1[0] && !in2[0]) ;
    assign equal = !(in1[0] ^ in2[0]) && !(in1[0] ^ in2[0]);
    
endmodule