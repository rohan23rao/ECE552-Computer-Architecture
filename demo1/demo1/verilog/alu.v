/*
    CS/ECE 552 FALL '22
    Homework #2, Problem 3

    A multi-bit ALU module (defaults to 16-bit). It is designed to choose
    the correct operation to perform on 2 multi-bit numbers from rotate
    left, shift left, shift right arithmetic, shift right logical, add,
    or, xor, & and.  Upon doing this, it should output the multi-bit result
    of the operation, as well as drive the output signals Zero and Overflow
    (OFL).
*/
module alu (InA, InB, Cin, Oper, invA, invB, sign, Out, Zero, Ofl);

    parameter OPERAND_WIDTH = 16;    
    parameter NUM_OPERATIONS = 3;
       
    input  [OPERAND_WIDTH -1:0] InA ; // Input operand A
    input  [OPERAND_WIDTH -1:0] InB ; // Input operand B
    input                       Cin ; // Carry in
    input  [NUM_OPERATIONS-1:0] Oper; // Operation type
    input                       invA; // Signal to invert A
    input                       invB; // Signal to invert B
    input                       sign; // Signal for signed operation
    output [OPERAND_WIDTH -1:0] Out ; // Result of computation
    output                      Ofl ; // Signal if overflow occured
    output                      Zero; // Signal if Out is 0

    /* YOUR CODE HERE */
    reg [OPERAND_WIDTH -1:0] result;
    reg flow = 1'b0;
    wire [OPERAND_WIDTH -1:0] result0, result1;
    wire c_out;
    

    wire [OPERAND_WIDTH-1:0] A = invA ? ~InA : InA;
    wire [OPERAND_WIDTH-1:0] B = invB ? ~InB : InB;

    shifter s0(.In(A), .ShAmt(B[3:0]), .Oper(Oper[1:0]), .Out(result0));
    cla_16b c0(.sum(result1), .c_out(c_out), .a(A), .b(B), .c_in(Cin));

    always @(*) begin
        case(Oper)
            4'b000: result = result0;
            4'b001: result = result0;
            4'b010: result = result0;
            4'b011: result = result0;
            4'b100:
                begin
                    result = result1;
                    flow = sign ? ((A[OPERAND_WIDTH-1] & B[OPERAND_WIDTH-1] & ~result1[OPERAND_WIDTH-1]) | (~A[OPERAND_WIDTH-1] & ~B[OPERAND_WIDTH-1] & result1[OPERAND_WIDTH-1])) : c_out;
                end
            4'b101: result = A & B;
            4'b110: result = A | B;
            4'b111: result = A ^ B;
            default: result = 16'b0;
    endcase
end

assign Out = result;
assign Zero = (Out == 0) ? 1'b1 : 1'b0;
assign Ofl = flow;

endmodule
