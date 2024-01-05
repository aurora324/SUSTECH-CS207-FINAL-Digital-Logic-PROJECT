`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/01 10:16:41
// Design Name: 
// Module Name: Auto
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


module Auto(
    input clk,
    input enable,
    input up,
    input down,
    input left,
    input right,
    input Begin,
    input [4:0]lib_in_note,
    output lib_clk,
    output lib_RorW,
    output reg lib_back_to,
    output reg [2:0]lib_song_select,
    output reg [39:0] tub_text,
    output [7:0] led
    );
    assign lib_RorW = 1'b0;
    wire[14:0] bpm_freq[7:0];
    assign bpm_freq[0] = 10;
    assign bpm_freq[1] = 25;
    assign bpm_freq[2] = 40;
    assign bpm_freq[3] = 55;
    assign bpm_freq[4] = 70;
    assign bpm_freq[5] = 85;
    assign bpm_freq[6] = 100;
    assign bpm_freq[7] = 115;
    reg[2:0] song_select = 3'b000;
    reg[2:0] next_song;
    reg[2:0] bpm = 3'b011;
    reg[2:0] next_bpm;
    reg register_lock = 1'b1;
    reg[4:0]next_state_lock = 5'b0_0000;
    reg isPlay = 1'b0,next_isPlay;
    reg tempo_lib_clk = 1'b0;
    reg [14:0]clk_counter;
    
    assign lib_clk = tempo_lib_clk;
    
    note_to_hotone(lib_in_note,led);
    
    always@(posedge clk, negedge enable)
    begin
    if(!enable)
        begin
            song_select <= 3'b000;
            isPlay <= 1'b0;
            bpm <= 3'b011;
       end
    else
        begin
            if(!register_lock)   
            begin
                song_select <= next_song;
                isPlay <= next_isPlay;
                bpm<=next_bpm;
            end
            register_lock <= (up|down|left|right|Begin);
        end
    end
    
    always@(posedge clk)
    begin
    if(isPlay)
    begin
         clk_counter <= clk_counter+1;
         if(clk_counter> bpm_freq[bpm])
            begin
            clk_counter<= 0;
            tempo_lib_clk=~tempo_lib_clk;
            end
    end
    else
        clk_counter <= 0;
    end
    
    always@*
    begin
    if({up,down,left,right,Begin}!=next_state_lock)
    begin
    if(up)
        next_song = song_select+1;
    if(down)
        next_song = song_select-1;
    if(left)
        next_bpm = bpm+1;
    if(right)
        next_bpm = bpm-1;
    if(lib_in_note==5'b1_1111)
        next_isPlay = 1'b0;
    else
        begin
        if(Begin)
           next_isPlay = ~isPlay;
        end
    next_state_lock={up,down,left,right,Begin};
    end
    end
    
    always@*
    begin
        if(!isPlay)
        begin
            tub_text = {5'd15,5'd23,5'd15,5'd24,5'd21,5'd21,5'd21,2'b00,song_select};
            lib_back_to = 1'b0;
        end
        else
        begin
            tub_text = {5'd18,5'd19,5'd10,5'd22,5'd1,5'd20,5'd9,2'b00,song_select};
            lib_song_select = song_select;
            lib_back_to = 1'b1;
        end
    end
endmodule
