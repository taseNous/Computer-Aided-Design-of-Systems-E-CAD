module char_iterator (display, line, starting_address, address_output);
     input [2:0] starting_address;
     input [3:0] line;
     input display;
     output [6:0] address_output;

     assign address_output = (display) ? {starting_address, line} : 0;

endmodule
