`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2018 15:08:27
// Design Name: 
// Module Name: test_A_delay
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


module test_A_delay(

    );
    
     reg [11:0] data_in;
     reg clk_write;
     
     wire pitch_shift;
     
     A_delay dut(data_in, clk_write, pitch_shift);
     
     always @(posedge clk_write) begin
        pitch_shift <= pitch_shift + 1;
    end
    
endmodule
