module computer(
	input clock,
	input reset_btn,
	input fast_clock, 
	inout wire [7:0] bus,
	output MI, 
	output RI, 
	output RO, 
	output HLT,
	output CLR,
	output [6:0] SS_Out,
	output [2:0] SS_Sel,
	output NEG, 
	output wire [3:0] led
);
					
	wire Counter_Clear; 
	wire Output_Clear; 


	wire Reset;

	wire [15:0] control_word;


	assign MI = control_word[14];
	assign RI = control_word[13];
	assign RO = control_word[12];
	assign HLT = ~control_word[15];




	programCounter pc(
		.bus(bus),
		.clock(clock),
		.counter_en(Enable_Counter),
		.counter_out(Counter_Out),
		.counter_in(Counter_In),
		.clear(Counter_Clear),
		.reset(~reset),
		.led(LED),
    );



	wire [7:0] inst_reg_to_ctrl;


	instruction_register ir(
		.clk(clock),
		.bus(bus),
		.reset(Reset),
		.read(control_word[10]),
		.write(control_word[11]),
		.clear(Reset), 
		.instruction(inst_reg_to_ctrl)
	);

	control_logic ctrl(
		.clock(clock),
		.reset(Reset),
		.ctrl_word(control_word),
		.instruction(inst_reg_to_ctrl)
	);



	reg b_disable = 1'b0;

	a_b_alu ab_alu(
		.clock(clock),
		.bus(bus),
		.a_in(control_word[5]),
		.a_out(control_word[6]),
		.a_clear(Reset), 
		.a_reset(Reset), 
		.b_in(control_word[2]),
  
		.b_out(b_disable),
		.b_clear(Reset), 
		.b_reset(Reset), 
		.alu_out(control_word[4]),
		.subtract(control_word[3])
);


	output_register out(
		.clock(clock),
		.fast_clock(fast_clock),
		.clear(Output_Clear),
		.bus(bus),
		.input_en(control_word[1]),
		.display(SS_Out),
		.display_en(SS_Sel)
	);

	assign Reset = ~reset_btn;			

endmodule