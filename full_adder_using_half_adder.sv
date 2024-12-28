module half_adder (
    input1,
    input2,
    sum_ha,
    carry_ha
);

    input input1;
    input input2;
    output sum_ha;
    output carry_ha;

    assign sum_ha   = input1 ^ input2;
    assign carry_ha = input1 && input2; 
    
endmodule



module full_adder (
    in1,
    in2,
    carry_in,
    sum,
    carry_out
);

    input in1;
    input in2;
    input carry_in;
    output sum;
    output carry_out;

    wire int1,int2,int3;

    half_adder half_adder_inst_1 (in1,in2,int1,int2);
    half_adder half_adder_inst_2 (int1,carry_in,sum,int3);

    assign carry_out = int3 || int2;
    
endmodule