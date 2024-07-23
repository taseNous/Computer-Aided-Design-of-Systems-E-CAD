module char_rom (address, enable, data_out);
     input [6:0] address;
     input enable;
     output [7:0] data_out;

     // Character output from ROM if enable = 1
     // Each group of 16 lines is a full character
     // Default case is for enable = 0, so no output
     assign data_out = (enable) ? 
                   // Character: F (for folded)
                   (address == 7'b0000000) ? 8'b11111111 :
                   (address == 7'b0000001) ? 8'b11111110 :
                   (address == 7'b0000010) ? 8'b11000000 :
                   (address == 7'b0000011) ? 8'b11000000 :
                   (address == 7'b0000100) ? 8'b11000000 :
                   (address == 7'b0000101) ? 8'b11000000 :
                   (address == 7'b0000110) ? 8'b11000000 :
                   (address == 7'b0000111) ? 8'b11111100 :
                   (address == 7'b0001000) ? 8'b11111000 :
                   (address == 7'b0001001) ? 8'b11000000 :
                   (address == 7'b0001010) ? 8'b11000000 :
                   (address == 7'b0001011) ? 8'b11000000 :
                   (address == 7'b0001100) ? 8'b11000000 :
                   (address == 7'b0001101) ? 8'b11000000 :
                   (address == 7'b0001110) ? 8'b11000000 :
                   (address == 7'b0001111) ? 8'b10000000 :

                   // Character: Q (for quarter extension)
                   (address == 7'b0010000) ? 8'b00011000 :
                   (address == 7'b0010001) ? 8'b00111100 :
                   (address == 7'b0010010) ? 8'b01100110 :
                   (address == 7'b0010011) ? 8'b01100110 :
                   (address == 7'b0010100) ? 8'b11000011 :
                   (address == 7'b0010101) ? 8'b11000011 :
                   (address == 7'b0010110) ? 8'b11000011 :
                   (address == 7'b0010111) ? 8'b11000011 :
                   (address == 7'b0011000) ? 8'b11000011 :
                   (address == 7'b0011001) ? 8'b11001011 :
                   (address == 7'b0011010) ? 8'b11011111 :
                   (address == 7'b0011011) ? 8'b11001111 :
                   (address == 7'b0011100) ? 8'b01101110 :
                   (address == 7'b0011101) ? 8'b01100110 :
                   (address == 7'b0011110) ? 8'b00111111 :
                   (address == 7'b0011111) ? 8'b00011010 :

                   // Character: H (for half)
                   (address == 7'b0100000) ? 8'b10000001 :
                   (address == 7'b0100001) ? 8'b11000011 :
                   (address == 7'b0100010) ? 8'b11000011 :
                   (address == 7'b0100011) ? 8'b11000011 :
                   (address == 7'b0100100) ? 8'b11000011 :
                   (address == 7'b0100101) ? 8'b11000011 :
                   (address == 7'b0100110) ? 8'b11000011 :
                   (address == 7'b0100111) ? 8'b11111111 :
                   (address == 7'b0101000) ? 8'b11111111 :
                   (address == 7'b0101001) ? 8'b11000011 :
                   (address == 7'b0101010) ? 8'b11000011 :
                   (address == 7'b0101011) ? 8'b11000011 :
                   (address == 7'b0101100) ? 8'b11000011 :
                   (address == 7'b0101101) ? 8'b11000011 :
                   (address == 7'b0101110) ? 8'b11000011 :
                   (address == 7'b0101111) ? 8'b10000001 :

                   // Character: N (for near extension)
                   (address == 7'b0110000) ? 8'b10000001 :
                   (address == 7'b0110001) ? 8'b11000011 :
                   (address == 7'b0110010) ? 8'b11000011 :
                   (address == 7'b0110011) ? 8'b11100011 :
                   (address == 7'b0110100) ? 8'b11100011 :
                   (address == 7'b0110101) ? 8'b11100011 :
                   (address == 7'b0110110) ? 8'b11110011 :
                   (address == 7'b0110111) ? 8'b11011011 :
                   (address == 7'b0111000) ? 8'b11011011 :
                   (address == 7'b0111001) ? 8'b11011011 :
                   (address == 7'b0111010) ? 8'b11001111 :
                   (address == 7'b0111011) ? 8'b11000111 :
                   (address == 7'b0111100) ? 8'b11000111 :
                   (address == 7'b0111101) ? 8'b11000011 :
                   (address == 7'b0111110) ? 8'b11000011 :
                   (address == 7'b0111111) ? 8'b10000001 :

                   // Character: X (for full extension)
                   (address == 7'b1000000) ? 8'b10000001 :
                   (address == 7'b1000001) ? 8'b11000011 :
                   (address == 7'b1000010) ? 8'b11000011 :
                   (address == 7'b1000011) ? 8'b01100110 :
                   (address == 7'b1000100) ? 8'b01100110 :
                   (address == 7'b1000101) ? 8'b00111100 :
                   (address == 7'b1000110) ? 8'b00111100 :
                   (address == 7'b1000111) ? 8'b00011000 :
                   (address == 7'b1001000) ? 8'b00011000 :
                   (address == 7'b1001001) ? 8'b00111100 :
                   (address == 7'b1001010) ? 8'b00111100 :
                   (address == 7'b1001011) ? 8'b01100110 :
                   (address == 7'b1001100) ? 8'b01100110 :
                   (address == 7'b1001101) ? 8'b11000011 :
                   (address == 7'b1001110) ? 8'b11000011 :
                   (address == 7'b1001111) ? 8'b10000001 :

                   // Character: L (for looped movement)
                   (address == 7'b1010000) ? 8'b10000000 :
                   (address == 7'b1010001) ? 8'b11000000 :
                   (address == 7'b1010010) ? 8'b11000000 :
                   (address == 7'b1010011) ? 8'b11000000 :
                   (address == 7'b1010100) ? 8'b11000000 :
                   (address == 7'b1010101) ? 8'b11000000 :
                   (address == 7'b1010110) ? 8'b11000000 :
                   (address == 7'b1010111) ? 8'b11000000 :
                   (address == 7'b1011000) ? 8'b11000000 :
                   (address == 7'b1011001) ? 8'b11000000 :
                   (address == 7'b1011010) ? 8'b11000000 :
                   (address == 7'b1011011) ? 8'b11000000 :
                   (address == 7'b1011100) ? 8'b11000000 :
                   (address == 7'b1011101) ? 8'b11000000 :
                   (address == 7'b1011110) ? 8'b11111110 :
                   (address == 7'b1011111) ? 8'b11111111 :

                   // Character: J (for jumpscare)
                   (address == 7'b1100000) ? 8'b01111111 :
                   (address == 7'b1100001) ? 8'b00111110 :
                   (address == 7'b1100010) ? 8'b00001100 :
                   (address == 7'b1100011) ? 8'b00001100 :
                   (address == 7'b1100100) ? 8'b00001100 :
                   (address == 7'b1100101) ? 8'b00001100 :
                   (address == 7'b1100110) ? 8'b00001100 :
                   (address == 7'b1100111) ? 8'b00001100 :
                   (address == 7'b1101000) ? 8'b00001100 :
                   (address == 7'b1101001) ? 8'b00001100 :
                   (address == 7'b1101010) ? 8'b00001100 :
                   (address == 7'b1101011) ? 8'b00001100 :
                   (address == 7'b1101100) ? 8'b11001100 :
                   (address == 7'b1101101) ? 8'b11001100 :
                   (address == 7'b1101110) ? 8'b01111100 :
                   (address == 7'b1101111) ? 8'b00111000 :
                                             8'b00000000 : // Here we have empty spaces in ROM
                                             8'b00000000;  // Reminder that if not enabled,
                                                           // output black for rest of screen

endmodule
