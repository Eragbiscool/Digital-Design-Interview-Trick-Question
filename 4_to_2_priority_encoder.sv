// behavioral model design(Generic)


// module pe_bhv
//   #( parameter                  OHW = 4 )  // encoder one-hot input width
//   ( input      [      OHW -1:0] oht       ,  // one-hot input  / [      OHW -1:0]
//     output reg [$clog2(OHW)-1:0] bin       ,  // first '1' index/ [`log2(OHW)-1:0]
//     output reg                  vld       ); // binary is valid if one was found

//   always @(*) begin
//     bin = {$clog2(OHW){1'b1}};
//     vld = 0;        ;
//     while ((!vld) && (bin!=0)) begin
//       vld = oht[bin];
//       if(!vld) bin = bin - 1 ;
//     end
//   end


// endmodule



//Data-flow model design(Specific)

module pe_bhv (
    oht,
    out1,
  	valid
);

    input [3:0] oht;
    output [1:0] out1;
    output valid;

    assign out1[1] = oht[3] || oht[2];
    assign out1[0] = oht[3] || oht[1] && !oht[2];
    assign valid   = oht[3] || oht[2] || oht[1] || oht[0];
    
endmodule