module alu_control(
input [2:0] opcode,
output reg [2:0] alu_sel
);
always @(*)
begin

case(opcode)

3'b000: alu_sel = 3'b010; // ADD
3'b001: alu_sel = 3'b011; // SUB
3'b010: alu_sel = 3'b000; // AND
3'b011: alu_sel = 3'b001; // OR
3'b100: alu_sel = 3'b100; // XOR
3'b101: alu_sel = 3'b101; // SHIFT LEFT
3'b110: alu_sel = 3'b110; // SHIFT RIGHT
3'b111: alu_sel = 3'b111; // SET LESS THAN

endcase

end

endmodule