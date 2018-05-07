`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.04.2018 14:45:46
// Design Name: 
// Module Name: SSD
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


module test(
    input CLK,
    input [1:0] caseSwitches,
    input [10:0] sw, 
    input [1:0] swD,
    
    output [3:0] ANODE,
    output reg [6:0] seg,
    output dp
    );
    
    parameter [3:0] enable_arr = 4'b1111;
    reg [3:0] CURRENT_PLACE_AN;
    reg [18:0] COUNT;
    reg [4:0] scroll;
    
    assign ANODE = ~(enable_arr & CURRENT_PLACE_AN);// AN signals are active low,
    assign dp = 1;
    
    initial begin
        COUNT = 0;
        scroll = 0;
        seg = 7'b1111111;
    end
    

    always @ (posedge CLK) begin
        COUNT <= COUNT + 1;
    end
    
    wire clock_2Hz;
    get_clock_2Hz f3(CLK, clock_2Hz);
    always @ (posedge clock_2Hz) begin 
        scroll <= (scroll==8) ? 0 : scroll + 1;
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
    
    always @(sw, caseSwitches, CURRENT_PLACE_AN, swD) begin
        case (caseSwitches)
            2'b00:
                    case (scroll)
                        0: begin
                          case (CURRENT_PLACE_AN)
                             4'b0001: seg = 7'b0110000; //E
                             default: seg = 7'b1111111; 
                          endcase
                          end
                        
                        1: begin
                           case (CURRENT_PLACE_AN)
                               4'b0001: seg = 7'b0110000; //E
                               4'b0010: seg = 7'b0110000; //E
                               default: seg = 7'b1111111; 
                           endcase
                           end
                           
                        2: begin
                           case (CURRENT_PLACE_AN)
                              4'b0001: seg = 7'b0010010; //2
                              4'b0010: seg = 7'b0110000; //E
                              4'b0100: seg = 7'b0110000; //E
                              default: seg = 7'b1111111; 
                           endcase
                           end
                           
                        3: begin                        
                           case (CURRENT_PLACE_AN)
                              4'b0001: seg = 7'b0000001; //0
                              4'b0010: seg = 7'b0010010; //2
                              4'b0100: seg = 7'b0110000; //E
                              4'b1000: seg = 7'b0110000; //E
                              //default: seg = 7'b1111111; 
                           endcase
                           end   

                        4: begin                        
                           case (CURRENT_PLACE_AN)
                              4'b0001: seg = 7'b0010010; //2
                              4'b0010: seg = 7'b0000001; //0
                              4'b0100: seg = 7'b0010010; //2
                              4'b1000: seg = 7'b0110000; //E
                              //default: seg = 7'b1111111; 
                           endcase
                           end

                        5: begin                        
                           case (CURRENT_PLACE_AN)
                              4'b0001: seg = 7'b0100000; //6
                              4'b0010: seg = 7'b0010010; //2
                              4'b0100: seg = 7'b0000001; //0
                              4'b1000: seg = 7'b0010010; //2
                              //default: seg = 7'b1111111; 
                           endcase
                           end
 
                        6: begin                        
                           case (CURRENT_PLACE_AN)
                             4'b0010: seg = 7'b0100000; //6
                             4'b0100: seg = 7'b0010010; //2
                             4'b1000: seg = 7'b0000001; //0
                             default: seg = 7'b1111111; 
                          endcase
                          end 
                            
                        7: begin                        
                           case (CURRENT_PLACE_AN)
                             4'b0100: seg = 7'b0100000; //6
                             4'b1000: seg = 7'b0010010; //2                           
                             default: seg = 7'b1111111; 
                           endcase
                           end
                        
                        8: begin
                           case (CURRENT_PLACE_AN)
                            4'b1000: seg = 7'b0100000; //6
                            default: seg = 7'b1111111;
                           endcase
                           end                                                                       
                    
                    endcase
            
            2'b01 : //delay -> to display the number of seconds of delay
                case (CURRENT_PLACE_AN)
                    4'b0001:
                        seg = 7'b0100100; //display 5 -> s
                        
                    4'b0010:
                        case (swD[1:0])
                            2'b00: seg = 7'b0000001; //0 delay
                            2'b01: seg = 7'b1001111; //1
                            2'b10: seg = 7'b0010010; //2
                            2'b11: seg = 7'b1001100; //3
                            default: seg = 7'b0000001;
                        endcase
                        
                    4'b1000:
                        seg = 7'b1000010; //display D -> D for Delay
                        
                    default: seg = 7'b1111111;
                endcase         
                    
            2'b10 : //music instrument
                case (CURRENT_PLACE_AN)
                    default: seg = 7'b1111111;
                    4'b0010:
                        case (sw[6:0])
                            7'b0000001 : seg = 7'b0110001; //C
                            7'b0000010 : seg = 7'b1000010; //D
                            7'b0000100 : seg = 7'b0110000; //E
                            7'b0001000 : seg = 7'b0111000; //F
                            7'b0010000 : seg = 7'b0100001; //G     
                            7'b0100000 : seg = 7'b0001000; //A
                            7'b1000000 : seg = 7'b1100000; //B
                            default : seg = 7'b1111111;
                        endcase        
                    4'b0001: begin
                        if ((sw[6:0]==1) || (sw[6:0]==2) || (sw[6:0]==4) || (sw[6:0] == 8) || (sw[6:0] == 16) || (sw[6:0] == 32) || (sw[6:0] == 64)) begin
                            case (sw[10:7])
                                4'b0000 : //4
                                    if (sw[6:0] != 7'b0) begin 
                                        seg = 7'b1001100;
                                    end 
                                    else begin
                                        seg = 7'b1111111;
                                    end
                                    
                                4'b0001 : seg = 7'b0100100; //5
                                4'b0010 : seg = 7'b0100000; //6
                                4'b0100 : seg = 7'b0001111; //7
                                4'b1000 : seg = 7'b0000000; //8
                                default : seg = 7'b1111111; //nothing
                            endcase    
                        end
                        else begin
                            seg = 7'b1111111;
                        end    
                    end
                    
                endcase
                
             default: seg = 7'b1111111;
        endcase
                    
    end
endmodule

        //        5'b00000: segment = 7'b0000001;   //0
        //        5'b00001: segment = 7'b1001111;   //1
        //        5'b00010: segment = 7'b0010010;   //2
        //        5'b00011: segment = 7'b0000110;   //3
        //        5'b00100: segment = 7'b1001100;   //4
        //        5'b00101: segment = 7'b0100100;   //5
        //        5'b00110: segment = 7'b0100000;   //6
        //        5'b00111: segment = 7'b0001111;   //7
        //        5'b01000: segment = 7'b0000000;   //8
        //        5'b01001: segment = 7'b0000100;   //9
