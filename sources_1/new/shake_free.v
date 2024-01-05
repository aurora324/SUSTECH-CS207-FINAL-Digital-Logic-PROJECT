`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/30 21:22:05
// Design Name: 
// Module Name: shake_free
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


module shake_free(
    input up,
    input down,
    input left,
    input right,
    input mid,
    output out_up,
    output out_down,
    output out_left,
    output out_right,
    output out_mid,
    input clk,
    output slower_clock
    );
    reg [16:0] cnt = 0;
    reg [4:0] q1 = 5'b0_0000;
    always@(posedge clk)
    begin
    cnt <= cnt+1;
    end
    assign slower_clock = cnt[16];
    
    always@(posedge slower_clock)
    begin
    q1<={up,down,left,right,mid};
    end
    assign {out_up,out_down,out_left,out_right,out_mid} = q1;
endmodule
