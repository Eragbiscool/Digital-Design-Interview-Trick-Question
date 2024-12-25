module twoto1 (
    input1,
    input0,
    select,
    out_two_to_1
);
  
  input input1;
  input input0;
  input select;
  output reg out_two_to_1;
	
  always@(*) begin
        if(select) out_two_to_1 = input1;
        else out_two_to_1 = input0; 
  end

endmodule


module fourto1 (
    in1,
    in2,
    in3,
    in4,
    sel,
    out1
);

    input in1;
    input in2;
    input in3;
    input in4;
    input [1:0] sel;
    output out1;

    wire int1,int2;

    twoto1 twoto1_inst1(in1, in2, sel[0], int1);
    twoto1 twoto1_inst2(in3, in4, sel[0], int2);
    twoto1 twoto1_inst3(int1, int2, sel[1], out1);

endmodule
