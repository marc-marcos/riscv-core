module rec_calc(
    input [16:0] valA,
    input [3:0] op,
    input clk,
    input reset,
    output [16:0] result
);
    
    logic [16:0] valB;
    logic [16:0] out;

    always @(posedge clk) begin
        if (reset) begin
            valB <= 'b0;
            out <= 'b0;
        end

        else begin
            valB <= out;

            out <= op == 3 ? valA / valB : op == 2 ? valA * valB : op == 1 ? valA - valB : valA + valB;
        end
    end


    assign result = out;

endmodule
