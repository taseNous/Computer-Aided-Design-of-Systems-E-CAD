module kbd_protocol_modified (reset, clk, ps2clk, ps2data, scancode, valid);
     input reset, clk, ps2clk, ps2data;
     output [7:0] scancode;
     output valid;
     reg [7:0] scancode;
     reg valid;
  
     // Synchronize ps2clk to local clock and check for falling edge;
     reg [7:0] ps2clksamples; // Stores last 8 ps2clk samples

     always @(posedge clk or posedge reset)
          if (reset) ps2clksamples <= 8'd0;
          else ps2clksamples <= {ps2clksamples[7:0], ps2clk};

     wire fall_edge;    // Indicates a falling_edge at ps2clk
     assign fall_edge = (ps2clksamples[7:4] == 4'hF) & (ps2clksamples[3:0] == 4'h0);

     reg [9:0] shift;   // Stores a serial package, excluding the stop bit;
     reg [3:0] cnt;     // Used to count the ps2data samples stored so far
     reg f0;            // Used to indicate that f0 was encountered earlier
  
     // A simple FSM is implemented here. Grab a whole package, check
     // its parity validity and output it in the scancode only if the
     // previous read value of the package was F0, that is, we only
     // trace when a button is released, NOT when it is pressed
  
     always @(posedge clk or posedge reset) begin
          valid <= 0;
          if (reset) begin
               cnt <= 0;
               scancode <= 0;
               shift <= 0;
               f0 <= 0;
               valid <= 0;
          end  
          else if (fall_edge) begin
               if (cnt == 4'd10) begin // We just received what should be the stop bit
                    cnt <= 0;
                    if ((shift[0] == 0) && (ps2data == 1) && (^shift[9:1]==1)) begin // A well received serial packet
                         if (f0) begin // Following a scancode of f0. So a key is released! 
                              scancode <= shift[8:1];
                              f0 <= 0;
                              valid <= 1; // A valid key has been pressed (used later for previous_character.v)
                         end
                         else if (shift[8:1] == 8'hF0) f0 <= 1'b1;
                    end // All other packets have to do with key presses and are ignored
               end
               else begin
                    shift <= {ps2data, shift[9:1]}; // Shift right since LSB first is transmitted
                    cnt <= cnt + 1;
               end
          end
     end

endmodule