`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/01 11:53:24
// Design Name: 
// Module Name: note_to_hotone
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


module note_to_hotone(
    input[4:0] note,
    output reg[7:0] hotone
    );
    always@*
    begin
    case(note)
    5'd0:hotone = 8'b0000_0000;
    5'd1,5'd8,5'd15:hotone = 8'b0100_0000;
    5'd2,5'd9,5'd16:hotone = 8'b0010_0000;
    5'd3,5'd10,5'd17:hotone = 8'b0001_0000;
    5'd4,5'd11,5'd18:hotone = 8'b0000_1000;
    5'd5,5'd12,5'd19:hotone = 8'b0000_0100;
    5'd6,5'd13,5'd20:hotone = 8'b0000_0010;
    5'd7,5'd14,5'd21:hotone = 8'b0000_0001;
    5'd31:hotone = 8'b1111_1111;
    default:hotone = 8'b1111_1111;
    endcase
    end
endmodule
