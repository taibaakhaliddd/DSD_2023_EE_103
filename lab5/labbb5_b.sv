`timescale 1ns / 1ps
module labbb5_b(
    input [3:0] num,
        input [2:0] S,
    output reg ae, be, c, d, e, f, g, DP,
    output reg [7:0] AN
);
     
always @(*) begin
 DP = 0;case (num)  
        4'b0000: {ae, be, c, d, e, f, g} = 7'b0000001; 
        4'b0001: {ae, be, c, d, e, f, g} = 7'b1001111; 
        4'b0010: {ae, be, c, d, e, f, g} = 7'b0010010; 
        4'b0011: {ae, be, c, d, e, f, g} = 7'b0000110; 
        4'b0100: {ae, be, c, d, e, f, g} = 7'b1001100; 
        4'b0101: {ae, be, c, d, e, f, g} = 7'b0100100; 
        4'b0110: {ae, be, c, d, e, f, g} = 7'b0100000; 
        4'b0111: {ae, be, c, d, e, f, g} = 7'b0001111; 
        4'b1000: {ae, be, c, d, e, f, g} = 7'b0000000; 
        4'b1001: {ae, be, c, d, e, f, g} = 7'b0000100; 
        4'b1010: {ae, be, c, d, e, f, g} = 7'b0001000; 
        4'b1011: {ae, be, c, d, e, f, g} = 7'b1100000; 
        4'b1100: {ae, be, c, d, e, f, g} = 7'b0110001;  
        4'b1101: {ae, be, c, d, e, f, g} = 7'b1000010; 
        4'b1110: {ae, be, c, d, e, f, g} = 7'b0110000; 
        4'b1111: {ae, be, c, d, e, f, g} = 7'b0111000; 
    endcase
    
    case (S)
        3'b000: AN = 8'b1111_1110;
        3'b001: AN = 8'b1111_1101;
        3'b010: AN = 8'b1111_1011;
        3'b011: AN = 8'b1111_0111;
        3'b100: AN = 8'b1110_1111;
        3'b101: AN = 8'b1101_1111;
        3'b110: AN = 8'b1011_1111;
        3'b111: AN = 8'b0111_1111;
        default: AN = 8'b1111_1111;
    endcase
end 
endmodule
