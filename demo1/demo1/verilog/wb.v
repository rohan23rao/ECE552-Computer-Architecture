`default_nettype wire

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
   
   assign RegData = (RegSrc == 2'b00) ? PC :
                 (RegSrc == 2'b01) ? ReadData :
                 (RegSrc == 2'b10) ? ALUOut :
                 (RegSrc == 2'b11) ? B : 0; // Default case, if needed


endmodule


