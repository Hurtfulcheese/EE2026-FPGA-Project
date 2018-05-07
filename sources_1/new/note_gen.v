`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2018 15:52:15
// Design Name: 
// Module Name: note_gen
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


module note_gen(
    input CLOCK,
    input[25:0] CLOCK_COUNTER,
    output reg [11:0] NOTE
    );
        
    initial begin
       NOTE = 12'b0;
    end
        
    reg [25:0] COUNT = 26'b0;
    
    //C Note 
    always @(posedge CLOCK) begin
        if (CLOCK_COUNTER > 0) begin
            COUNT <= (COUNT == (CLOCK_COUNTER) ) ? 0 : COUNT + 1;
            NOTE  <= (COUNT == 0) ? ~NOTE : NOTE;
        end
    end
    
    
endmodule
