`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/30 21:14:19
// Design Name: 
// Module Name: tub_controller
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


module tub_controller(
    input clk,
    input [39:0] showing_text,
    output reg [7:0] tube_character_left,
    output reg [7:0] tube_character_right,
    output reg [7:0] tube_switch
    );
    parameter A = 8'b1110_1110,u = 8'b0011_1000,t = 8'b0001_1110,o = 8'b0011_1010,
    F = 8'b1000_1110,r = 8'b0000_1010,E = 8'b1001_1110,U = 8'b0111_1100,
    L = 8'b0001_1100,n = 8'b0010_1010,space = 8'b0000_0000,n1 = 8'b0110_0000,
    n2 = 8'b1101_1010,n3 = 8'b1111_0010,n4 = 8'b0110_0110,n5 = 8'b1011_0110,
    n6 = 8'b1011_1110,n7 = 8'b1110_0000,n8 = 8'b1111_1110,n9 = 8'b1111_0110,
    n0 = 8'b1111_1100,P = 8'b1100_1110,y = 8'b0111_0110,c = 8'b0001_1010,
    d = 8'b0111_1010,J = 8'b0111_1000,H = 8'b0110_1110,b = 8'b0011_1110;
    reg[2:0] cnt = 3'b000;
    reg[7:0] out;
    reg[16:0] cnt_clk = 0;
    wire tub_clk;
    assign tub_clk = cnt_clk[16];
    
    always@(posedge clk)
    begin
    cnt_clk <= cnt_clk+1;
    end
    
    
    always@(posedge tub_clk)
    begin
    cnt = cnt+1;
    case({showing_text[39-cnt*5],showing_text[38-cnt*5],showing_text[37-cnt*5],showing_text[36-cnt*5],showing_text[35-cnt*5]})
        5'b0_0000:out= n0;
        5'b0_0001:out= n1;
        5'b0_0010:out= n2;
        5'b0_0011:out= n3;
        5'b0_0100:out= n4;
        5'b0_0101:out= n5;
        5'b0_0110:out= n6;
        5'b0_0111:out= n7;
        5'b0_1000:out= n8;
        5'b0_1001:out= n9;
        5'b0_1010:out= A;
        5'b0_1011:out= u;
        5'b0_1100:out= t;
        5'b0_1101:out= o;
        5'b0_1110:out= F;
        5'b0_1111:out= r;
        5'b1_0000:out= E;
        5'b1_0001:out= U;
        5'b1_0010:out = P;
        5'b1_0011:out= L;
        5'b1_0100:out= n;
        5'b1_0101:out= space;
        5'b1_0110:out= y;
        5'b1_0111:out= c;
        5'b1_1000:out= d;
        5'b1_1010:out=J;
        5'b1_1011:out=H;
        5'b1_1100:out=b;
    endcase
    if(cnt<3'd4)
        begin
        tube_character_left=out;
        end
    else
        begin
        tube_character_right=out;
        end
    case(cnt)
        3'b111:tube_switch =  8'b10000000;
        3'b110:tube_switch =  8'b01000000;
        3'b101:tube_switch =  8'b00100000;
        3'b100:tube_switch =  8'b00010000;
        3'b011:tube_switch =  8'b00001000;
        3'b010:tube_switch =  8'b00000100;
        3'b001:tube_switch =  8'b00000010;
        3'b000:tube_switch =  8'b00000001;
    endcase
    end
endmodule
/////////////////////////////////////////////////
//   1
//   -
// 6| |2
//  7-
// 5| |3
//   -  .8
//   4
//0000_0000
////////////////////////////////////////////////
