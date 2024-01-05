`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/30 20:14:41
// Design Name: 
// Module Name: Main
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


module Main(
    input [7:0] switch,
    input [7:0] small_switch,
    input up,
    input down,
    input left,
    input right,
    input mid,
    input clk,
    output [7:0] tube_character_left,
    output [7:0] tube_character_right,
    output [7:0] tube_switch,
    output reg [7:0] led,
    output reg [7:0] small_led,
    output speaker,
    output sd
    );
    //////////////////////////////////
    parameter AUTO = {5'd10,5'd11,5'd12,5'd13},FREE = {5'd14,5'd15,5'd16,5'd16},LEARN = {5'd21,5'd19,5'd15,5'd20};
    //////////////////////////////////
    wire[19:0] users [3:0];
    assign users[0] = {5'd17,5'd5,5'd15,5'd1};
    assign users[1] = {5'd17,5'd5,5'd15,5'd2};
    assign users[2] = {5'd17,5'd5,5'd15,5'd3};
    assign users[3] = {5'd17,5'd5,5'd15,5'd4};
    assign sd=1'b1;
    wire slower_clock;
    wire out_up,out_down,out_left,out_right,out_mid;
    wire [4:0]lib_out_note;
    wire[8:0] lib_out_state;
    //free
    wire free_out_PorW,free_out_clk,free_out_lib_b;
    wire [4:0]free_out_note;
    wire [7:0]free_out_light;
    wire [2:0]free_out_sel_song;
    wire [39:0]free_out_tube_text;
    wire [2:0]free_out_small_led;
    //auto
    wire auto_out_clk;
    wire auto_out_RorW;
    wire auto_out_lib_back;
    wire[2:0] auto_out_song_sel;
    wire[39:0]auto_out_tub_text;
    wire[7:0]auto_out_led;
    //learn
    wire[7:0] learn_out_led;
    wire[39:0] learn_out_tub_text;
    wire[4:0] learn_out_note;
    
    parameter IDLE = 3'b111;
    parameter SELECT_AUTO = 3'b000,SELECT_FREE = 3'b001,SELECT_LEARN = 3'b010;
    parameter USING_AUTO = 3'b100,USING_FREE = 3'b101,USING_LEARN = 3'b110;
    
    reg changed_state = 1'b1;
    reg [1:0] user = 2'b00;
    reg [2:0] state = SELECT_FREE,next_state;
    //
    reg [39:0]tub_text;
    //lib
    reg lib_clk,lib_RorW,lib_back_to_start;
    reg [4:0] lib_in_note;
    reg [2:0] lib_song_select;
    //buzzer
    reg[4:0] buzzer_note;
    
    reg free_enable = 1'b0,auto_enable = 1'b0,learn_enable=1'b0;
    
    shake_free shake_free(up,down,left,right,mid,out_up,out_down,out_left,out_right,out_mid,clk,slower_clock);
    tub_controller tub_controller(clk,tub_text,tube_character_left,tube_character_right,tube_switch);
    music_lib music_lib(lib_clk,lib_in_note,lib_RorW,lib_back_to_start,lib_song_select,lib_out_note,lib_out_state);
    Buzzer buzzer(clk,buzzer_note,speaker);
    Free free(slower_clock,switch,out_up,out_down,out_left,out_right,free_enable,small_switch[0],free_out_PorW,free_out_clk,free_out_lib_b,free_out_note,free_out_light,free_out_sel_song,free_out_tube_text,free_out_small_led);
    Auto auto(slower_clock,auto_enable,out_up,out_down,out_left,out_right,small_switch[0],lib_out_note,auto_out_clk,auto_out_RorW,auto_out_lib_back, auto_out_song_sel,auto_out_tub_text,auto_out_led);
    controller learn(slower_clock,switch,learn_enable,out_up,out_down,out_left,out_right,learn_out_led,learn_out_tub_text,learn_out_note);
    
    
    always@*
    begin
    case(state)
        IDLE:;
        SELECT_FREE: begin user = switch[1:0];if(out_up)next_state = SELECT_AUTO; else if(out_down) next_state = SELECT_LEARN; else if(out_mid)next_state = USING_FREE; else next_state = SELECT_FREE;end
        SELECT_AUTO:begin user = switch[1:0];if(out_up)next_state = SELECT_LEARN; else if(out_down) next_state = SELECT_FREE; else if(out_mid)next_state = USING_AUTO; else next_state = SELECT_AUTO;end
        SELECT_LEARN:begin user = switch[1:0];if(out_up)next_state = SELECT_FREE; else if(out_down) next_state = SELECT_AUTO; else if(out_mid)next_state = USING_LEARN; else next_state = SELECT_LEARN;end
        USING_AUTO:if(out_mid)next_state = SELECT_AUTO;else next_state = USING_AUTO;
        USING_FREE:if(out_mid)next_state = SELECT_FREE;else next_state = USING_FREE;
        USING_LEARN:if(out_mid)next_state = SELECT_LEARN;else next_state = USING_LEARN;
    endcase
    end
    
    
    always@(posedge slower_clock)
    begin
    if(!changed_state)
        begin
        state <=next_state;
        changed_state = 1'b1;
        end
    if(!(out_up|out_down|out_mid))
        begin
        changed_state = 1'b0;
        end
    end
    
    
    always@*
    begin
    case(state)
        IDLE:;
        SELECT_FREE:begin tub_text = {users[user],FREE};{free_enable,auto_enable,learn_enable} = 3'b000;led = 0;small_led = 0;buzzer_note = 5'b0_0000;end
        SELECT_AUTO:begin tub_text = {users[user],AUTO};{free_enable,auto_enable,learn_enable} = 3'b000;led = 0;small_led = 0;buzzer_note = 5'b0_0000;end
        SELECT_LEARN:begin tub_text = {users[user],LEARN};{free_enable,auto_enable,learn_enable} = 3'b000;led = 0;small_led = 0;buzzer_note = 5'b0_0000;end
        USING_AUTO:begin
                       lib_clk=auto_out_clk;
                       lib_in_note=5'b0_0000;
                       lib_RorW=auto_out_RorW;
                       lib_back_to_start=auto_out_lib_back;
                       lib_song_select = auto_out_song_sel;
                       tub_text = auto_out_tub_text;
                       led = auto_out_led;
                       buzzer_note = lib_out_note;
                       small_led[0] = auto_out_clk;
                       {free_enable,auto_enable,learn_enable} = 3'b010;
                   end
        USING_FREE:begin 
                       lib_clk = free_out_clk;
                       lib_in_note = free_out_note;
                       lib_RorW = free_out_PorW;
                       lib_back_to_start = free_out_lib_b;
                       lib_song_select = free_out_sel_song;
                       tub_text = free_out_tube_text;
                       led = free_out_light;
                       buzzer_note = free_out_note;
                       small_led[2:0] = free_out_small_led;
                       {free_enable,auto_enable,learn_enable} = 3'b100;
                    end
        USING_LEARN:begin
                       led = learn_out_led;
                       tub_text = learn_out_tub_text;
                       buzzer_note = learn_out_note;
                       {free_enable,auto_enable,learn_enable} = 3'b001;
                    end
    endcase
    end
    
    
endmodule
/////////////////////////////////////////////////////
//0~9 - 0~9
//A - 10 u - 11 t - 12 o - 13 F - 14 r - 15 E - 16 U - 17 S - 5 L - 19 n - 20 " " - 21 P - 18 g - 9 y - 22 c - 23 d - 24 J - 26 H - 27 b - 28
/////////////////////////////////////////////////////
