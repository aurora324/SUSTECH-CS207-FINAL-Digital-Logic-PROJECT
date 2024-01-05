`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/31 19:55:33
// Design Name: 
// Module Name: tb
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


module tb();
reg [7:0] switch = 0;
reg [7:0] small_switch = 0;
reg up,down,left,right,mid,clk;
wire [7:0] tube_character_left;
wire [7:0] tube_character_right;
wire [7:0] tube_switch ;
wire [7:0] led;
wire [7:0] small_led;
Main main(switch,small_switch,up,down,left,right,mid,clk,tube_character_left,tube_character_right,tube_switch,led,small_led);
initial begin
up=0;
down=0;
left=0;
right=0;
mid=0;
clk=0;
end
always
begin
#3 clk = ~clk;
end



endmodule
