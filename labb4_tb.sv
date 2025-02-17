`timescale 1ns / 1ps



module labb4_tb();
  logic [1:0] a;
  logic [1:0] b;
  logic r,g,be;

labb4 uut( 
  .a(a),
  .b(b),
  .r(r),
  .g(g),
  .be(be)
);

task driver(input logic [1:0] A = $random ,input logic [1:0] B = $random);
      a = A;
      b = B;
      #10;
endtask

task direct_test( input logic [1:0] a,b);
  begin
      driver(a,b);
  end
endtask

task random_test(input int n);
  for(int i=0 ; i<n ; i++)
  begin
      driver();
  end
endtask  

task monitor();
      begin
          $monitor("Time: %0t | a = %b, b = %b, r= %b, g = %b, be= %b", 
                   $time, a, b, r, g, be);
      end
  endtask

initial begin
  
      monitor();
      
      direct_test(2'b10, 2'b01);
      direct_test(2'b01, 2'b10);
      
      random_test(10);
     
      $finish;    
      end    
endmodule