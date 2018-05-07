`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2018 15:47:57
// Design Name: 
// Module Name: A_delay_echo
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


module A_delay_echo(
    input data_in1,
    input data_in2,
    input clk_write,
    output reg data_out
    );
    
    reg [11:0] memory [0:19999];
    reg [24:0] i = 0;
    reg [24:0] ii = 12;
    
    initial begin
        data_out = 12'b0;
    end
    
    always @ (posedge clk_write) begin
         memory[i] <= data_in1;
         i <= (i==19999) ? 0 : i+1;
         
         memory[ii] <= data_in2;
         ii <= (ii==19999) ? 0 : ii+1;
    end


    //assigning
    reg [13:0] j = 10;
 
    always @ (posedge clk_write) begin
        data_out <= memory[j];
        j <= (j==19999) ? 0 : j+1;
    end
    
endmodule
