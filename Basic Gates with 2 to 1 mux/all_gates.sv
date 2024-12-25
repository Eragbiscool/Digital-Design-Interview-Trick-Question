module and_gate (
    in1,
    in2,
    out1
);

    input in1;
    input in2;
    output out1;


    assign out1 = in2 ? in1 : 1'b0;  // This will give "out1 = in1.in2 + 0.in2"

endmodule

module or_gate (
    in1,
    in2,
    out1
);

input in1;
input in2;
output out1;

assign out1 = in1 ? 1'b1: in2;      // This will give "out1 = 1.in1 + in2.in1` which eventually gives out1 = in1 + in2"
    
endmodule

module not_gate (
    in1,
    out1
);

    input in1;
    output out1;

    assign out1 = in1 ? 1'b0 : 1'b1;    // This will give "out1 = 0.in1 + 1.in1` "

endmodule

module nand_gate (in1, in2, out1);

    input in1;
    input in2;
    output out1;

    wire int1;

   assign int1 = in2 ? in1 : 1'b0;
   assign out1 = int1 ? 1'b0 : 1'b1;    // Here we are just taking the above mentioned and-gate logic and added a not gate with the output of it

endmodule


module nor_gate (in1, in2, out1);

    input in1;
    input in2;
    output out1;

    wire int1;

   assign int1 = in1 ? 1'b1: in2;
   assign out1 = int1 ? 1'b0 : 1'b1;   // Here we are just taking the above mentioned or-gate logic and added a not gate with the output of it

endmodule


module xor_gate (
    in1,
    in2,
    out1
);

    input in1;
    input in2;
    output out1;

    wire int1;

    assign int1 = in1 ? 1'b0 : 1'b1;    // This will give "int1 = 0.in1 + 1.in1` "

    assign out1 = in2 ? int1 : in1;     // This will give "out1 = int1.in2 + in1.in2` where int1 actually is in1` "


endmodule


module xnor_gate (
    in1,
    in2,
    out1
);

    input in1;
    input in2;
    output out1;

    wire int1;

    assign int1 = in1 ? 1'b0 : 1'b1;    // This will give "int1 = 0.in1 + 1.in1` "

    assign out1 = in2 ? in1 : int1;     // This will give "out1 = in1.in2 + int1.in2` where int1 actually is in1` "


endmodule
