`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.04.2018 20:44:21
// Design Name: 
// Module Name: gen_delay
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


module gen_delay3(
    input CLOCK,
    input [11:0] data_in,
    output reg [11:0] data_out
    );
    initial begin
        data_out = 12'b0;
    end
    
    reg [25:0] i = 0;
    reg [11:0] memory [0:39999];
    
    //store it in memory array
    always @ (posedge CLOCK) begin //keep writing the entire clock
            memory[i] <= data_in;
            i <= (i==39999) ? 0 : i+1;
    end
        
        
    //delay counters
    reg [25:0] j = 1; 

    always @ (posedge CLOCK) begin
            data_out <= memory[j];
            j <= (j==39999) ? 0 : j+1;
    end
    
endmodule
