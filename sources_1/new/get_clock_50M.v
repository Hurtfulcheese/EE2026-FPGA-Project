`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2018 13:03:22
// Design Name: 
// Module Name: get_clock_20k
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


module get_clock_50M(
    input CLOCK,
    output reg new_clk
    );
    
    initial begin
        new_clk = 0;
    end
    
    reg COUNT = 1'b0;
    
    always @ (posedge CLOCK) begin
        COUNT <= COUNT + 1;
        new_clk <= (COUNT == 1'b0) ? ~new_clk : new_clk;
    end
    
endmodule
