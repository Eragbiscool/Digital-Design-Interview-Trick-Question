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



module decoder4x16 (
	en,
  	input1,
  	output1
);
  
  
  input en;
  input [3:0] input1;
  input [15:0] output1;
  
  decoder3x8 dec3x8_inst_1(en && !input1[3],input1[2:0],output1[7:0]);
  decoder3x8 dec3x8_inst_2(en && input1[3] ,input1[2:0],output1[15:8]);
  
  
  
endmodule