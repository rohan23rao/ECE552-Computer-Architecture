
/*
   CS/ECE 552 Spring '22
  
   Filename        : memory.v
   Description     : This module contains all components in the Memory stage of the 
                     processor.
*/
`default_nettype none
module memory (
   input wire [15:0] WriteData, Address, Immediate0, Immediate1, PC, ALUOut,
   input wire MemWrt, ImmSrc, ALUJmp, Brch, clk, rst,
   output wire [15:0] ReadData, NextPC
);
   wire [15:0] immediate, addPC, tempPC;
   
   assign immediate = ImmSrc ? Immediate1 : Immediate0;
   alu add(.InA(PC), .InB(immediate), .Cin(1'b0), .Oper(3'b100), .invA(1'b0), .invB(1'b0), .sign(1'b0), .Out(addPC), .Zero(1'b0), .Ofl(1'b0));
   assign tempPC = Brch ? addPC : PC;
   assign NextPC = ALUJmp ? ALUOut : tempPC;
   // TODO: Your code here
   memory2c mem(.data_out(ReadData), .data_in(WriteData), .addr(Address), .enable(1'b1), .wr(MemWrt), .createdump(1'b1), .clk(clk), .rst(rst));
endmodule
`default_nettype wire
