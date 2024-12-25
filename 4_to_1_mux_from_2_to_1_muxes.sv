module 2to1 (
    in1,
    in0,
    sel,
    out1
);

    always(*) begin
        if(sel) out1 = in1;
        else out1 = in0; 
    end

endmodule

module 4to1 (
    in1,
    in2,
    in3,
    in4,
    sel
    out1
);

    input in1;
    input in2;
    input in3;
    input in4;
    input [1:0] sel;
    output out1;

    wire int1,int2;

    2to1 2to1_inst1(in1, in2, sel[0], int1);
    2to1 2to1_inst2(in3, in4, sel[0], int2);
    2to1 2to1_inst3(int1, int2, sel[1], out1);

endmodule