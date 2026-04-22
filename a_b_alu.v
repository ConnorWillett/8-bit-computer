module a_b_alu(
	clock,
	bus, a_in,
	a_out,
	a_clear,
	a_reset,
	b_in,
	b_out,
	b_clear,
	b_reset,
	alu_out,
	subtract
);

 
	input clock;
	inout [7:0] bus;


	input a_in;
	input a_out;
	input a_clear;
	input a_reset;
	reg [7:0] a_reg;
	input b_in;
	input b_out;
	input b_clear;
	input b_reset;
	reg [7:0] b_reg;
	input alu_out;
	input subtract;
	wire [7:0] alu_value;


	always @(posedge clock)
	begin
		if (a_reset || a_clear)
		begin
			a_reg <= 8'h00;
		end
		if (a_in)
		begin
			a_reg <= bus;
		end
	end


	always @(posedge clock)
	begin
		if (b_reset || b_clear)
		begin
			b_reg <= 8'h00;
		end
		if (b_in)
		begin
			b_reg <= bus;
		end
	end


	assign alu_value = subtract == 0 ? a_reg + b_reg : a_reg - b_reg;

	assign bus = a_out   ? a_reg  :
             b_out   ? b_reg     :
             alu_out ? alu_value :
             8'bz;

endmodule