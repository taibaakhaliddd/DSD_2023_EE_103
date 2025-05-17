`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2025 06:31:46 AM
// Design Name: 
// Module Name: lab7
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

module labb7( input [1:0] a ,input [1:0] b,
input [2:0] S,input write,clk,reset,
output ae,be,c,d,e,f,g,DP, output [7:0] AN
);
logic [2:0] sel;
wire [3:0] num;
assign num={a,b};
reg clock_div;
wire [7:0]w;
reg [3:0]f1,f2,f3,f4,f5,f6,f7,f8;
reg [3:0]M;
logic [18:0] count;
always_ff @(posedge clk or posedge reset)begin
     if (reset)begin
     count<=0;
     clock_div<=0;
     end
     else if(count==500000)begin
     count<=0;
     clock_div=~(clock_div);
     end
     else 
     begin 
     count<=count+1;
     end
  end   
 always_ff @(posedge clock_div or posedge reset)begin
  if (reset)
  sel<=0;
  
  else 
  sel<=sel+1;    
end
	
	assign w[0]=(~S[2]|~S[1]|~S[0])|write;
assign w[1]=(~S[2]|~S[1]|S[0])|write;
assign w[2]=(~S[2]|S[1]|~S[0])|write;
assign w[3]=(~S[2]|S[1]|S[0])|write;
assign w[4]=(S[2]|~S[1]|~S[0])|write;
assign w[5]=(S[2]|~S[1]|S[0])|write;
assign w[6]=(S[2]|S[1]|~S[0])|write;
assign w[7]=(S[2]|S[1]|S[0])|write;
	


assign ae=(~a[1]&a[0]&~b[1]&~b[0])|(~a[1]&~a[0]&~b[1]&b[0])|(a[1]&a[0]&~b[1]&b[0])|(a[1]&~a[0]&b[1]&b[0]);
assign be=(a[1]&b[1]&b[0])|(a[0]&b[1]&~b[0])|(a[0]&a[1]&~b[0])|(~a[1]&a[0]&~b[1]&b[0]);
assign c=(~a[1]&~a[0]&b[1]&~b[0])|(a[1]&a[0]&b[1])|(a[1]&a[0]&~b[0]);
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

flip_flop Flip1(clk,reset,w[0],num,f1);
	flip_flop Flip2(clk,reset,w[1],num,f2);
	flip_flop Flip3(clk,reset,w[2],num,f3);
	flip_flop Flip4(clk,reset,w[3],num,f4);
	flip_flop Flip5(clk,reset,w[4],num,f5);
	flip_flop Flip6(clk,reset,w[5],num,f6);
	flip_flop Flip7(clk,reset,w[6],num,f7);
	flip_flop Flip8(clk,reset,w[7],num,f8);
mux m(sel,f1,f2,f3,f4,f5,f6,f7,f8,M);
endmodule

    
