`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/01 10:09:14
// Design Name: 
// Module Name: Free
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

module Free(
input clk ,
input [7:0] key,
input up,
input down,
input left,
input right,
input enable,
input in_PorW,
output reg statePW,
output lib_clk,
output reg lib_back_to_start,
output reg [4:0] note,
output [7:0] light,
output reg [2:0] select_song,
output reg [39:0] tub_text,
output reg [2:0] low_mid_high
    );
    parameter RECORD = {5'd15,5'd23,5'd15,5'd24};
    reg[1:0] note_state = 2'b10;
    reg[1:0] next_note_state = 2'b10;
    reg changed_state = 1'b1;
    reg [3:0] pre_input = 4'b1111;
    reg[2:0] next_sel_song = 3'b100;
    reg dk_rst = 1'b0;
    //statePW = 0 play
    
    assign light = key;
    
    detect_key dk(clk,key,dk_rst,lib_clk);
    
    always@*
    begin
    if({up,down,left,right}!=pre_input)
    begin
    if(up)
        begin
        if(note_state!=2'b11)
        next_note_state = note_state+1;
        else
        next_note_state = 2'b01;
        end
    if(down)
        begin
        if(note_state!=2'b01)
        next_note_state = note_state-1;
        else
        next_note_state = 2'b11;
        end
    if(statePW)
        begin
        if(right)
            begin
            if(select_song!=3'b111)
                next_sel_song = select_song+1;
            else
                next_sel_song = 3'b100;
            end
        if(left)
            begin
            if(select_song!=3'b100)
                next_sel_song = select_song-1;
            else
                next_sel_song = 3'b111;
            end
        end
    else
        begin
        next_sel_song = 3'b100;
        end
    pre_input = {up,down,left,right};
    end
    end
    
    always@(posedge clk,negedge enable)
    begin
    if(!enable)
        begin
            note_state<=2'b10;
            select_song<=3'b000;
            statePW<=0;
        end
    else
        begin
            if(!changed_state)
                begin
                note_state<=next_note_state;
                select_song <= next_sel_song;
                statePW <= in_PorW;
                end
            changed_state <= (up|down|left|right);
            end
    end
    
    always@* begin
    if(note_state == 2'b10)
    begin
        note = 5'b00000;
        low_mid_high = 3'b010;
    end
    else if(note_state == 2'b01)
    begin
        note = 5'b00111;
        low_mid_high = 3'b100;
    end   
    else if(note_state == 2'b11)
    begin
        note = 5'b01110;
        low_mid_high = 3'b001;
    end
    else
    begin
        low_mid_high = 3'b111;
    end
    case(key)
         8'b1000_0000: begin note= note+5'b00000;end
         8'b0100_0000: begin note= note+5'b00001;end
         8'b0010_0000: begin note= note+5'b00010;end
         8'b0001_0000: begin note= note+5'b00011;end
         8'b0000_1000: begin note= note+5'b00100;end
         8'b0000_0100: begin note= note+5'b00101;end
         8'b0000_0010: begin note= note+5'b00110;end
         8'b0000_0001: begin note= note+5'b00111;end //7
              default  begin note= 5'b00000;end
    endcase
    if(!statePW)
        begin
        tub_text = {5'd14,5'd15,5'd16,5'd16,5'd18,5'd19,5'd10,5'd22};
        lib_back_to_start = 1'b1;
        dk_rst = 1'b0;
        lib_back_to_start = 1'b0;
        end
    else
        begin
        tub_text = {RECORD,5'd21,5'd21,5'd21,2'b00,select_song};
        lib_back_to_start = 1'b0;
        dk_rst = 1'b1;
        lib_back_to_start = 1'b1;
        end
    end
endmodule
