/*
    CS/ECE 552 FALL '22
    Homework #2, Problem 1
    
    a 16-bit CLA module
*/
module cla_16b(sum, c_out, a, b, c_in);

    // declare constant for size of inputs, outputs (N)
    parameter   N = 16;

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
    assign c[3] = g[3] | (p[3] & c[2]);
    assign c[4] = g[4] | (p[4] & c[3]);
    assign c[5] = g[5] | (p[5] & c[4]);
    assign c[6] = g[6] | (p[6] & c[5]);
    assign c[7] = g[7] | (p[7] & c[6]);
    assign c[8] = g[8] | (p[8] & c[7]);
    assign c[9] = g[9] | (p[9] & c[8]);
    assign c[10] = g[10] | (p[10] & c[9]);
    assign c[11] = g[11] | (p[11] & c[10]);
    assign c[12] = g[12] | (p[12] & c[11]);
    assign c[13] = g[13] | (p[13] & c[12]);
    assign c[14] = g[14] | (p[14] & c[13]);
    assign c_out = g[15] | (p[15] & c[14]);

    cla_4b fa0(.sum(sum[3:0]), .c_out(), .a(a[3:0]), .b(b[3:0]), .c_in(c_in));
    cla_4b fa1(.sum(sum[7:4]), .c_out(), .a(a[7:4]), .b(b[7:4]), .c_in(c[3]));
    cla_4b fa2(.sum(sum[11:8]), .c_out(), .a(a[11:8]), .b(b[11:8]), .c_in(c[7]));
    cla_4b fa3(.sum(sum[15:12]), .c_out(), .a(a[15:12]), .b(b[15:12]), .c_in(c[11]));
endmodule
