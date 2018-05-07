`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2018 20:40:38
// Design Name: 
// Module Name: SSD2
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


module SSD2(
    input CLK,
    input [3:0] score,
    
    output [3:0] ANODE,
    output reg [6:0] seg,
    output dp
    );
    
     parameter [3:0] enable_arr = 4'b1111;
     reg [3:0] CURRENT_PLACE_AN;
     reg [18:0] COUNT;
     
     assign ANODE = ~(enable_arr & CURRENT_PLACE_AN);// AN signals are active low,
     assign dp = 1;
         
     initial begin
        COUNT = 0;
        seg = 7'b1111111;
     end
     
     always @ (posedge CLK) begin
        COUNT <= COUNT + 1;
     end
     
     always @(COUNT) begin
         case (COUNT[18:17])
             2'b00: begin CURRENT_PLACE_AN = 4'b1000; end  
             2'b01: begin CURRENT_PLACE_AN = 4'b0100; end
             2'b10: begin CURRENT_PLACE_AN = 4'b0010; end
             2'b11: begin CURRENT_PLACE_AN = 4'b0001; end
             default: CURRENT_PLACE_AN = 4'b0000;
         endcase  
     end
     
      always @(CURRENT_PLACE_AN, score) begin      
         if(score<10) begin
            case (score)
                0: begin
                    case (CURRENT_PLACE_AN)
                    4'b0001: seg = 7'b0000001; //0
                    default: seg = 7'b1111111;
                    endcase
                   end
                1: begin
                     case (CURRENT_PLACE_AN)
                     4'b0001: seg = 7'b1001111; //1
                     default: seg = 7'b1111111;
                     endcase
                   end
                2: begin
                     case (CURRENT_PLACE_AN)
                     4'b0001: seg = 7'b0010010; //2
                     default: seg = 7'b1111111;
                     endcase
                   end
                3: begin
                      case (CURRENT_PLACE_AN)
                      4'b0001: seg = 7'b0000110; //3
                      default: seg = 7'b1111111;
                      endcase
                   end
                   
                4:begin
                   case (CURRENT_PLACE_AN)
                   4'b0001: seg = 7'b1001100; //4
                   default: seg = 7'b1111111;
                   endcase
                   end
                5:begin
                  case (CURRENT_PLACE_AN)
                  4'b0001: seg = 7'b0100100; //5
                  default: seg = 7'b1111111;
                  endcase
                  end
                  
                6: begin
                   case (CURRENT_PLACE_AN)
                   4'b0001: seg = 7'b0100000; //6
                   default: seg = 7'b1111111;
                   endcase
                   end
                   
                7:begin
                  case (CURRENT_PLACE_AN)
                  4'b0001: seg = 7'b0001111; //7
                  default: seg = 7'b1111111;
                  endcase
                  end
                  
                8:begin
                  case (CURRENT_PLACE_AN)
                  4'b0001: seg = 7'b0000000; //8
                  default: seg = 7'b1111111;
                  endcase
                  end    
                              
                9:begin
                  case (CURRENT_PLACE_AN)
                  4'b0001: seg = 7'b0000100; //9
                  default: seg = 7'b1111111;
                  endcase
                  end   
             endcase
          end  
          else begin
            seg = 7'b1111111;
          end                 
        end
endmodule
