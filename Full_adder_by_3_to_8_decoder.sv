// Code your design here

module decoder3x8 (
	en,
  	input1,
  	output1

);
  
  input en;
  input [2:0] input1;
  output [7:0] output1;
  
  
  assign output1[0] = en && !input1[2] && !input1[1] && !input1[0];
  assign output1[1] = en && !input1[2] && !input1[1] &&  input1[0];
  assign output1[2] = en && !input1[2] &&  input1[1] && !input1[0];
  assign output1[3] = en && !input1[2] &&  input1[1] &&  input1[0];
  assign output1[4] = en && input1[2] && !input1[1] && !input1[0];
  assign output1[5] = en && input1[2] && !input1[1] &&  input1[0];
  assign output1[6] = en && input1[2] &&  input1[1] && !input1[0];
  assign output1[7] = en && input1[2] &&  input1[1] &&  input1[0];
  
  
  
endmodule



module full_adder(
	in1,
  	in2,
  	c_in,
  	sum,
  	carry_out
);
  
  input in1;
  input in2;
  input c_in;
  output sum;
  output carry_out;
  
  wire [2:0] input_to_dec = {in1, in2, c_in};
  wire [7:0] out_from_dec;
  
  decoder3x8 decoder_inst_1(1'b1,input_to_dec,out_from_dec);
  
  assign sum 	   = out_from_dec[7] || out_from_dec[4] || out_from_dec[2] || out_from_dec[1];
  
  assign carry_out = out_from_dec[7] || out_from_dec[6] || out_from_dec[5] || out_from_dec[3];
  
  
  
endmodule