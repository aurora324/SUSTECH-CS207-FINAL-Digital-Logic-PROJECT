`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/03 05:37:43
// Design Name: 
// Module Name: detect_key
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
module detect_key(
 input clk,
 input [7:0] key,
 input rst,
 output out_clk
    );
    reg clock;
    always@(*)begin
    case(key)
      8'b1000_0000: begin clock=1'b1;end
      8'b0100_0000: begin clock=1'b1;end
      8'b0010_0000: begin clock=1'b1;end
      8'b0001_0000: begin clock=1'b1;end
      8'b0000_1000: begin clock=1'b1;end
      8'b0000_0100: begin clock=1'b1;end
      8'b0000_0010: begin clock=1'b1;end
      8'b0000_0001: begin clock=1'b1;end
      default clock=1'b0;
    endcase  
    end
    
      reg trig1,trig2 ;
      always @(posedge clk) 
         if(~rst) 
         trig1<= 1'b0;
         else begin
         trig1 <= clock;
         end
     
       always @(posedge clk) 
         if(~rst) 
         trig2<= 1'b0;
         else begin
         trig2 <= trig1; end
   
       assign out_clk = (~trig2) & trig1;
       
endmodule
