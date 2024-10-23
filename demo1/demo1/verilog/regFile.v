/*
   CS/ECE 552, Fall '22
   Homework #3, Problem #1
  
   This module creates a 16-bit register.  It has 1 write port, 2 read
   ports, 3 register select inputs, a write enable, a reset, and a clock
   input.  All register state changes occur on the rising edge of the
   clock. 
*/
module regFile (
                // Outputs
                read1Data, read2Data, err,
                // Inputs
                clk, rst, read1RegSel, read2RegSel, writeRegSel, writeData, writeEn
                );
   parameter width = 16;
   parameter numRegs = 8;

   input        clk, rst;
   input [2:0]  read1RegSel;
   input [2:0]  read2RegSel;
   input [2:0]  writeRegSel;
   input [width-1:0] writeData;
   input        writeEn;

   output [width-1:0] read1Data;
   output [width-1:0] read2Data;
   output        err;
   /* YOUR CODE HERE */
   wire [width-1:0] readData [0:numRegs-1];

   register register0(.readData(readData[0]), .writeData(writeData), .clk(clk), .rst(rst), .writeEn(writeEn & (writeRegSel == 3'b000)));
   register register1(.readData(readData[1]), .writeData(writeData), .clk(clk), .rst(rst), .writeEn(writeEn & (writeRegSel == 3'b001)));
   register register2(.readData(readData[2]), .writeData(writeData), .clk(clk), .rst(rst), .writeEn(writeEn & (writeRegSel == 3'b010)));
   register register3(.readData(readData[3]), .writeData(writeData), .clk(clk), .rst(rst), .writeEn(writeEn & (writeRegSel == 3'b011)));
   register register4(.readData(readData[4]), .writeData(writeData), .clk(clk), .rst(rst), .writeEn(writeEn & (writeRegSel == 3'b100)));
   register register5(.readData(readData[5]), .writeData(writeData), .clk(clk), .rst(rst), .writeEn(writeEn & (writeRegSel == 3'b101)));
   register register6(.readData(readData[6]), .writeData(writeData), .clk(clk), .rst(rst), .writeEn(writeEn & (writeRegSel == 3'b110)));
   register register7(.readData(readData[7]), .writeData(writeData), .clk(clk), .rst(rst), .writeEn(writeEn & (writeRegSel == 3'b111)));

   assign read1Data = readData[read1RegSel];
   assign read2Data = readData[read2RegSel];

   assign err = (clk == 1'bx) | (rst == 1'bx) | (read1RegSel == 3'bx) | (read2RegSel == 3'bx) | (writeRegSel == 3'bx) | (writeData == 16'bx) | (writeEn == 1'bx);
endmodule
