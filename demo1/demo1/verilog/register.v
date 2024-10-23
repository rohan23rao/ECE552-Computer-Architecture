module register (readData, writeData, clk, rst, writeEn);
parameter width = 16;

output [width-1:0] readData;
input [width-1:0] writeData;
input clk, rst, writeEn;

wire [width-1:0] write;

assign write = writeEn ? writeData : readData;

dff register[width-1:0](.q(readData), .d(write), .clk(clk), .rst(rst));
endmodule