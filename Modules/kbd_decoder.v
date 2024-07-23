module kbd_decoder (reset, clk, valid, scancode, start_address_out, char_enable, R, G, B, W, S, D, U, L, pwm_amount, pwm_select);
     input [7:0] scancode;
     input reset, clk, valid;
     output reg char_enable, R, G, B, W, S, D, U, L;
     output reg [3:0] pwm_amount;
     output reg [2:0] start_address_out;
     output reg [1:0] pwm_select;

     always @(posedge clk or posedge reset ) begin 
          if(reset) begin
               char_enable <= 0;
               R <= 0;
               G <= 0;
               B <= 0;
               W <= 0;
               D <= 0;
               S <= 0;
               U <= 0;
               L <= 0;
          end
          else begin
               if (valid) begin
                    case(scancode)
                         8'h2B: begin                    //Character: F 
                              start_address_out <= 3'b000; 
                              char_enable <= 1;
                              pwm_amount <= 4'b0110;
                              pwm_select <= 2'b01;
                              L <= 0;
                         end
                         8'h15: begin                    //Character: Q
                              start_address_out <= 3'b001; 
                              char_enable <= 1;
                              pwm_amount <= 4'b1000;
                              pwm_select <= 2'b01;
                              L <= 0;
                         end					
                         8'h33: begin                    //Character: H
                              start_address_out <= 3'b010; 
                              char_enable <= 1;
                              pwm_amount <= 4'b1010;
                              pwm_select <= 2'b01;
                              L <= 0;
                         end
                         8'h31: begin                    //Character: N
                              start_address_out <= 3'b011; 
                              char_enable <= 1;
                              pwm_amount <= 4'b1011;
                              pwm_select <= 2'b01;
                              L <= 0;
                         end
                         8'h22: begin                    //Character: X
                              start_address_out <= 3'b100 ; 
                              char_enable <= 1;
                              pwm_amount <= 4'b1101;
                              pwm_select <= 2'b01;
                              L <= 0;
                         end
                         8'h4B: begin                    //Character: L
                              start_address_out <= 3'b101 ; 
                              char_enable <= 1;
                              pwm_select <= 2'b01;
                              L <= 1;
                         end
                         8'h3B: begin                    //Character: J
                              start_address_out <= 3'b110 ; 
                              char_enable <= 1;
                              pwm_select <= 2'b10;
                         end
                         8'h2d: begin                    //Character: R
                              R <= 1;
                              G <= 0;
                              B <= 0;	
                              W <= 0;
                         end	
                         8'h34: begin                    //Character: G
                              R <= 0;
                              G <= 1;
                              B <= 0;	
                              W <= 0;
                         end	
                         8'h32: begin                    //Character: B
                              R <= 0;
                              G <= 0;
                              B <= 1;	
                              W <= 0;
                         end
                         8'h1D: begin                    // Character: W
                              R <= 0;
                              G <= 0;
                              B <= 0;	
                              W <= 1;
                         end
                         8'h1B: begin                    // Character: S
                              S <= 1;
                              D <= 0;
                              U <= 0;
                         end
                         8'h23: begin                    // Character: D
                              S <= 0;
                              D <= 1;
                              U <= 0;
                         end
                         8'h3C: begin                    // Character: U
                              S <= 0;
                              D <= 0;
                              U <= 1;
                         end
                         default : begin
                              char_enable <= 1;
                              start_address_out <= start_address_out;
                         end
                    endcase
               end
          end
     end

endmodule
