`timescale 1ns / 1ps
module labb4(
input  [1:0] a,
input [1:0] b,
output  r,g,be);
 assign r=(a[1]&a[0])|(~b[1]&~b[0])|(a[1]&~b[0])|(a[0]&~b[1])|(a[1]&~b[1]);
 assign g=(b[1]&b[0])|(~a[1]&~a[0])|(~a[1]&b[1])|(~a[0]&b[1])|(~a[1]&b[0]);
 assign be=(~a[0]&b[0])|(a[0]&~b[0])|(a[1]&~b[1])|(~a[1]&b[1]);
endmodule
