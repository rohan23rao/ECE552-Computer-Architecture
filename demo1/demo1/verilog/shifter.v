/*
    CS/ECE 552 FALL '22
    Homework #2, Problem 2
    
    A barrel shifter module.  It is designed to shift a number via rotate
    left, shift left, shift right arithmetic, or shift right logical based
    on the 'Oper' value that is passed in.  It uses these
    shifts to shift the value any number of bits.
 */
module shifter (In, ShAmt, Oper, Out);

    // declare constant for size of inputs, outputs, and # bits to shift
    parameter OPERAND_WIDTH = 16;
    parameter SHAMT_WIDTH   =  4;
    parameter NUM_OPERATIONS = 2;

    input  [OPERAND_WIDTH -1:0] In   ; // Input operand
    input  [SHAMT_WIDTH   -1:0] ShAmt; // Amount to shift/rotate
    input  [NUM_OPERATIONS-1:0] Oper ; // Operation type
    output [OPERAND_WIDTH -1:0] Out  ; // Result of shift/rotate
   /* YOUR CODE HERE */
   wire [OPERAND_WIDTH-1:0] result1, result2, result3, result4;

   shift1 s1(.In(In), .ShAmt(ShAmt[0]), .Oper(Oper), .Out(result1));
   shift2 s2(.In(result1), .ShAmt(ShAmt[1]), .Oper(Oper), .Out(result2));
   shift4 s4(.In(result2), .ShAmt(ShAmt[2]), .Oper(Oper), .Out(result3));
   shift8 s8(.In(result3), .ShAmt(ShAmt[3]), .Oper(Oper), .Out(result4));

   assign Out = result4;
endmodule