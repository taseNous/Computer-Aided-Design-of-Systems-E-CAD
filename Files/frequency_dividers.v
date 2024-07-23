module frequency_dividers (reset, clk, pixel_en, pwm_en);
     input reset, clk;
     output pixel_en, pwm_en;
     wire first, second, third;

     // Pixel clock (25MHz)
     cnt4 i0 (reset, clk, 1'b1, pixel_en);

     // PWM clock (6.4kHz)
     cnt25 i1 (reset, clk, 1'b1, first);
     cnt25 i2 (reset, clk, first, second);
     cnt25 i3 (reset, clk, first & second, third);
     assign pwm_en = first & second & third;
	  
endmodule
