// /*
// ################################
// This is the full adder used to create the
// Adder in our multiplier
// ################################
// */




module full_adder(in1, in2, carry_in, sum, carry_out);
  input in1;
  input in2;
  input carry_in;
  output sum;
  output carry_out;
  
  
  assign sum = in1 ^ in2 ^ carry_in;
  assign carry_out = (in1 & in2) | (in2 & carry_in) | (in1 & carry_in);
  
endmodule


/*
################################
This is the inverter module to invert any given input
################################
*/


module inverter (inverted, in1);
  input in1;
  output inverted;
  
  assign inverted = ~in1;
  
  
endmodule



module Booth_Adder #(parameter WIDTH) (in1,in2,sum);
  
  	input   [WIDTH-1:0] in1,in2;
	output  [WIDTH-1:0]sum;
  	
  
	wire cout;
	wire [WIDTH-1:0] q;
  	genvar i;
  
  
    full_adder fa_init1(in1[0],in2[0],1'b0,sum[0],q[0]); //Here 1'b1 in input_carry makes ib a 2's compliment of in2;
  	
  	generate	
  	
      for(i = 1; i < WIDTH; i++) begin
        full_adder fa0 (in1[i],in2[i],q[i-1],sum[i],q[i]);
      end
    
  	endgenerate
  

  
  
  assign cout = q[WIDTH-1];
	
endmodule


/*
################################
Subtractor Used to do this operation:

sub_storage = sum_storage - in2(multiplicand)
################################
*/

module Booth_Subtractor #(parameter WIDTH) (in1,in2,sum,cout);
  	input  [WIDTH-1:0] in1,in2;
  	output [WIDTH-1:0]sum;
  	output cout;
  
  	wire signed [WIDTH-1:0] ib;
	wire cout;
  	genvar i;
  
  
  generate	
  	
    for(i = 0; i < WIDTH; i++) begin
      inverter b0 (ib[i],in2[i]);
    end
    
  endgenerate
  


  	wire [WIDTH-1:0] q;
  	
  	full_adder fa_init1(in1[0],ib[0],1'b1,sum[0],q[0]); //Here 1'b1 in input_carry makes ib a 2's compliment of in2;
  	
  	generate	
  	
      for(i = 1; i < WIDTH; i++) begin
        full_adder fa0 (in1[i],ib[i],q[i-1],sum[i],q[i]);
      end
    
  	endgenerate

  
  assign cout = q[WIDTH-1];

endmodule



/*
################################
This is the internal operational unit for the multiplier.
################################
*/


module Booth_internal_step #(parameter WIDTH) (sum_storage,in2,input_carry_bit, in1, first_half_bits, last_half_bits, output_carry_bit);
  
  
  input signed [WIDTH-1:0] sum_storage;
  input signed [WIDTH-1:0] in1;
  input signed [WIDTH-1:0] in2;
  input  input_carry_bit;
  output reg signed  output_carry_bit;
  output reg signed  [WIDTH-1:0] first_half_bits;
  output reg signed  [WIDTH-1:0] last_half_bits;
  
  wire signed [WIDTH-1:0] addam,subam;
  wire cout;
	
  Booth_Adder 		#(WIDTH) myadd(sum_storage,in1,addam);
  Booth_Subtractor 	#(WIDTH) mysub(sum_storage,in1,subam,cout);
  
  always @(*) begin	
    
/*
################################
if we have in2 & input_carry_bit's value as 0 0 or 1 1
################################
*/
    
	if(in2[0] == input_carry_bit) begin
		
      	output_carry_bit 				= in2[0]			;
        last_half_bits 					= $signed(in2)>>>1			;
	    last_half_bits[WIDTH-1] 		= sum_storage[0]	;
		first_half_bits 				= sum_storage >>> 1	;
      	
    end

/*
################################
if we have in2 & input_carry_bit's value as 1 0
################################
*/    
    
    else if(in2[0] == 1 && input_carry_bit ==0) begin
      
        output_carry_bit	 				= in2[0];
        last_half_bits	 					= $signed(in2)>>>1;
        last_half_bits[WIDTH-1] 			= subam[0];
      
        if(in1 == -in1) first_half_bits 	= subam >>1;
        else first_half_bits 				= subam >>>1;
      
      
    end

/*
################################
if we have in2 & input_carry_bit's value as 0 1
################################
*/    
    
    
    else begin
      
        output_carry_bit 				= in2[0];
      	last_half_bits 					= $signed(in2)>>>1 ;
        last_half_bits[WIDTH-1] 		= addam[0];
      	first_half_bits 				= addam >>>1;

    end
    
end	
endmodule 



/*
################################
This is the main booth multiplier

*****
Change the parameter in the instantiation of "booth_multiplier" module in testbench
*****
################################
*/


module booth_multiplier #(parameter WIDTH) (in1, in2, multiplied);
  input signed [WIDTH-1:0] in1, in2;
  output signed [2*WIDTH-1:0] multiplied;

  wire signed [WIDTH-1:0] Q[WIDTH];
  wire signed [WIDTH-1:0] A[WIDTH];
  wire signed [WIDTH-1:0] q0;
  wire qout;
  
  Booth_internal_step #(WIDTH) step1(
    {WIDTH{1'b0}}, in2, 1'b0, in1, A[0], Q[0], q0[0]
  );

  genvar i;
  generate
    for (i = 0; i < WIDTH-1; i++) begin
      Booth_internal_step #(WIDTH) step0(
        A[i], Q[i], q0[i], in1, A[i+1], Q[i+1], q0[i+1]
      );
    end
  endgenerate

  assign multiplied = {$signed(A[WIDTH-1]), $signed(Q[WIDTH-1])};
  assign qout = q0[WIDTH-1];
  
  
  
endmodule

