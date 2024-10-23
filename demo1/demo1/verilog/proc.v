/* $Author: sinclair $ */
/* $LastChangedDate: 2020-02-09 17:03:45 -0600 (Sun, 09 Feb 2020) $ */
/* $Rev: 46 $ */
`default_nettype none
module proc (/*AUTOARG*/
   // Outputs
   err, 
   // Inputs
   clk, rst
   );

   input wire clk;
   input wire rst;

   output reg err;

   // None of the above lines can be modified

   // OR all the err ouputs for every sub-module and assign it as this
   // err output
   
   // As desribed in the homeworks, use the err signal to trap corner
   // cases that you think are illegal in your statemachines
   
   
   /* your code here -- should include instantiations of fetch, decode, execute, mem and wb modules */
   // Fetch stage instantiation
      wire [15:0] PC, PC2, Instr;         // PC and Instruction signals
   wire [15:0] read1Data, read2Data;   // Data read from register file
   wire [15:0] ALUOut, BOut;           // ALU result and data for memory write
   wire [15:0] ReadData;               // Data read from memory
   wire [1:0]  RegSrc, RegDst, BSrc;   // Control signals

   // Control signals between stages
   wire ALUJmp, ImmSrc, RegWrt, InvA, InvB, Cin, MemWrt, ZeroExt;
   wire [15:0] inst_5_ext, inst_8_ext, inst_11_ext, RegData;

   // Signals between decode and execute
   wire [2:0] BrchCnd, Op;
   wire Brch;

   // Fetch stage
   fetch fetch0 (.PC(PC), .clk(clk), .rst(rst), .Instr(Instr), .PC2(PC2));

   // Decode stage
   decode decode0 (.clk(clk), .rst(rst), .instruction(Instr), .writeData(RegData), 
                .ALUJmp(ALUJmp), .ImmSrc(ImmSrc), .RegSrc(RegSrc), .RegWrt(RegWrt), 
                .InvA(InvA), .InvB(InvB), .Cin(Cin), .MemWrt(MemWrt), .ZeroExt(ZeroExt),
                .RegDst(RegDst), .BSrc(BSrc), 
                .read1Data(read1Data), .read2Data(read2Data), 
                .inst_5_ext(inst_5_ext), .inst_8_ext(inst_8_ext), .inst_11_ext(inst_11_ext),
                .BranchCnd(BrchCnd), .Op(Op));

   // Execute stage
   execute execute0 (.A(read1Data), .read2Data(read2Data), .ext_5(inst_5_ext), .ext_8(inst_8_ext), 
                  .BrchCnd(BrchCnd), .Op(Op), .BSrc(BSrc), 
                  .InvA(InvA), .InvB(InvB), .Cin(Cin), 
                  .ALUOut(ALUOut), .BOut(BOut), .Brch(Brch));

   // Memory stage
   memory memory0 (.WriteData(read2Data), .Address(ALUOut), 
                .Immediate0(inst_8_ext), .Immediate1(inst_11_ext), 
                .PC(PC2), .ALUOut(ALUOut), .MemWrt(MemWrt), .ImmSrc(ImmSrc), 
                .ALUJmp(ALUJmp), .Brch(Brch), .clk(clk), .rst(rst), 
                .ReadData(ReadData), .NextPC(PC));

   // Writeback stage
   wb wrb1 (.PC(PC), .ALUOut(ALUOut), .ReadData(ReadData), .B(BOut), 
            .RegSrc(RegSrc), .RegData(RegData));

   // Error signal (for illegal states)
   // assign err = (/* error conditions */);

endmodule // proc
`default_nettype wire
// DUMMY LINE FOR REV CONTROL :0:
