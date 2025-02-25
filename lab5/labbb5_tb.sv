
`timescale 1ns / 1ps
module labbb5_tb;
    logic [1:0] a, b;
     logic [2:0] S;
    logic ae, be, c, d, e, f, g, DP;
    logic [7:0] AN;
    
    // Instantiate the module under test
    labbb5 uut (
        .a(a),
        .b(b),
        .S(S),
        .ae(ae),
        .be(be),
        .c(c),
        .d(d),
        .e(e),
        .f(f),
        .g(g),
        .DP(DP),
        .AN(AN)
    );

    initial begin
        // Apply test cases
        a = 2'b00; b = 2'b00; S = 3'b000; #10;
        a = 2'b01; b = 2'b01; S = 3'b001; #10;
        a = 2'b10; b = 2'b10; S = 3'b010; #10;
        a = 2'b11; b = 2'b11; S = 3'b011; #10;
        a = 2'b00; b = 2'b11; S = 3'b100; #10;
        a = 2'b11; b = 2'b00; S = 3'b101; #10;
        a = 2'b01; b = 2'b10; S = 3'b110; #10;
        a = 2'b10; b = 2'b01; S = 3'b111; #10;
        
        // End simulation
        $finish;
    end

    


    initial  begin
          $monitor("Time: %0t | a = %b,b=%b, S= %b, ae = %b, be= %b ,c=%b , d=%b ,e=%b ,f=%b,g=%b ,DP=%b,AN=%b", 
                   $time, a,b,  S, ae, be,c,d,e,f,g,DP,AN);
      end
    


        
endmodule