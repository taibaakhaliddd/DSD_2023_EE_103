`timescale 1ns / 1ps

module labbb2(
output  x,y,
input  a,b,c
);
assign x=(~c)^(a|b);
assign y=(a|b)&(~(a&b)^(a|b));
endmodule
