module alu_tb;

reg [31:0] A;
reg [31:0] B;
reg [2:0] opcode;
reg [4:0] shift;

wire [31:0] Result;
wire Zero;
wire Carry;
wire Negative;
wire Overflow;

parameterized_alu #(32) DUT(
A,
B,
opcode,
shift,
Result,
Zero,
Carry,
Negative,
Overflow
);

initial
begin

A = 10; B = 5; opcode = 3'b000; shift = 1; #10;
A = 10; B = 5; opcode = 3'b001; shift = 1; #10;
A = 10; B = 5; opcode = 3'b010; shift = 1; #10;
A = 10; B = 5; opcode = 3'b011; shift = 1; #10;
A = 10; B = 5; opcode = 3'b100; shift = 2; #10;
A = 10; B = 5; opcode = 3'b101; shift = 2; #10;
A = 10; B = 5; opcode = 3'b110; shift = 2; #10;
A = 10; B = 5; opcode = 3'b111; shift = 2; #10;

$finish;
end
endmodule