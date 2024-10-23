/*
    CS/ECE 552 FALL'22
    Homework #2, Problem 1
    
    a 4-bit CLA module
*/
module cla_4b(sum, c_out, a, b, c_in);

    // declare constant for size of inputs, outputs (N)
    parameter   N = 4;

    output [N-1:0] sum;
    output         c_out;
    input [N-1: 0] a, b;
    input          c_in;
    // YOUR CODE HERE
    wire [N-1:0] c, p, g;

    assign p = a ^ b;
    assign g = a & b;

    assign c[0] = g[0] | (p[0] & c_in);
    assign c[1] = g[1] | (p[1] & c[0]);
    assign c[2] = g[2] | (p[2] & c[1]);
    assign c_out = g[3] | (p[3] & c[2]);

    fullAdder_1b fa0(.s(sum[0]), .c_out(), .a(a[0]), .b(b[0]), .c_in(c_in));
    fullAdder_1b fa1(.s(sum[1]), .c_out(), .a(a[1]), .b(b[1]), .c_in(c[0]));
    fullAdder_1b fa2(.s(sum[2]), .c_out(), .a(a[2]), .b(b[2]), .c_in(c[1]));
    fullAdder_1b fa3(.s(sum[3]), .c_out(), .a(a[3]), .b(b[3]), .c_in(c[2]));
endmodule
