module programCounter(
    inout wire [7:0] bus,
    input clock,
    input counter_en,
    input counter_out,
    input counter_in,
    input clear,
    input reset,
    output reg [3:0] led
    );
    reg [3:0] counter;

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            counter <= 4'b0;
        end
        else begin
            led[3] <= ~counter[0];
            led[2] <= ~counter[1];
            led[1] <= ~counter[2];
            led[0] <= ~counter[3];

            if (clear) begin
                counter <= 0;
            end
            else if (counter_in) begin
                counter <= bus[3:0];
            end
            else if (counter_en) begin
                counter <= counter + 1;
            end
        end
    end

    assign bus = counter_out ? {4'b0, counter} : 8'bz;

endmodule