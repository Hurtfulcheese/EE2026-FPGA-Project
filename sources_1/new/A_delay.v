`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2018 14:52:03
// Design Name: 
// Module Name: A_delay
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


module A_delay(
    input [11:0] data_in,
    input [1:0] switch,
    input clk_write,
    output reg [11:0] data_out
    );

  
    initial begin
        data_out = 12'b0;
    end
    
    wire [11:0] temp2, temp3;
    //gen_delay(clk_write, data_in, temp1);
    gen_delay2(clk_write, data_in, temp2);
    gen_delay3(clk_write, data_in, temp3);
       
    always @ (switch) begin
        case (switch)
            2'b00: data_out <= data_in; //no delay
            2'b01: data_out <= temp2; //1s delay
            2'b10: data_out <= temp3; //2s delay
            default: data_out <= data_in;
          //  2'b11: data_out <= temp3; //4s delay
        endcase
    end
    
 

endmodule
