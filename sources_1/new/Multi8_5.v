`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/03 02:40:46
// Design Name: 
// Module Name: Multi8_5
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
`timescale 1ns / 1ps

module Multi8_5(
    input [7:0]key,
    output reg [4:0]key_note
    );
    always @* begin
                case(key)
                        8'b1000_0000: begin key_note= 5'b00000; end
                        8'b0100_0000: begin key_note= 5'b00001; end
                        8'b0010_0000: begin key_note= 5'b00010; end
                        8'b0001_0000: begin key_note= 5'b00011; end
                        8'b0000_1000: begin key_note= 5'b00100; end
                        8'b0000_0100: begin key_note= 5'b00101; end
                        8'b0000_0010: begin key_note= 5'b00110; end
                        8'b0000_0001: begin key_note= 5'b00111; end
                        default  begin key_note= 5'b11111;end//默认值为乐谱中没有的数字
                endcase
            end
endmodule

