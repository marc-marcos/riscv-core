module fibonacci(
    input clk,
    input reset,
    output [16:0] out
    );

    logic [16:0] ant;
    logic [16:0] tmp;
    logic [16:0] ant2;

    always @(posedge clk) begin
        if (reset) begin
            ant <= 'b1;
            ant2 <= 'b1;
        end

        else begin
            tmp <= ant;
            ant <= ant + ant2;
            ant2 <= ant;
        end
    end

    assign out = ant2;

endmodule
