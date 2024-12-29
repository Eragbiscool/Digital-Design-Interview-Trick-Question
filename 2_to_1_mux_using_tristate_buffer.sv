//This is a tristate buffer using mux

module tri_state_buffer (
	input1,
  	select,
  	output1
);
  
  input input1;
  input select;
  output output1;
  
  
  assign output1 = select ? input1 : 1'bz;
  
endmodule


module two_to_one_mux (
	in1,
  	in0,
  	sel,
  	out1
);
  
  input in1;
  input in0;
  input sel;
  output out1;
  
  
  tri_state_buffer tri_state_buffer_inst_1 (in1,sel,out1);
  
  tri_state_buffer tri_state_buffer_inst_2 (in0,!sel,out1);
  
  
endmodule