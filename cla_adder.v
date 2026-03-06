module cla_adder #(parameter WIDTH = 32)(
input  [WIDTH-1:0] A,
input  [WIDTH-1:0] B,
input  Cin,
output [WIDTH-1:0] Sum,
output Cout
);

wire [WIDTH-1:0] P;
wire [WIDTH-1:0] G;
wire [WIDTH:0] C;

assign P = A ^ B;
assign G = A & B;

assign C[0] = Cin;

genvar i;

generate
for(i=0;i<WIDTH;i=i+1)
begin
assign C[i+1] = G[i] | (P[i] & C[i]);
assign Sum[i] = P[i] ^ C[i];
end
endgenerate

assign Cout = C[WIDTH];

endmodule