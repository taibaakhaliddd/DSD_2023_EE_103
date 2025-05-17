module mux(input logic[2:0] sel,input logic[3:0]f1,f2,f3,f4,f5,f6,f7,f8,output logic[3:0]M);
	always_comb begin
			if ((~sel[2]|~sel[1]|~sel[0]))
				M = f1;
			
			else if ((~sel[2]|~sel[1]|sel[0]))
				M = f2;
			
			else if ((~sel[2]|sel[1]|~sel[0]))
				M = f3;
				
			else if ((~sel[2]|sel[1]|sel[0]))
				M = f4;
			
			else if ((sel[2]|~sel[1]|~sel[0]))
				M = f5;
			
			else if ((sel[2]|~sel[1]|sel[0]))
				M = f6;
			
			else if ((sel[2]|~sel[1]|sel[0]))
				M = f7;
			
			else if ((sel[2]|sel[1]|sel[0]))
				M = f8;		
		end
endmodule
