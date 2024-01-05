`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/01 10:11:49
// Design Name: 
// Module Name: Buzzer
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

module Buzzer (
 input wire clk , // Clock signal
 input wire [4:0] note , // Note ( Input 1 outputsa signal for 'do , ' 2 for 're , ' 3 for 'mi , ' 4 ,and so on)
 output wire speaker // Buzzer output signal
  ) ;
  wire [31:0] notes [31:0];
  reg [31:0] counter ;
  reg pwm ;
  
  // Frequencies of do , re , mi , fa , so , la , si
  // Obtain the ratio of how long the buzzer should be active in one second
  assign notes [0]= 0;
  assign notes [1]= 381680;
  assign notes [2]= 340136;
  assign notes [3]= 303030;
  assign notes [4]= 285714;
  assign notes [5]= 255102;
  assign notes [6]= 227273;
  assign notes [7]= 202429;
    
   assign notes [8]= 763360;
   assign notes [9]= 680272;
   assign notes [10]= 606060;
   assign notes [11]= 571428;
   assign notes [12]= 510204;
   assign notes [13]= 454546;
   assign notes [14]= 404858;
   
    assign notes [15]= 190840;
    assign notes [16]= 170068;
    assign notes [17]= 151515;
    assign notes [18]= 142587;
    assign notes [19]= 127551;
    assign notes [20]= 113637;
    assign notes [21]= 101215;
    
    assign notes[22]= 360808;// high do
    assign notes[23]= 321444;// high re
    assign notes[24]= 270301;// high fa
    assign notes[25]= 240811;// high so
    assign notes[26]= 214538;// high la
  initial
    begin
      pwm = 0;
    end
  always @ ( posedge clk ) begin
    if ( counter < notes [note]|| note ==1'b0 ) begin
      counter <= counter + 1'b1 ;
    end else begin
       pwm =~ pwm ;
       counter <= 0;
     end
   end

   assign speaker = pwm ; // Output a PWM signal to the buzzer
endmodule

