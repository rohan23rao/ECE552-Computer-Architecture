/*
   CS/ECE 552 Spring '22
  
   Filename        : decode.v
   Description     : This is the module for the overall decode stage of the processor.
*/
`default_nettype none
module decode (
   input wire clk, rst, 
   input wire [15:0] instruction, writeData,
   output wire ALUJmp, ImmSrc, RegWrt, InvA, InvB, Cin, MemWrt, ZeroExt,
   output wire [1:0] RegSrc, RegDst, BSrc, 
   output wire [15:0] read1Data, read2Data,
   output wire [15:0] inst_5_ext, inst_8_ext, inst_11_ext,
   output wire [2:0] BranchCnd,
   output wire [2:0] Op
   );   

   // TODO: Your code here
   wire [4:0] opcode;
   wire [2:0] writeRegSel;
   assign opcode = instruction[15:11];

   assign writeRegSel = (RegDst == 2'b00) ? instruction[7:5] :
                     (RegDst == 2'b01) ? instruction[10:8] :
                     (RegDst == 2'b10) ? instruction[4:2] :
                     (RegDst == 2'b11) ? 3'b111 : 3'b000; // Default case, if needed


   assign inst_5_ext = ZeroExt ? {{11{1'b0}}, {instruction[4:0]}} : {{11{instruction[4]}}, {instruction[4:0]}};
   assign inst_8_ext = ZeroExt ? {{8{1'b0}}, {instruction[7:0]}} : {{8{instruction[7]}}, {instruction[7:0]}};
   assign inst_11_ext = {{5{instruction[10]}}, {instruction[10:0]}};

   regFile_bypass regfile(.read1Data(read1Data), .read2Data(read2Data), .err(), .clk(clk), .rst(rst), .read1RegSel(instruction[10:8]), .read2RegSel(instruction[7:5]), .writeRegSel(writeRegSel), .writeData(writeData), .writeEn(RegWrt));
   control_unit control(.opcode(opcode), .ALUJmp(ALUJmp), .ImmSrc(ImmSrc), .RegDst(RegDst), .RegSrc(RegSrc), .RegWrt(RegWrt), .InvA(InvA), .InvB(InvB), .Cin(Cin), .MemWrt(MemWrt), .ZeroExt(ZeroExt), .BranchCnd(BranchCnd), .Op(Op), .BSrc(BSrc));
endmodule
`default_nettype wire
