/*
   CS/ECE 552 Spring '22
  
   Filename        : fetch.v
   Description     : This is the module for the overall fetch stage of the processor.
*/
`default_nettype none
module fetch (/* TODO: Add appropriate inputs/outputs for your fetch stage here*/
   input wire [15:0] PC,
   input wire clk, rst,
   output wire [15:0] Instr, PC2
);
   //Instruction Memory
   //PC
   //Add 
   cla_16b adder(.sum(PC2), .c_out(), .a(PC), .b(16'h0002), .c_in(1'b0));
   // TODO: Your code here
   memory2c instruction_memory(.data_out(Instr), .data_in(16'b0), .addr(PC), .enable(1'b1), .wr(1'b0), .createdump(1'b1), .clk(clk), .rst(rst));
endmodule
`default_nettype wire
