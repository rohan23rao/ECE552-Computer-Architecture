module branch_control (
   input wire [2:0] BrchCnd,
   input wire zf, sf, of,
   output wire Brch
);
   assign Brch = 0;
   case (BrchCnd)
      3'b000: Brch = zf;
      3'b001: Brch = ~zf;
      3'b010: Brch = sf;
      3'b011: Brch = ~sf;
      3'b100: Brch = 1;
   endcase
endmodule