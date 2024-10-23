module ControlUnit(
    input wire [4:0] opcode, // 5-bit opcode
    output reg ALUJmp,
    output reg ImmSrc,
    output reg [1:0] RegDst,
    output reg RegWrt,
    output reg [1:0] RegSrc,
    output reg [1:0] BSrc,
    output reg InvA,
    output reg InvB,
    output reg Cin,
    output reg MemWrt,
    output reg [2:0] BranchCnd,
    output reg [2:0] Op
);

    always @(*) begin
        // Default values
        ALUJmp = 0;
        ImmSrc = 0;
        RegDst = 2'b00;
        RegWrt = 0;
        RegSrc = 2'b00;
        BSrc = 2'b00;
        InvA = 0;
        InvB = 0;
        Cin = 0;
        MemWrt = 0;
        BranchCnd = 2'b00; // Default to 00
        Op = 3'b000; // Default Op value

        case (opcode)
            // Arithmetic Immediate Instructions
            5'b01000: begin // ADDI
                RegSrc = 2'b10;
                RegDst = 2'b10;
                RegWrt = 1;
                BSrc = 2'b01;
                Op = 3'b100;
            end
            5'b01001: begin // SUBI
                RegSrc = 2'b10;
                RegDst = 2'b10;
                RegWrt = 1;
                BSrc = 2'b01;
                InvA = 1;
                Cin = 1; // For subtraction
                Op = 3'b100;
            end
            5'b01010: begin // XORI
                RegSrc = 2'b10;
                RegDst = 2'b10;
                RegWrt = 1;
                BSrc = 2'b01;
                Op = 3'b111;
            end
            5'b01011: begin // ANDNI
                RegSrc = 2'b10;
                RegDst = 2'b10;
                RegWrt = 1;
                BSrc = 2'b01;
                InvB = 1; // NOT Rt
                Op = 3'b101;
            end

            // Shift and Rotate Instructions
            5'b10100: begin // ROLI
                RegSrc = 2'b10;
                RegDst = 2'b10;
                RegWrt = 1;
                BSrc = 2'b01;
                Op = 3'b000;
            end
            5'b10101: begin // SLLI
                RegSrc = 2'b10;
                RegDst = 2'b10;
                RegWrt = 1;
                BSrc = 2'b01;
                Op = 3'b001;
            end
            5'b10110: begin // RORI
                RegSrc = 2'b10;
                RegDst = 2'b10;
                RegWrt = 1;
                BSrc = 2'b01;
                Op = 3'b010;
            end
            5'b10111: begin // SRLI
                RegSrc = 2'b10;
                RegDst = 2'b10;
                RegWrt = 1;
                BSrc = 2'b01;
                Op = 3'b011;
            end

            // Memory Instructions
            5'b10000: begin // ST
                BSrc = 2'b01; // Store data
                MemWrt = 1; // Memory write
            end
            5'b10001: begin // LD
                RegWrt = 1;
                RegSrc = 2'b01;
                BSrc = 2'b01; // Load data
            end
            5'b10011: begin // STU
                RegDst = 2'b10;
                RegWrt = 1;
                BSrc = 2'b01; // Store data
                MemWrt = 1; // Memory write
            end

            // Branch Instructions
            5'b01100: begin // BEQZ
                BSrc = 2'b11;
                BranchCnd = 3'b000; // Condition code for BEQZ
                Op = 3'b100;
            end
            5'b01101: begin // BNEZ
                BSrc = 2'b11;
                BranchCnd = 3'b001; // Condition code for BNEZ
                Op = 3'b100;
            end
            5'b01110: begin // BLTZ
                BSrc = 2'b11;
                BranchCnd = 2'b010; // Condition code for BLTZ
                Op = 3'b100;
            end
            5'b01111: begin // BGEZ
                BSrc = 2'b11;
                BranchCnd = 3'b011; // Condition code for BGEZ
                Op = 3'b100;
            end

            // Register Transfer Instructions
            5'b11001: begin // BTR
                RegDst = 2'b10;
                RegWrt = 1;
                RegSrc = 2'b10;
            end
            5'b11011: begin // ADD
                RegSrc = 2'b10;
                RegDst = 2'b10;
                RegWrt = 1;
                RegSrc = 2'b10;
                Op = 3'b100;
            end
            5'b11011: begin // SUB
                RegSrc = 2'b10;
                RegDst = 2'b10;
                RegWrt = 1;
                RegSrc = 2'b10;
                InvA = 1;
                Cin = 1; // For subtraction
                Op = 3'b100;
            end
            5'b11011: begin // XOR
                RegSrc = 2'b10;
                RegDst = 2'b10;
                RegWrt = 1;
                RegSrc = 2'b10;
                Op = 3'b111;
            end
            5'b11011: begin // ANDN
                RegSrc = 2'b10;
                RegDst = 2'b10;
                RegWrt = 1;
                RegSrc = 2'b10;
                InvB = 1; // NOT Rt
                Op = 3'b101;
            end
            5'b11010: begin // ROL
                RegSrc = 2'b10;
                RegDst = 2'b10;
                RegWrt = 1;
                RegSrc = 2'b10;
                Op = 3'b000; // ROL operation
            end
            5'b11010: begin // SLL
                RegSrc = 2'b10;
                RegDst = 2'b10;
                RegWrt = 1;
                RegSrc = 2'b10;
                Op = 3'b001; // SLL operation
            end
            5'b11010: begin // ROR
                RegSrc = 2'b10;
                RegDst = 2'b10;
                RegWrt = 1;
                RegSrc = 2'b10;
                Op = 3'b010; // ROR operation
            end
            5'b11010: begin // SRL
                RegSrc = 2'b10;
                RegDst = 2'b10;
                RegWrt = 1;
                RegSrc = 2'b10;
                Op = 3'b011; // SRL operation
            end
            5'b11100: begin // SEQ
                RegDst = 2'b10;
                RegWrt = 1;
                RegSrc = 2'b10;
                Op = 3'b000; // SEQ operation
            end
            5'b11101: begin // SLT
                RegDst = 2'b10;
                RegWrt = 1;
                RegSrc = 2'b10;
                Op = 3'b001; // SLT operation
            end
            5'b11110: begin // SLE
                RegDst = 2'b10;
                RegWrt = 1;
                RegSrc = 2'b10;
                Op = 3'b010; // SLE operation
            end
            5'b11111: begin // SCO
                RegDst = 2'b10;
                RegWrt = 1;
                RegSrc = 2'b10;
                Op = 3'b011; // SCO operation
            end

            // Jump Instructions
            5'b00100: begin // J
                ImmSrc = 1; // Use immediate for jump
                BranchCnd = 2'b100;
            end
            5'b00101: begin // JR
                ALUJmp = 1;
                BSrc = 2'b10; // Jump to address in Rs
                BranchCnd = 2'b100;
            end
            5'b00110: begin // JAL
                RegSrc = 2'b00;
                RegDst = 2'b11;
                RegWrt = 1;
                ImmSrc = 1; // Use immediate for jump
                BranchCnd = 2'b100;
            end
            5'b00111: begin // JALR
                RegSrc = 2'b00;
                RegDst = 2'b11;
                RegWrt = 1;
                ALUJmp = 1;
                BSrc = 2'b10; // Jump to address in Rs
                BranchCnd = 2'b100;
            end

            default: begin
                // Optional: Handle undefined opcodes
                // Set signals to a safe default or error state
            end
        endcase
    end
endmodule
