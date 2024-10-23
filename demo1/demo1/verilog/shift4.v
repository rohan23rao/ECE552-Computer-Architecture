module shift4 (In, ShAmt, Oper, Out);

    // declare constant for size of inputs, outputs, and # bits to shift
    parameter OPERAND_WIDTH = 16;
    parameter SHAMT_WIDTH   =  4;
    parameter NUM_OPERATIONS = 2;

    input  [OPERAND_WIDTH -1:0] In   ; // Input operand
    input  ShAmt;
    input  [NUM_OPERATIONS-1:0] Oper ; // Operation type
    output  [OPERAND_WIDTH -1:0] Out  ; // Result of shift/rotate
   /* YOUR CODE HERE */
   reg [OPERAND_WIDTH -1:0] result;
   always @(*) begin
         case(Oper)
              2'b00: result = ShAmt ? {In[11:0], In[15:12]} : In;
              2'b01: result = ShAmt ? In << 4 : In;
              2'b10: result = ShAmt ? {{4 {In[15]}}, In[15:4]} : In;
              2'b11: result = ShAmt ? In >> 4 : In;
         endcase
   end
    assign Out = result;
endmodule