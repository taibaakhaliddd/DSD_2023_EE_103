module flip_flop(input logic clk,reset,w,input logic [3:0] num,output logic [3:0]f);
 always_ff @(posedge clk)begin 
 if(reset)
 f<=4'b0000;
 else if(w)
 f<=num;
 end
 endmodule
