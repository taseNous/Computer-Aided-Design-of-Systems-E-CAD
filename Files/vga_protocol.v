module vga_protocol (reset, clk, hsync, vsync, display_area, line);
     input reset, clk;
     output hsync, vsync, display_area;
     output [3:0] line;

     reg [9:0] pixel_counter;
     reg [8:0] line_counter;

     // VGA parameters (Horizontal)
     parameter H_FRONT_PORCH = 16;
     parameter H_SYNC_PULSE = 96;
     parameter H_BACK_PORCH = 48;
     parameter H_VISIBLE_PIXELS = 640;
     parameter H_END = 800;                   // H_END = H_FRONT_PORCH + H_SYNC_PULSE + H_BACK_PORCH + H_VISIBLE_LINES

     // VGA parameters (Vertical)
     parameter V_FRONT_PORCH = 12;
     parameter V_SYNC_PULSE = 2;
     parameter V_BACK_PORCH = 35;
     parameter V_VISIBLE_LINES = 400;
     parameter V_END = 449;                   // V_END = V_FRONT_PORCH + V_SYNC_PULSE + V_BACK_PORCH + V_VISIBLE_LINES

     // VGA parameters (Character Borders)
     parameter H_LEFT_BORDER = 475;           // ((H_END + (H_FRONT_PORCH + H_SYNC_PULSE + H_BACK_PORCH)) / 2) - 4   <-- Starts counting from here
     parameter H_RIGHT_BORDER = 482;          // H_LEFT_BORDER + 8 - 1 additional pixels, for the 8-bit width of our characters
     parameter V_TOP_BORDER = 216;            // (V_FRONT_PORCH + V_SYNC_PULSE + V_BACK_PORCH + V_VISIBLE_LINES - 1) / 2
     parameter V_BOTTOM_BORDER = 231;         // V_TOP_BORDER + 16 - 1 additional rows, for the 16-bit height of our characters



     always @(posedge clk or posedge reset) begin
          if (reset) begin
               pixel_counter <= 0;
               line_counter <= 0;	  
          end
          else if (pixel_counter == H_END) begin                    // If we're on the right-hand side of the monitor
               pixel_counter <= 0;
               if (line_counter == V_END) line_counter <= 0;        // If we're on the final line, zero the line_counter to start over
               else line_counter <= line_counter + 1;               // Otherwise, continue incrementing it
          end
               else pixel_counter <= pixel_counter + 1;             // If we're NOT on the right-hand side
     end

     assign hsync = (pixel_counter > H_FRONT_PORCH-1 && pixel_counter < H_FRONT_PORCH + H_SYNC_PULSE) ? 0 : 1;      // 112 > pixel_counter > 15
     assign vsync = (line_counter > V_FRONT_PORCH-1 && line_counter < V_FRONT_PORCH + V_SYNC_PULSE) ? 1 : 0;        // 14 > line_counter > 11

     assign display_area = (pixel_counter >= H_LEFT_BORDER && pixel_counter <= H_RIGHT_BORDER && line_counter >= V_TOP_BORDER && line_counter <= V_BOTTOM_BORDER) ? 1 : 0;
     assign line = (line_counter >= V_TOP_BORDER ) ? (line_counter - V_TOP_BORDER) : 0;   // Calculate distance (in lines) from top border. Goes to char_iterator
                                                                                          // to get character address from ROM 
endmodule

