module color_and_effect (reset, clk, enable, strobe, display_area, serial_output, red_in, green_in, blue_in, white_in, R, G, B);
     input reset, clk, enable, strobe, display_area;
     input serial_output, red_in, green_in, blue_in, white_in;
     output reg [2:0] R, G, B;

     reg [2:0] red, green, blue;
     reg red_plus, green_plus, blue_plus;

     always @(posedge clk or posedge reset) begin
          if (reset) begin 
               R <= 0;
               G <= 0;
               B <= 0;
          end
          else if (enable) begin
               if (strobe & display_area & serial_output) begin
                    R <= 0;
                    G <= 0;
                    B <= 0;
               end
               else if (display_area & serial_output) begin
                    if (red_in == 1) begin
                         if (red_plus == 1) begin
                              red <= red + 1;
                              if (red == 7) red_plus <= 0;
                         end
                         else if (red_plus == 0) begin
                              red <= red - 1;
                              if (red == 0) red_plus <= 1;
                         end	
                    end
                    else if (green_in == 1) begin
                         if (green_plus == 1) begin
                              green <= green + 1;
                              if (green == 7) green_plus <= 0;
                         end
                         else if (green_plus == 0) begin
                              green <= green - 1;
                              if (green == 0) green_plus <= 1;
                         end	
                    end
                    else if (blue_in == 1) begin
                         if (blue_plus == 1) begin
                              blue <= blue + 1;
                              if (blue == 7) blue_plus <= 0;
                         end
                         else if (blue_plus == 0) begin
                              blue <= blue - 1;
                              if (blue == 0) blue_plus <= 1;
                         end
                    end
                    else if (white_in == 1) begin      // White means all colors maxed
                              red <= 7;
                              green <= 7;
                              blue <= 7;
                              red_plus <= 0;
                              green_plus <= 0;
                              blue_plus <= 0;
                    end
                    R <= red;
                    G <= green;
                    B <= blue;	 
               end
               else begin // Out of display area means everything else needs to be black  
                    R <= 0;
                    G <= 0;
                    B <= 0;
               end
          end	
     end

endmodule


