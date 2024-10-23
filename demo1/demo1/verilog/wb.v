/*
   CS/ECE 552 Spring '22
  
   Filename        : wb.v
   Description     : This is the module for the overall Write Back stage of the processor.
*/
`default_nettype none
module wb (
   input wire [15:0] PC, ALUOut, ReadData, B,
   input wire [1:0] RegSrc,
   output wire [15:0] RegData
);
   // TODO: Your code here
   case(RegSrc) :
         2'b00 : RegData = PC;
         2'b01 : RegData = ReadData;
         2'b10 : RegData = ALUOut;
         2'b11 : RegData = B;
   endcase 
endmodule
`default_nettype wire
