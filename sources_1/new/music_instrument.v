`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2018 16:30:33
// Design Name: 
// Module Name: music_instrument
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


module music_instrument(
    input CLOCK,
    input [3:0] toggle,
    input [6:0] keyboard,
    output reg [11:0] note
    );
    
    wire [11:0] gen_note;
    reg [25:0] COUNTER;
    reg [5:0] LEFT_SHIFT; 
    note_gen GEN(CLOCK, COUNTER , gen_note);

    initial begin
        COUNTER = 0;
        LEFT_SHIFT = 0;
    end    
    always @(COUNTER) begin
        note = gen_note;
    end    
    
    always @(*) begin
        case (toggle)
            0  : LEFT_SHIFT = 0;
            1  : LEFT_SHIFT = 1;
            2  : LEFT_SHIFT = 2;
            4  : LEFT_SHIFT = 3;
            8  : LEFT_SHIFT = 4;
            default : LEFT_SHIFT = 0;
        endcase
    end    

    always @(keyboard, LEFT_SHIFT) begin
        case (keyboard)
            1  : COUNTER = 191111 >> LEFT_SHIFT;
            2  : COUNTER = 170261 >> LEFT_SHIFT;
            4  : COUNTER = 151685 >> LEFT_SHIFT;
            8  : COUNTER = 143172 >> LEFT_SHIFT;
            16 : COUNTER = 127552 >> LEFT_SHIFT;            
            32 : COUNTER = 113635 >> LEFT_SHIFT;
            64 : COUNTER = 101238 >> LEFT_SHIFT;
            default : COUNTER = 0;
        endcase
    end
    
endmodule
