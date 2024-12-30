//This is full adder


// module full_adder_using_mux (
// 	in1,
//   	in2,
//   	c_in,
//   	sum_o,
//   	c_out

// );
  
  
//   input in1;
//   input in2;
//   input c_in;
//   output sum_o;
//   output c_out;
  
  
//   assign sum_o = in2 ^ c_in ? !in1 : in1;
//   assign c_out = in2 ^ c_in ?  in1 : in2;
  
  
// endmodule



//This is counter

module counter_register (
	clk,
  	rst_n,
  	d,
  	wr,
  	q
  	

);
  
  
  input clk;
  input rst_n;
  input d;
  input wr;
  output q;
  
  reg q_reg;
  
  
  always@(negedge clk or negedge rst_n or posedge wr) begin
    if(!rst_n) q_reg <= 1'b0;
    
    else begin
    	if(wr) q_reg <= d;
    	else q_reg <= !q;
    end
    
  end
  
  
  assign q = q_reg;
  
endmodule


module counter_using_mux (
	clk,
  	rst_n,
  	in1,
  	wr,
  	out1
  
);
  
  
  input clk;
  input rst_n;
  input [3:0]  in1;
  input wr;
  output [3:0] out1;
  
  counter_register counter_reg_inst_1 (clk,rst_n,in1[0],wr,out1[0]);
  
  counter_register counter_reg_inst_2 (out1[0],rst_n,in1[1],wr,out1[1]);
  
  counter_register counter_reg_inst_3 (out1[1],rst_n,in1[2],wr,out1[2]);
  
  counter_register counter_reg_inst_4 (out1[2],rst_n,in1[3],wr,out1[3]);
  
endmodule