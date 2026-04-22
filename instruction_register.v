module instruction_register(
    input clk,
    input reset,
    inout wire [7:0] bus,
    input read,
    input write,
    input clear,
    output reg [7:0] instruction
    );
    
    always @(posedge clk) begin
        if (reset || clear)
            instruction <= 8'h00;
        else if (read)
            instruction <= bus;
    end
    
    assign bus = write ? instruction : 8'bz;


endmodule