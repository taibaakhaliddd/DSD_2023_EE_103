` timescale 1 ns/10 ps
module lab7_tb;	
reg [3:0]num;
reg write;
reg reset;
reg clk;
reg [2:0]s;
wire [6:0]segments;
wire [7:0]select;
lab7 DUT(num, write, reset, clk, s, segments, select);
initial
	begin
		clk = 0;
		forever #10 clk = ~clk;
	end
	
initial 
	begin
			reset = 0;
			num[3]=0;num[2]=0;num[1]=0;num[0]=0;
			s[2]=0;s[1]=0;s[0]=0;write=1;
			@ (posedge clk);
			s[2]=0;s[1]=0;s[0]=0;write=0;
			@ (posedge clk);
			num[3]=0;num[2]=0;num[1]=0;num[0]=1;
			s[2]=0;s[1]=0;s[0]=1;write=1;
			@ (posedge clk);
			s[2]=0;s[1]=0;s[0]=1;write=0;
			@ (posedge clk);
			num[3]=0;num[2]=0;num[1]=1;num[0]=0;
			s[2]=0;s[1]=1;s[0]=0;write=1;
			@ (posedge clk);
			s[2]=0;s[1]=1;s[0]=0;write=0;
			@ (posedge clk);
			num[3]=0;num[2]=0;num[1]=1;num[0]=1;
			s[2]=0;s[1]=1;s[0]=1;write=1;
			@ (posedge clk);
			s[2]=0;s[1]=1;s[0]=1;write=0;
			@ (posedge clk);
			num[3]=0;num[2]=1;num[1]=0;num[0]=0;
			s[2]=1;s[1]=0;s[0]=0;write=1;
			@ (posedge clk);
			s[2]=1;s[1]=0;s[0]=0;write=0;
			@ (posedge clk);
			num[3]=0;num[2]=1;num[1]=0;num[0]=1;
			s[2]=1;s[1]=0;s[0]=1;write=1;
			@ (posedge clk);
			s[2]=1;s[1]=0;s[0]=1;write=0;
			@ (posedge clk);
			num[3]=0;num[2]=1;num[1]=1;num[0]=0;
			s[2]=1;s[1]=1;s[0]=0;write=1;
			@ (posedge clk);
			s[2]=1;s[1]=1;s[0]=0;write=0;
			@ (posedge clk);
			num[3]=0;num[2]=1;num[1]=1;num[0]=1;
			s[2]=1;s[1]=1;s[0]=1;write=1;
			@ (posedge clk);
			s[2]=1;s[1]=1;s[0]=1;write=0;
			@ (posedge clk);
			reset = 1;
			@ (posedge clk);
			$stop;
	end
endmodule