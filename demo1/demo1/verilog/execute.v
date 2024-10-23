/*
   CS/ECE 552 Spring '22
  
   Filename        : execute.v
   Description     : This is the overall module for the execute stage of the processor.
*/
`default_nettype none
module execute (
   input wire [15:0] A, read2Data, ext_5, ext_8, 
   input wire [2:0] BrchCnd, Op,
   input wire [1:0] BSrc, 
   input wire InvA, InvB, Cin,
   output wire [15:0] ALUOut, BOut,
   output wire Brch
);
   wire [15:0] B;
   wire sf, zf, of;
   // TODO: Your code here
   branch_control bc(.BrchCnd(BrchCnd), .Brch(Brch), .zf(zf), .sf(sf), .of(of));

   assign B = (BSrc == 2'b00) ? read2Data :
           (BSrc == 2'b01) ? ext_5 :
           (BSrc == 2'b10) ? ext_8 :
           (BSrc == 2'b11) ? 0 : 0; // Default case, if needed

   alu alu1(.InA(A), .InB(B), .Cin(Cin), .Oper(Op), .invA(InvA), .invB(InvB), .sign(sf), .Out(ALUOut), .Zero(zf), .Ofl(of));
endmodule
`default_nettype wire
