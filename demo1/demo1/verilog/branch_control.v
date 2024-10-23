module branch_control (
   input wire [2:0] BrchCnd,
   input wire zf, sf, of,
   output wire Brch
);

   assign Brch = (BrchCnd == 3'b000) ? zf :
              (BrchCnd == 3'b001) ? ~zf :
              (BrchCnd == 3'b010) ? sf :
              (BrchCnd == 3'b011) ? ~sf :
              (BrchCnd == 3'b100) ? 1 : 0; // Default case, if needed

endmodule