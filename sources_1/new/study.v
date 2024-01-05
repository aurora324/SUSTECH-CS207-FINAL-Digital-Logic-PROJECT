`timescale 1ns / 1ps
module study(
input clk,                  
input [7:0]in_key,            //按键
//input Begin,
input [1:0]chosen_song,    //选中
input rst,                 //rst为S6按键
input rollup,              //前一首歌
input rolldown,            //后一首歌
input low,
input high,
//input[1:0]mode,           //高低音模式
output reg [7:0]out_light=8'b0000_0000,        //LED灯
output [4:0]key_note,
output reg[7:0]number=8'b0000_0000,
output reg[7:0]wrong=8'b0000_0000,
output reg[2:0] s_ten = 3'b000
    );
    reg[3:0]cnt;
    reg check;//消抖
    wire [4:0]note;
    reg [7:0]key;
    //播放位置
    reg [7:0]index=8'b0000_0000;

    always @(posedge clk)begin
        cnt<=cnt+1;
        check<=cnt[3];
        if(check)
            key <= in_key;
    end
    Multi8_5 Multi8_5_dis1(key,key_note);
    //调整音乐长度
    parameter song1_length=42;
    parameter song2_length=73;
    parameter song3_length=24;
    parameter song4_length=32;
    reg [31:0]song_length;
    reg register_lock = 1'b0;
    always @* begin
    
        if(chosen_song==2'b00)song_length=song1_length;
        if(chosen_song==2'b01)song_length=song2_length;
        if(chosen_song==2'b10)song_length=song3_length;
        if(chosen_song==2'b11)song_length=song4_length;
    end
    
    
    
    
    reg[4:0] song [255:0];
    wire[4:0] song1[42:0];
    wire[4:0] song2[255:0];
    wire[4:0] song3[255:0];
    wire[4:0] song4[255:0];      
    //小星星
    assign song1[0]=5'b00001;
    assign song1[1]=5'b00001;
    assign song1[2]=5'b00101;
    assign song1[3]=5'b00101;
    assign song1[4]=5'b00110;
    assign song1[5]=5'b00110;
    assign song1[6]=5'b00101;
    assign song1[7]=5'b00100;
    assign song1[8]=5'b00100;
    assign song1[9]=5'b00011;
    assign song1[10]=5'b00011;
    assign song1[11]=5'b00010;
    assign song1[12]=5'b00010;
    assign song1[13]=5'b00001;
    assign song1[14]=5'b00101;
    assign song1[15]=5'b00101;
    assign song1[16]=5'b00100;
    assign song1[17]=5'b00100;
    assign song1[18]=5'b00011;
    assign song1[19]=5'b00011;
    assign song1[20]=5'b00010;
    assign song1[21]=5'b00101;
    assign song1[22]=5'b00101;
    assign song1[23]=5'b00100;
    assign song1[24]=5'b00100;
    assign song1[25]=5'b00011;
    assign song1[26]=5'b00011;
    assign song1[27]=5'b00010;
    assign song1[28]=5'b00001;
    assign song1[29]=5'b00001;
    assign song1[30]=5'b00101;
    assign song1[31]=5'b00101;
    assign song1[32]=5'b00110;
    assign song1[33]=5'b00110;
    assign song1[34]=5'b00101;
    assign song1[35]=5'b00100;
    assign song1[36]=5'b00100;
    assign song1[37]=5'b00011;
    assign song1[38]=5'b00011;
    assign song1[39]=5'b00010;
    assign song1[40]=5'b00010;
    assign song1[41]=5'b00001;
    //江南
    assign song2[0]=5'b0_0110;
    assign song2[1]=5'b0_0111;
    assign song2[2]=5'b0_0001;
    assign song2[3]=5'b0_0101;
    assign song2[4]=5'b0_0011;
    assign song2[5]=5'b0_0001;
    assign song2[6]=5'b0_0110;
    assign song2[7]=5'b0_0110;
    assign song2[8]=5'b0_0111;
    assign song2[9]=5'b0_0111;
    assign song2[10]=5'b0_0111;
    assign song2[11]=5'b0_0001;
    assign song2[12]=5'b0_0111;
    assign song2[13]=5'b0_0101;
    assign song2[14]=5'b0_0110;
    assign song2[15]=5'b0_0110;
    assign song2[16]=5'b0_0110;
    assign song2[17]=5'b0_0110;
    assign song2[18]=5'b0_0111;
    assign song2[19]=5'b0_0001;
    assign song2[20]=5'b0_0101;
    assign song2[21]=5'b0_0011;
    assign song2[22]=5'b0_0001;
    assign song2[23]=5'b0_0110;
    assign song2[24]=5'b0_0110;
    assign song2[25]=5'b0_0111;
    assign song2[26]=5'b0_0111;
    assign song2[27]=5'b0_0111;
    assign song2[28]=5'b0_0001;
    assign song2[29]=5'b0_0010;
    assign song2[30]=5'b0_0001;
    assign song2[31]=5'b0_0111;
    assign song2[32]=5'b0_0101;
    assign song2[33]=5'b0_0101;
    assign song2[34]=5'b0_0110;
    assign song2[35]=5'b0_0110;
    assign song2[36]=5'b0_0110;
    assign song2[37]=5'b0_0111;
    assign song2[38]=5'b0_0001;
    assign song2[39]=5'b0_0101;
    assign song2[40]=5'b0_0011;
    assign song2[41]=5'b0_0001;
    assign song2[42]=5'b0_0110;
    assign song2[43]=5'b0_0110;
    assign song2[44]=5'b0_0111;
    assign song2[45]=5'b0_0111;
    assign song2[46]=5'b0_0111;
    assign song2[47]=5'b0_0111;
    assign song2[48]=5'b0_0001;
    assign song2[49]=5'b0_0111;
    assign song2[50]=5'b0_0110;
    assign song2[51]=5'b0_0101;
    assign song2[52]=5'b0_0110;
    assign song2[53]=5'b0_0001;
    assign song2[54]=5'b0_0110;
    assign song2[55]=5'b0_0110;
    assign song2[56]=5'b0_0111;
    assign song2[57]=5'b0_0001;
    assign song2[58]=5'b0_0101;
    assign song2[59]=5'b0_0011;
    assign song2[60]=5'b0_0001;
    assign song2[61]=5'b0_0110;
    assign song2[62]=5'b0_0110;
    assign song2[63]=5'b0_0111;
    assign song2[64]=5'b0_0111;
    assign song2[65]=5'b0_0111;
    assign song2[66]=5'b0_0001;
    assign song2[67]=5'b0_0010;
    assign song2[68]=5'b0_0001;
    assign song2[69]=5'b0_0111;
    assign song2[70]=5'b0_0101;
    assign song2[71]=5'b0_0110;
    assign song2[72]=5'b0_0110;
//生日快乐
assign song3[0]=5'b0_0101;
assign song3[1]=5'b0_0101;
assign song3[2]=5'b0_0110;
assign song3[3]=5'b0_0101;
assign song3[4]=5'b0_0001;
assign song3[5]=5'b0_0111;
assign song3[6]=5'b0_0101;
assign song3[7]=5'b0_0101;
assign song3[8]=5'b0_0110;
assign song3[9]=5'b0_0101;
assign song3[10]=5'b0_0010;
assign song3[11]=5'b0_0001;
assign song3[12]=5'b0_0101;
assign song3[13]=5'b0_0101;
assign song3[14]=5'b0_0101;
assign song3[15]=5'b0_0011;
assign song3[16]=5'b0_0001;
assign song3[17]=5'b0_0111;
assign song3[18]=5'b0_0110;
assign song3[19]=5'b0_0100;
assign song3[20]=5'b0_0100;
assign song3[21]=5'b0_0011;
assign song3[22]=5'b0_0001;
assign song3[23]=5'b0_0010;
//ms
assign song4[0]=5'b0_0101;
assign song4[1]=5'b0_0001;
assign song4[2]=5'b0_0001;
assign song4[3]=5'b0_0010;
assign song4[4]=5'b0_0001;
assign song4[5]=5'b0_0111;
assign song4[6]=5'b0_0110;
assign song4[7]=5'b0_0110;
assign song4[8]=5'b0_0110;
assign song4[9]=5'b0_0010;
assign song4[10]=5'b0_0010;
assign song4[11]=5'b0_0011;
assign song4[12]=5'b0_0010;
assign song4[13]=5'b0_0001;
assign song4[14]=5'b0_0111;
assign song4[15]=5'b0_0101;
assign song4[16]=5'b0_0101;
assign song4[17]=5'b0_0011;
assign song4[18]=5'b0_0011;
assign song4[19]=5'b0_0100;
assign song4[20]=5'b0_0011;
assign song4[21]=5'b0_0010;
assign song4[22]=5'b0_0001;
assign song4[23]=5'b0_0110;
assign song4[24]=5'b0_0101;
assign song4[25]=5'b0_0101;
assign song4[26]=5'b0_0110;
assign song4[27]=5'b0_0010;
assign song4[28]=5'b0_0111;
assign song4[29]=5'b0_0001;
assign song4[30]=5'b0_0101;
assign song4[31]=5'b0_0001;
assign song4[32]=5'b0_0001;
assign song4[33]=5'b0_0001;
assign song4[34]=5'b0_0111;
assign song4[35]=5'b0_0111;
assign song4[36]=5'b0_0001;
assign song4[37]=5'b0_0111;
assign song4[38]=5'b0_0110;
assign song4[39]=5'b0_0101;
assign song4[40]=5'b0_0010;
assign song4[41]=5'b0_0011;
assign song4[42]=5'b0_0010;
assign song4[43]=5'b0_0001;
assign song4[44]=5'b0_0101;
assign song4[45]=5'b0_0101;
assign song4[46]=5'b0_0101;
assign song4[47]=5'b0_0101;
assign song4[48]=5'b0_0110;
assign song4[49]=5'b0_0010;
assign song4[50]=5'b0_0111;
assign song4[51]=5'b0_0001;




    //选歌状态机
    integer i;
    always @(posedge clk)begin
        if(chosen_song==2'b00)begin
            for(i=0;i<255;i=i+1)begin
                song[i]<=song1[i];
            end
        end
    
            if(chosen_song==2'b01)begin
                for(i=0;i<255;i=i+1)begin
                    song[i]<=song2[i];
                    end
           end
        
            if(chosen_song==2'b10)begin
               for(i=0;i<255;i=i+1)begin
                    song[i]<=song3[i];
               end
            end
                    
        if(chosen_song==2'b11)begin
          for(i=0;i<255;i=i+1)begin
              song[i]<=song4[i];
          end
        end
                
    end

        
        
        //是否切歌
        reg qiege=1'b0;
        always @(posedge check) begin
            if(rollup==1'b1||rolldown==1'b1)begin
                qiege<=1'b1;
            end
            else begin
                qiege<=1'b0;
            end
        end
        //消抖！！！！！！！！！
        
        
        reg isEnd=1'b0;
//        wire [7:0]light=8'b0000_0000;
//        reg next;
//        reg change;
//        wire [7:0]song_index;
//        assign song_index=index;
        always @(posedge clk) begin
                    if(~rst)begin
                        index<=8'b0000_0000;
                        isEnd<=1'b0;
                    end
                else begin    
//                if(qiege)begin isEnd=1'b0;index<=0;end
                if(!register_lock)
                begin
                if(out_light==key && ~isEnd)begin index<=index+1;end
                else if(out_light!=key && ~isEnd && key!=8'b0000_0000)begin if(wrong==4'b1001)begin wrong <= 4'b0000;s_ten<=s_ten+1; end else wrong<=wrong+1;end
                if(isEnd) begin index<=0;end
                if(index==song_length)begin isEnd<=1'b1;end
                if(qiege)begin isEnd<=1'b0;index<=0; wrong <= 4'b0000;s_ten<=3'b000; end
                end
                register_lock <= !(8'b0000_0000==key);      
                end                 
            end                 
                        


                        always @(posedge clk) begin
                            number<=index+1'b1;
                            case(song[index][4:0])
//                             5'b00000:state_light=8'b1000_0000;
                             5'd1,5'd8,5'd15:out_light<=8'b0100_0000;
                             5'd2,5'd9,5'd16:out_light<=8'b0010_0000;
                             5'd3,5'd10,5'd17:out_light<=8'b0001_0000;
                             5'd4,5'd11,5'd18:out_light<=8'b0000_1000;
                             5'd5,5'd12,5'd19:out_light<=8'b0000_0100;
                             5'd6,5'd13,5'd12:out_light<=8'b0000_0010;
                             5'd7,5'd14,5'd21:out_light<=8'b0000_0001;
//                              default:state_light=8'b0000_0000;
                            endcase 
                            end

endmodule

