module cnt4 (reset, clk, enable, clkdiv4);
     input reset, clk, enable;
     output clkdiv4;
     reg [1:0] cnt;

     assign clkdiv4 = (cnt == 2'd3);
     always @(posedge clk or posedge reset)
          if (reset) cnt <= 0;
          else if (enable) cnt <= cnt + 1;

endmodule
