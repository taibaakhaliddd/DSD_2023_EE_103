`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2025 03:37:46 PM
// Design Name: 
// Module Name: labbb5
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module labbb5( input [1:0] a ,input [1:0] b,
input [2:0] S,
output ae,be,c,d,e,f,g,DP, output [7:0] AN
);
assign ae=(~a[1]&a[0]&~b[1]&~b[0])|(~a[1]&~a[0]&~b[1]&b[0])|(a[1]&a[0]&~b[1]&b[0])|(a[1]&~a[0]&b[1]&b[0]);
assign be=(a[1]&b[1]&b[0])|(a[0]&b[1]&~b[0])|(a[0]&a[1]&~b[0])|(~a[1]&a[0]&~b[1]&b[0]);
assign c=(~a[1]&~a[0]&b[1]&b[0])|(a[1]&a[0]&b[1])|(a[1]&a[0]&~b[0]);
assign d=(a[0]&b[1]&b[0])|(~a[1]&a[0]&~b[1]&~b[0])|(~a[1]&~a[0]&~b[1]&b[0])|(a[1]&~a[0]&b[1]&~b[0]);
assign e=(b[0]&~a[1])|(~a[1]&a[0]&~b[1])|(~b[1]&b[0]&~a[0]);
assign f=(~a[1]&~a[0]&b[0])|(~a[1]&b[1]&b[0])|(~a[1]&~a[0]&b[1])|(a[1]&a[0]&~b[1]&b[0]);
assign g=(~a[1]&~a[0]&~b[1])|(a[1]&a[0]&~b[1]&~b[0])|(~a[1]&a[0]&b[1]&b[0]);
assign DP=0;
//anode control code
assign AN[0]=(~S[2]|~S[1]|~S[0]);
assign AN[1]=(~S[2]|~S[1]|S[0]);
assign AN[2]=(~S[2]|S[1]|~S[0]);
assign AN[3]=(~S[2]|S[1]|S[0]);
assign AN[4]=(S[2]|~S[1]|~S[0]);
assign AN[5]=(S[2]|~S[1]|S[0]);
assign AN[6]=(S[2]|S[1]|~S[0]);
assign AN[7]=(S[2]|S[1]|S[0]);



endmodule
