////////////EXTRA FEATURE//////////////////
module vga_pong
	(
		input wire clk, reset,
		input left, right,
		output wire hsync, vsync,
		output [11:0] rgb,
		
		output [11:0] sound
	);
	


	localparam key_width = 60;
    localparam key_border_width = 4;
    localparam keyboard_x_l = 66;//0;
    localparam keyboard_x_r = 573; //639; 
    localparam keyboard_y_u = 191;
    localparam keyboard_y_d = 523; 
    
    localparam COL_WHITE = 12'b111111111111;
    localparam COL_BLACK = 12'b000000000000; 
    localparam COL_BALL = 12'b001011111010;
	
	//paddle
    reg [10:0] paddle_x_l = 0;//0;
    reg [10:0] paddle_x_r = 50; //639; 
    reg [10:0] paddle_y_u = 469;
    reg [10:0] paddle_y_d = 479; 
	
	//ball
	reg [10:0] ball_x_l = 22;
    reg [10:0] ball_x_r = 28;  
    reg [10:0] ball_y_u = 463;
    reg [10:0] ball_y_d = 469; 
       
	reg [11:0] rgb_reg;
	wire [9:0] x, y;
	
	reg paddle_reverse = 0;
    reg ball_x_reverse = 0;
    reg ball_y_reverse = 0;
    reg ball_stop = 0;
    reg paddle_stop = 0;    
    
    reg booleanAdd = 0;
    reg add=0;
    
    reg [3:0] toggle = 4'b0100;
        reg [6:0] note = 7'b00000000;
        reg [17:0] played = 1;
        reg hit = 0;
        music_instrument ms(clk, toggle, note, sound);
    
    always begin
        paddle_stop = ~(left || right);
    end                
	// video status output from vga_sync to tell when to route out rgb signal to DAC
	wire video_on;
    reg [17:0] COUNT = 0;
    reg SLOW_CLK = 0;
        // instantiate vga_sync
        vga_sync vga_sync_unit (.clk(clk), .reset(reset), .hsync(hsync), .vsync(vsync),
                                .video_on(video_on), .p_tick(), .x(x), .y(y));
   
        // rgb buffer
        /*always @(posedge clk, posedge reset) begin
            if (reset) begin
                rgb_reg <= 0; end
            else begin
                rgb_reg <= sw; end                 
        end*/
        
         always @ (posedge clk) begin
                if (hit) begin
                        note <= 7'b01000000;
                        played <= played + 1;
                end
                else begin
                        note <= 7'b0;
                end
           end
       
        
        always @ (posedge clk, posedge reset) begin
            if (reset) begin COUNT <= 0; end
            COUNT <= COUNT+1;
            SLOW_CLK = (COUNT == 0)? ~SLOW_CLK : SLOW_CLK;
        end
        
        always @ (posedge clk,posedge reset) begin
            if (reset) begin paddle_reverse = 0; end
            else begin
                if (left) begin //&& paddle_x_r == 639) begin
                    paddle_reverse <= 1;
                end
                else begin
                    if (right) begin //&& paddle_x_l == 0) begin
                        paddle_reverse <= 0;
                    end
                end
            end                
        end
        
        always @ (posedge clk, posedge reset) begin
            if (reset) begin ball_x_reverse <= 0; end
            else begin
                if (ball_x_r == 639) begin
                    ball_x_reverse <= 1;
                end
                if (ball_x_l == 0) begin
                    ball_x_reverse <= 0;
                end       
            end         
        end
        
        always @ (posedge clk, posedge reset) begin
            if (reset) begin ball_y_reverse <= 0; ball_stop<=0; end
            else begin
                if (ball_y_u == 20) begin
                    ball_y_reverse <= 0;
                end
                if (ball_y_d == 469) begin
                     
                    if (ball_x_l > paddle_x_l && ball_x_r < paddle_x_r) begin 
                        ball_y_reverse <= 1;
                        
                        hit <= 1;
                        ////////////////////
                  
                    end
                end                
                if (ball_y_d == 479) begin
                    ball_stop <= 1;
                end
                if (played == 0) begin
                    hit <= 0;
                end
                
       
            end
        end        
                
        always @ (posedge SLOW_CLK, posedge reset) begin
            if (reset) begin 
                paddle_x_l <= 0;//0;
                paddle_x_r <= 50; //639; 
                paddle_y_u <= 469;
                paddle_y_d <= 479; 
                
                //ball
                ball_x_l <= 22;
                ball_x_r <= 28;  
                ball_y_u <= 463;
                ball_y_d <= 469;
            end
            else begin
                if (!paddle_stop && !ball_stop) begin
                    if (paddle_reverse) begin
                        if (paddle_x_l > 0) begin
                            paddle_x_l <= paddle_x_l - 1;
                            paddle_x_r <= paddle_x_r - 1;
                        end
                    end
                    else begin
                        if (paddle_x_r < 639) begin
                            paddle_x_l <= paddle_x_l + 1;
                            paddle_x_r <= paddle_x_r + 1;
                        end
                    end
                end
                if (!ball_stop) begin
                    if (ball_x_reverse) begin
                        ball_x_l <= ball_x_l - 1;
                        ball_x_r <= ball_x_r - 1;
                    end
                    else begin
                        ball_x_l <= ball_x_l + 1;
                        ball_x_r <= ball_x_r + 1;
                    end
                    if (ball_y_reverse) begin
                        ball_y_u <= ball_y_u - 1;
                        ball_y_d <= ball_y_d - 1;
                    end
                    else begin
                        ball_y_u <= ball_y_u + 1;
                        ball_y_d <= ball_y_d + 1;
                    end
                    
                end
                
             
            end
        end
        
        always @ (posedge clk , posedge reset) begin
            if (reset) begin rgb_reg <= 0; end
            else begin 
                if((x > ball_x_l && x < ball_x_r) && (y > ball_y_u && y < ball_y_d))
                    begin rgb_reg <= COL_BALL; end
                else if((x > paddle_x_l && x < paddle_x_r) && (y > paddle_y_u && y < paddle_y_d))
                    begin rgb_reg <= COL_WHITE; end
                else begin rgb_reg <= 0; end
            end  
        end
        assign rgb = (video_on) ? rgb_reg : 12'b0 ;
                    
endmodule