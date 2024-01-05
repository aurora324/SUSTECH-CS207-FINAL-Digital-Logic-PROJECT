`timescale 1ns / 1ps
module controller(
input clk,
input [7:0]key,
input rst,
input rollup,
input rolldown,
input low,
input high,
output [7:0]light,
output reg[39:0]in = {5'd5,5'd12,5'd17,5'd0,20'd0},
output [4:0] out_note
    );
//    wire[7:0]tube_character_left;
//    wire[7:0]tube_character_right;
//    wire[7:0]tube_switch;
    Multi8_5 n85(key,out_note);
    wire[3:0]wrong;
    parameter A = 8'b1110_1110,u = 8'b0011_1000,t = 8'b0001_1110,o = 8'b0011_1010,
                F = 8'b1000_1110,r = 8'b0000_1010,E = 8'b1001_1110,U = 8'b0111_1100,
                L = 8'b0001_1100,n = 8'b0010_1010,space = 8'b0000_0000,n1 = 8'b0110_0000,
                n2 = 8'b1101_1010,n3 = 8'b1111_0010,n4 = 8'b0110_0110,n5 = 8'b1011_0110,
                n6 = 8'b1011_1110,n7 = 8'b1110_0000,n8 = 8'b1111_1110,n9 = 8'b1111_0110,
                n0 = 8'b1111_1100,P = 8'b1100_1110,y = 8'b0111_0110,c = 8'b0001_1010,
                d = 8'b0111_1010,S = 8'b1011_0110 ;
    wire [4:0]key_note;
    
     reg[19:0]cnt;
     reg check;//    
     always @(posedge clk)begin
             cnt<=cnt+1;
             check<=cnt[19];
         end
    reg register_lock = 1'b0;
    reg[1:0] next_state_lock = 2'b00;  
    reg [1:0]chosen_state=2'b00;
    reg [1:0]next_state=2'b00;
    wire [2:0]ten;
    wire [7:0]number=8'b0000_0000;

    always @(posedge clk) begin
    if(!rst)begin
        chosen_state<=2'b00;
    end
        else begin
            if(!register_lock)
                chosen_state<=next_state;
            register_lock<=(rollup|rolldown);
        end
    end
//    reg [39:0]in;
     
    //    ?  ?                        
    always @* begin
    if(next_state_lock!={rollup,rolldown})
    begin
        if(rollup==1'b1)begin
            if(chosen_state==2'b00) begin next_state=2'b01;in[19:15]=5'b11010;in[14:10]=5'b10100;end//JN
            if(chosen_state==2'b01) begin next_state=2'b10;in[19:15]=5'b11011;in[14:10]=5'b11100;end//HB
            if(chosen_state==2'b10) begin next_state=2'b11;in[19:15]=5'b10111;in[14:10]=5'b00101;end//CS
            if(chosen_state==2'b11) begin next_state=2'b00;in[19:15]=5'b10011;in[14:10]=5'b00101;end//LS
        end
        
        if(rolldown==1'b1)begin
                    if(chosen_state==2'b00) begin next_state=2'b11;in[19:15]=5'b10111;in[14:10]=5'b00101;end//CS
                    if(chosen_state==2'b11)begin next_state=2'b10;in[19:15]=5'b11011;in[14:10]=5'b11100;end//HB
                    if(chosen_state==2'b10) begin next_state=2'b01;in[19:15]=5'b11010;in[14:10]=5'b10100;end//JN
                    if(chosen_state==2'b01) begin next_state=2'b00;in[19:15]=5'b10011;in[14:10]=5'b00101;end//LS
        end
    next_state_lock = {rollup,rolldown};
    end
    end
    
    study study_dis(clk,key,chosen_state,rst,rollup,rolldown,low,high,light,key_note,number,wrong,ten);
    
    always @* begin
        in[9:5]={1'b0,wrong};
        case(ten)
            3'b000:in[4:0]=5'b01010;
            3'b001:in[4:0]=5'b11100;
            default:in[4:0]=5'b10111;
        endcase
    end 

endmodule