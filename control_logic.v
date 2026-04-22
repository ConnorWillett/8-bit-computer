module control_logic(
    input clock,
    input reset,
    output reg [15:0] ctrl_word,
    input [7:0] instruction
    );
    
   reg [2:0] count = 3'b0;
   reg count_clear = 1'b0;

	always @(negedge clock or posedge reset) begin
		if (reset)                                  
			count <= 3'b0;
		else if (count_clear || count == 3'd4)      
			count <= 3'b0;
		else
			count <= count + 1;
	end
    
	wire [2:0] count_wire;
   assign count_wire = count;
    
   wire [6:0] address;
   assign address = {instruction[7:4], count};
    
    
   always @(*) begin
		case (address)
				7'b0000000: ctrl_word = 16'h4200;
				7'b0000001: ctrl_word = 16'h1480;
            7'b0001000: ctrl_word = 16'h4200;
            7'b0001001: ctrl_word = 16'h1480;
            7'b0001010: ctrl_word = 16'h4800;
            7'b0001011: ctrl_word = 16'h1020;
            7'b0010000: ctrl_word = 16'h4200;
            7'b0010001: ctrl_word = 16'h1480;
            7'b0010010: ctrl_word = 16'h4800;
            7'b0010011: ctrl_word = 16'h1004;
            7'b0010100: ctrl_word = 16'h0030;
            7'b0011000: ctrl_word = 16'h4200;
            7'b0011001: ctrl_word = 16'h1480;
            7'b0011010: ctrl_word = 16'h0042;
            7'b1111000: ctrl_word = 16'h4200;
            7'b1111001: ctrl_word = 16'h1480;
            7'b1111010: ctrl_word = 16'h8000;
            7'b0100000: ctrl_word = 16'h4200;
            7'b0100001: ctrl_word = 16'h1480;
            7'b0100010: ctrl_word = 16'h4800;
            7'b0100011: ctrl_word = 16'h1004;
            7'b0100100: ctrl_word = 16'h0038;
            7'b0101000: ctrl_word = 16'h4200;
            7'b0101001: ctrl_word = 16'h1480;
            7'b0101010: ctrl_word = 16'h0804;
            7'b0101011: ctrl_word = 16'h0030;
            7'b0110000: ctrl_word = 16'h4200;
            7'b0110001: ctrl_word = 16'h1480;
            7'b0110010: ctrl_word = 16'h0900;
            7'b0111000: ctrl_word = 16'h4200;
            7'b0111001: ctrl_word = 16'h1480;
            7'b0111010: ctrl_word = 16'h4800;
            7'b0111011: ctrl_word = 16'h2040;
            7'b1000000: ctrl_word = 16'h4200;
            7'b1000001: ctrl_word = 16'h1480;
            7'b1000010: ctrl_word = 16'h0002;
            default: ctrl_word = 16'h0000;
        endcase
    end

    
endmodule