module parallel_to_serial (reset, clk, enable, parallel_in, display_area_enable, serial_out);
     input [7:0] parallel_in;
     input reset, clk, enable, display_area_enable;
     output serial_out;

     reg [2:0] counter;
     reg serial_out;

     always @(posedge clk or posedge reset) begin
          if (reset) begin
               counter <= 0;
               serial_out <= 0;
          end
          else if (enable) begin
               if (display_area_enable == 0) begin
                    counter <= 0;
                    serial_out <= 0;
               end
               else begin 
                    serial_out <= parallel_in[7 - counter];
                    if (counter == 3'd7) counter <= 0;
                    else counter <= counter + 1;
               end
          end
     end

endmodule
