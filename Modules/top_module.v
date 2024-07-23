module top_module (reset, clk, hsync, vsync, red, green, blue, pwm_out_base);
     input reset, clk;
     output hsync, vsync, pwm_out_base;
     output [2:0] red, green, blue;

     wire [7:0] scancode, rom_data;
     wire display_area, char_enable;
     wire [6:0] address;
     wire [2:0] start_address;
     wire serial_out, red_in, green_in, blue_in, white_in;
     wire [3:0] pwm_amount, line;
     wire [3:0] base_pwm_amount;
     wire double_strobe, strobe, uniform;
     wire strobe_enable_effect;
     wire L;
	  
     assign base_pwm_amount = pwm_amount;
     assign strobe_enable_effect = double_strobe | strobe;

     // Timing-related instantiations
     frequency_dividers freq_div (reset, clk, pixel_en, pwm_en);
	  
	  kbd_protocol_modified keyboard_protocol (reset, pixel_en, ps2clk, ps2data, scancode, valid);
     kbd_decoder scan_decode (reset, pixel_en, valid, scancode, start_address, char_enable, red_in, green_in, blue_in, white_in, strobe, double_strobe, uniform, L, pwm_amount, {claw, base});

     char_iterator iterator (display_area, line, start_address, address);
     char_rom characters (address, char_enable, rom_data);
     parallel_to_serial p2s (reset, clk, pixel_en, rom_data, display_area, serial_out);
		
     // Display-related instantiations
     vga_protocol monitor (reset, pixel_en, hsync, vsync, display_area, line);
     color_and_effect color_strobe (reset, clk, pixel_en, strobing_out, display_area, serial_out, red_in, green_in, blue_in, white_in, red, green, blue);
     pwm base_pwm (reset, clk, pwm_en, base, pixel_en & pwm_en, base_pwm_amount, pwm_out_base);
        
endmodule
