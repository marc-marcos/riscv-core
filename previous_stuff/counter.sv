module counter(
    input clk,
    input reset,
    output [16:0] out
);

    logic [16:0] counter;

    always @(posedge clk) begin
        if (reset) begin
            counter <= 16'b0;
        end else begin
            counter <= counter + 1;
        end
    end

    assign out = counter;

endmodule
