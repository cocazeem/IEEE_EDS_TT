`default_nettype none
`timescale 1ns / 1ps

module reaction_timer (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       ena,
    input  wire [7:0] ui_in,
    output reg  [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe
);

    reg running;

    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    always @(posedge clk) begin

        if (!rst_n) begin
            uo_out <= 8'd0;
            running <= 1'b0;
        end

        else if (ena) begin

            // START
            if (ui_in[0]) begin
                running <= 1'b1;
            end

            // STOP
            if (ui_in[1]) begin
                running <= 1'b0;
            end

            // Count while running
            if (running && !ui_in[1]) begin
                if (uo_out != 8'hFF)
                    uo_out <= uo_out + 1'b1;
            end

        end
    end

endmodule

`default_nettype wire

