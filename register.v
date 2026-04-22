module register(
	bus,
	clk,
	data_in,
	data_out,
	clr
);

	inout wire [7:0] bus;
	input clk;
	input data_in;
	input data_out;
	input clr;

	reg [7:0] data;

	always @(posedge clk or posedge clr)
	begin
		if (clr)
		begin
			data <= 8'h00;
		end
		else if (data_in)
		begin
			data <= bus;
		end
		
	end
	assign bus = data_out ? data : 8'bz;
	
endmodule