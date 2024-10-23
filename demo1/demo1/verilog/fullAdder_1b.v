/*
    CS/ECE 552 FALL '22
    Homework #2, Problem 1
    
    a 1-bit full adder
*/
module fullAdder_1b(s, c_out, a, b, c_in);
    output s;
    output c_out;
	input  a, b;
    input  c_in;

    // YOUR CODE HERE
    wire a_xor_b, a_nand_b, a_and_b, cin_nand_a_xor_b, cin_and_a_xor_b, nor_cout;

    xor2 x1(.out(a_xor_b),.in1(a),.in2(b));
    xor2 x2(.out(s),.in1(c_in),.in2(a_xor_b));

    nand2 nand1(.out(a_nand_b),.in1(a),.in2(b));
    not1 not1(.out(a_and_b),.in1(a_nand_b));

    nand2 nand2(.out(cin_nand_a_xor_b),.in1(Cin), .in2(a_xor_b));
    not1 not2(.out(cin_and_a_xor_b),.in1(cin_nand_a_xor_b));

    nor2 nor1(.out(nor_cout),.in1(a_and_b),.in2(cin_and_a_xor_b));
    not1 not3(.out(c_out),.in1(nor_cout));
endmodule
