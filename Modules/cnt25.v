module cnt25 (reset, clk, enable, clkdiv25);
     input reset, clk, enable;
     output clkdiv25;
     reg [4:0] cnt;

     assign clkdiv25 = (cnt == 6'd24);
     always @(posedge clk or posedge reset)
          if (reset) cnt <= 0;
          else if (enable)
               if (clkdiv25) cnt <= 0;
               else cnt <= cnt + 1;

endmodule
