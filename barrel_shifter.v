module barrel_shifter #(parameter WIDTH = 32)(
input  [WIDTH-1:0] data,
input  [4:0] shift,
input  dir,
output [WIDTH-1:0] out
);
assign out = dir ? (data >> shift) : (data << shift);
endmodule