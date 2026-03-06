module parameterized_alu #(parameter WIDTH = 32)(
input  [WIDTH-1:0] A,
input  [WIDTH-1:0] B,
input  [2:0] opcode,
input  [4:0] shift,
output reg [WIDTH-1:0] Result,
output Zero,
output Carry,
output Negative,
output Overflow
);

wire [2:0] ALU_Sel;
wire [WIDTH-1:0] add_out;
wire [WIDTH-1:0] sub_out;

wire carry_add;
wire carry_sub;

wire [WIDTH-1:0] shift_left;
wire [WIDTH-1:0] shift_right;

alu_control CTRL(
opcode,
ALU_Sel
);

cla_adder #(WIDTH) ADD(
A,
B,
1'b0,
add_out,
carry_add
);

cla_adder #(WIDTH) SUB(
A,
~B,
1'b1,
sub_out,
carry_sub
);

barrel_shifter #(WIDTH) SHL(
A,
shift,
1'b0,
shift_left
);

barrel_shifter #(WIDTH) SHR(
A,
shift,
1'b1,
shift_right
);

always @(*)
begin

case(ALU_Sel)

3'b000: Result = A & B;
3'b001: Result = A | B;
3'b010: Result = add_out;
3'b011: Result = sub_out;
3'b100: Result = A ^ B;
3'b101: Result = shift_left;
3'b110: Result = shift_right;
3'b111: Result = (A < B);

default: Result = 0;

endcase

end

assign Carry = (ALU_Sel == 3'b010) ? carry_add :
               (ALU_Sel == 3'b011) ? carry_sub : 0;

assign Zero = (Result == 0);

assign Negative = Result[WIDTH-1];

assign Overflow =
(ALU_Sel == 3'b010) ?
(A[WIDTH-1] & B[WIDTH-1] & ~Result[WIDTH-1]) |
(~A[WIDTH-1] & ~B[WIDTH-1] & Result[WIDTH-1]) :

(ALU_Sel == 3'b011) ?
(A[WIDTH-1] & ~B[WIDTH-1] & ~Result[WIDTH-1]) |
(~A[WIDTH-1] & B[WIDTH-1] & Result[WIDTH-1]) : 0;

endmodule